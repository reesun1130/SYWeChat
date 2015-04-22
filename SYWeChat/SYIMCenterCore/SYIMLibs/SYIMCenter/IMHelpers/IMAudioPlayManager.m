/**
 * This file is part of the SYIMKit Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYIMKit (https://github.com/reesun1130/SYIMKit)
 */

#import "IMAudioPlayManager.h"

@implementation IMAudioPlayManager

- (id)init
{
    if(self = [super init])
    {
        self.playMode = IMAudioPlayManagerModeAuto;
        self.mState = IMAudioPlayManagerStateStoped;
        _playQueue = dispatch_queue_create("PlayQueue", NULL);
        
        IsOnPlayQueueOrTargetQueueKey = &IsOnPlayQueueOrTargetQueueKey;
        
        void *nonNullUnusedPointer = (__bridge void *)self;
        dispatch_queue_set_specific(_playQueue, IsOnPlayQueueOrTargetQueueKey, nonNullUnusedPointer, NULL);
    }
    return self;
}

- (void)dealloc
{
    if(self.curMsg != nil)
    {
        [self.curMsg removeObserver:self forKeyPath:@"procState"];
        [self.curMsg removeObserver:self forKeyPath:@"playState"];
        [self.curMsg stopAudio];
        
        self.curMsg = nil;
    }
    self.indexMsg = nil;
    self.dataSource = nil;

    //dispatch_release(_playQueue);
}

- (void)playMsg:(IMAudioMsg *)msg
{
    dispatch_block_t block = ^{
        
        if(!msg.fromself)
            self.indexMsg = msg;
        
        self.mState = IMAudioPlayManagerStatePlaying;
        
        [_curMsg removeObserver:self forKeyPath:@"procState"];
        [_curMsg removeObserver:self forKeyPath:@"playState"];
        [_curMsg stopAudio];
        
        self.curMsg = msg;
        
        //readState
        [self.curMsg addObserver:self forKeyPath:@"playState" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
        [self.curMsg addObserver:self forKeyPath:@"procState" options:NSKeyValueObservingOptionNew context:nil];
        
        
        if(self.curMsg.procState == IMMsgProcStateSuc || (self.curMsg.fromself == YES && [self.curMsg.localPath length] > 0))
        {
            [self.curMsg playAudio];
            [self downLoadNextAudioMsg:self.indexMsg];
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.curMsg downLoadFile];
            });
        }
    };
    
    if(dispatch_get_specific(IsOnPlayQueueOrTargetQueueKey))
    {
        block();
    }
    else
    {
        dispatch_async(_playQueue, block);
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"procState"])
    {
        
#if DEBUG
        NSLog(@"testnew::%@", [change objectForKey:NSKeyValueChangeNewKey]);
#endif
        
        if(dispatch_get_specific(IsOnPlayQueueOrTargetQueueKey))
        {
            [self procStateChanged];
        }
        else
        {
            dispatch_async(_playQueue, ^{
                [self procStateChanged];
            });
        }
    }
    else if([keyPath isEqualToString:@"playState"])
    {
        NSNumber *n = [change objectForKey:NSKeyValueChangeNewKey];
        NSNumber *o = [change objectForKey:NSKeyValueChangeOldKey];
        
#if DEBUG
        NSLog(@"playState:%@:%@", n, o);
#endif
        
        if([n integerValue] == IMMsgPlayStatePlayed && [o integerValue] == IMMsgPlayStatePlaying)
        {
            if(dispatch_get_specific(IsOnPlayQueueOrTargetQueueKey))
            {
                [self playStateChanged];
            }
            else
            {
                dispatch_async(_playQueue, ^{
                    [self playStateChanged];
                });
            }
        }
    }
}

- (void)procStateChanged
{
    if(self.mState != IMAudioPlayManagerStatePlaying)
        return;
    
    if(self.curMsg.procState == IMMsgProcStateSuc)
    {
        [self.curMsg playAudio];
        [self downLoadNextAudioMsg:self.indexMsg];
    }
}

- (void)playNextFromSelf:(BOOL)flag
{
    if((_playMode == IMAudioPlayManagerModeAuto || _playMode == IMAudioPlayManagerModeSelectStartOrStop) && [_dataSource respondsToSelector:@selector(imAudioPlayManagerGetNextMsg:includeSelf:)])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            IMAudioMsg *tmpMsg = [_dataSource imAudioPlayManagerGetNextMsg:self.indexMsg includeSelf:flag];
            if(tmpMsg == nil)//没有更多消息，就暂停
            {
                self.mState = IMAudioPlayManagerStatePauseForNew;
            }
            else
                [self playMsg:tmpMsg];
        });
    }
    else
    {
        self.mState = IMAudioPlayManagerStateStoped;
    }
}

- (void)downLoadNextAudioMsg:(IMAudioMsg *)indexMsg
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if([_dataSource respondsToSelector:@selector(imAudioPlayManagerGetNextMsg:includeSelf:)])
        {
            IMAudioMsg *tmpMsg = [_dataSource imAudioPlayManagerGetNextMsg:indexMsg includeSelf:NO];
            if(tmpMsg.fromself == NO && tmpMsg.procState == IMMsgProcStateFaied)
            {
                [tmpMsg downLoadFile];
            }
        }
    });
}

- (void)playStateChanged
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"stopAudio" object:nil];
    });
    
    if(self.mState != IMAudioPlayManagerStatePlaying)
    {
#if DEBUG
        NSLog(@"AudioPlayManager Stoped!");
#endif
        
        return;
    }
    
    if(self.curMsg.playState == IMMsgPlayStatePlayed)
    {
#if DEBUG
        NSLog(@"get Next");
#endif
        
        [self playNextFromSelf:YES];
    }
}

- (void)deliverMsg:(IMAudioMsg *)msg
{
    dispatch_block_t block = ^{
        if(msg.fromself)
            return;
        
#if DEBUG
        NSLog(@"deliverMsg");
#endif
        
        if(self.mState == IMAudioPlayManagerStatePauseForNew)//新来消息，启动
        {
            [self playMsg:msg];
        }
    };
    
    if(dispatch_get_specific(IsOnPlayQueueOrTargetQueueKey))
    {
        block();
    }
    else
    {
        dispatch_async(_playQueue, block);
    }
}

- (IMAudioMsg *)currentMsg
{
    if(self.mState == IMAudioPlayManagerStatePlaying)
        return self.curMsg;
    return nil;
}

- (void)selectMsg:(IMAudioMsg *)msg
{
    dispatch_block_t block = ^{
        if(msg == nil)
            return;
        
        if(self.mState == IMAudioPlayManagerStatePlaying)
        {
            if(msg == self.curMsg)
            {
                if(msg.playState == IMMsgPlayStatePlaying)
                {
                    [msg stopAudio];
                }
                else if(msg.procState == IMMsgProcStateProcessing)
                {
                    
                    [self playNextFromSelf:NO];
                    
                }
                else
                {
                    [self playMsg:msg];
                }
            }
            else
                [self playMsg:msg];
        }
        else
            [self playMsg:msg];
    };
    
    if(dispatch_get_specific(IsOnPlayQueueOrTargetQueueKey))
    {
        block();
    }
    else
    {
        dispatch_async(_playQueue, block);
    }
}

- (void)startPlay
{
    dispatch_block_t block = ^{
        if(self.playMode == IMAudioPlayManagerModeOne)
            return;
        
        if(self.mState == IMAudioPlayManagerStateStoped)
        {
            [self playNextFromSelf:YES];
        }
    };
    
    if(dispatch_get_specific(IsOnPlayQueueOrTargetQueueKey))
    {
        block();
    }
    else
    {
        dispatch_async(_playQueue, block);
    }
}

- (void)stopPlay
{
    dispatch_block_t block = ^{
        self.mState = IMAudioPlayManagerStateStoped;
        [self.curMsg stopAudio];
    };
    
    if(dispatch_get_specific(IsOnPlayQueueOrTargetQueueKey))
    {
        block();
    }
    else
    {
        dispatch_async(_playQueue, block);
    }
}

- (void)pausePlay
{
    dispatch_block_t block = ^{
        if(self.curMsg.playState == IMMsgPlayStatePlaying)
            [self.curMsg pauseAudio];
        else
        {
            [self stopPlay];
        }
    };
    
    if(dispatch_get_specific(IsOnPlayQueueOrTargetQueueKey))
    {
        block();
    }
    else
    {
        dispatch_async(_playQueue, block);
    }
}

- (void)resumePlay
{
    dispatch_block_t block = ^{
        if(self.curMsg.playState == IMMsgPlayStatePause)
            [self.curMsg resumeAudio];
        else
        {
            [self startPlay];
        }
    };
    
    if(dispatch_get_specific(IsOnPlayQueueOrTargetQueueKey))
    {
        block();
    }
    else
    {
        dispatch_async(_playQueue, block);
    }
}

@end
