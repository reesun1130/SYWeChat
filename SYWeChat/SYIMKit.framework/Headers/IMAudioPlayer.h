/**
 * This file is part of the SYIMKit Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYIMKit (https://github.com/reesun1130/SYIMKit)
 */

#import <AudioToolbox/AudioQueue.h>
#import <AudioToolbox/AudioToolbox.h>
#import "SYAmr2wavBuffer.h"

#define kNUM_QUEUE_BUFFERS 3
#define kNumAQBufs 6
#define kAQBufSize 32 * 1024
#define kAQMaxPacketDescs 512 

typedef enum SYPLAYERSTAT
{
    SYPLAYERSTATSTOP = 0,
    SYPLAYERSTATPREPARE,
    SYPLAYERSTATPLAYING,
    SYPLAYERSTATPAUSE,
}SYPLAYERSTAT;

@protocol IMAudioPlayerDelegate;

@interface IMAudioPlayer : NSObject
{
    AudioQueueRef queue;
    AudioQueueBufferRef buffers[kNUM_QUEUE_BUFFERS];
    
    SYAmr2wavBuffer *_wavbuf;
    
    AudioStreamBasicDescription dataFormat;
    AudioStreamPacketDescription *packetDescs;
    
    UInt64 packetIndex;
    UInt32 numPacketsToRead;
        
    BOOL trackEnded;
}

@property (nonatomic, assign) id <IMAudioPlayerDelegate> delegate;

@property (nonatomic, readonly) SYPLAYERSTAT mstat;
@property (nonatomic, copy) NSString *amrPath;
@property (nonatomic, strong) id userInfo;

- (id)initWithPath:(NSString *)path;
- (int)prepare;
- (int)play;
- (void)stop;
- (void)pause;
- (void)resume;

@end

@protocol IMAudioPlayerDelegate <NSObject>

@optional

- (void)IMAudioPlayerDidStarted:(IMAudioPlayer *)player;
- (void)IMAudioPlayerDidEnded:(IMAudioPlayer *)player;
- (void)IMAudioPlayerDidPaused:(IMAudioPlayer *)player;
- (void)IMAudioPlayerDidResumed:(IMAudioPlayer *)player;
- (void)IMAudioPlayerDidFail:(IMAudioPlayer *)player;

@end
