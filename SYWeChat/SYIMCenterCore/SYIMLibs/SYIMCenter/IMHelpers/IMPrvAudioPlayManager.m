/**
 * This file is part of the SYIMKit Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYIMKit (https://github.com/reesun1130/SYIMKit)
 */

#import "IMPrvAudioPlayManager.h"

@implementation IMPrvAudioPlayManager

- (id)init
{
    if(self = [super init])
    {
        self.playMode = IMAudioPlayManagerModeSelectStartOrStop;
        self.mState = IMAudioPlayManagerStateStoped;
    }
    return self;
}

- (void)deliverMsg:(IMAudioMsg *)msg
{
    if(msg.fromself)
        return;
    
#if DEBUG
    NSLog(@"deliverMsg ignore");
#endif
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
                    self.mState = IMAudioPlayManagerStateStoped;
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

@end
