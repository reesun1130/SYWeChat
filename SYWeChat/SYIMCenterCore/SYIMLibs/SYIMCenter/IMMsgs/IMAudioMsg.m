/**
 * This file is part of the SYIMKit Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYIMKit (https://github.com/reesun1130/SYIMKit)
 */

#import "IMAudioMsg.h"
#import <SYCore/SYCore.h>
#import "SYMainHeader.h"

@implementation IMAudioMsg

- (id)init
{
	if (self = [super init])
	{
		self.MesType = IMMsgTypeAudio;
		self.fromself = NO;
	}
	return self;
}

- (void)dealloc
{
    [self.audioPlayer stop];
    self.audioPlayer.delegate = nil;
    self.audioPlayer = nil;
    
    self.audioPath = nil;
    self.audioURL = nil;
}

- (void)generateLoaclPath
{
    if (self.fileURL)
    {
        NSString *filePath = [kCachesPath stringByAppendingPathComponent:self.fileURL];
        
        [SYIMSharedTool createFileDoc:filePath];
        
        self.localPath = filePath;
    }
    else
    {
        NSString *filePath = [kCachesPath stringByAppendingPathComponent:[self.msgUser createRelateRandAudioPath]];
        [SYSharedTool createFileDoc:filePath];
        
        self.localPath = filePath;
    }
}

- (long)audioFileLength
{
    if (self.fromself == NO) {
        return self.msgSize;
    }

	long sc = (self.msgSize / AMR_FRAME_COUNT_PER_SECOND);
	long padsc = (self.msgSize % AMR_FRAME_COUNT_PER_SECOND) < 25 ? 0 : 1;
    
	return sc = sc + padsc;	
}

- (void)setAudioTimeLengthWithFramesLength:(NSUInteger)length
{
    self.audioTimeLength = MAX(length / AMR_FRAME_COUNT_PER_SECOND, 1);
}

- (void)playAudio
{
	dispatch_async(dispatch_get_main_queue(), ^{
        
        if(self.localPath == nil || [self.localPath length] <= 0)
        {
            SYLog(@"play audio path [nil]");
            
            return;
        }
        self.audioPlayer = [[IMAudioPlayer alloc] initWithPath:self.localPath];
        self.audioPlayer.delegate = self;
        [self.audioPlayer play];
	});
}

- (void)stopAudio
{
	dispatch_async(dispatch_get_main_queue(), ^{
		[self.audioPlayer stop];
	});
}

- (void)pauseAudio
{
	dispatch_async(dispatch_get_main_queue(), ^{
        [self.audioPlayer pause];
	});
}

- (void)resumeAudio
{
	dispatch_async(dispatch_get_main_queue(), ^{
		[self.audioPlayer resume];
    });
}


#pragma mark -
#pragma mark syaudio delegate

- (void)IMAudioPlayerDidStarted:(IMAudioPlayer *)player
{
	self.playState = IMMsgPlayStatePlaying;
}

- (void)IMAudioPlayerDidPaused:(IMAudioPlayer *)player
{
	self.playState = IMMsgPlayStatePause;
    //[[[Common sharedInstance] dbManager] updatePlayState:IMMsgPlayStatePlayed user:self.msgUser msgid:self.msgflag];
}

- (void)IMAudioPlayerDidResumed:(IMAudioPlayer *)player
{
	self.playState = IMMsgPlayStatePlaying;
}

- (void)IMAudioPlayerDidEnded:(IMAudioPlayer *)player
{
    self.playState = IMMsgPlayStatePlayed;
    //[[[Common sharedInstance] dbManager] updatePlayState:IMMsgPlayStatePlayed user:self.msgUser msgid:self.msgflag];
    //[[UserSessionManager sharedSessionManager].dbManager updatePlayState:self.playState user:self.fromUser msgid:self.msgID];
}

@end
