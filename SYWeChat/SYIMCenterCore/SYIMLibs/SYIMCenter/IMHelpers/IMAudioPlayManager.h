/**
 * This file is part of the SYIMKit Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYIMKit (https://github.com/reesun1130/SYIMKit)
 */

#import <Foundation/Foundation.h>
#import "IMAudioMsg.h"

typedef NS_ENUM(NSInteger, IMAudioPlayManagerMode)
{
	IMAudioPlayManagerModeAuto = 0,
	IMAudioPlayManagerModeOne,
	IMAudioPlayManagerModeSelectStartOrStop,
};

typedef NS_ENUM(NSInteger, IMAudioPlayManagerState)
{
	IMAudioPlayManagerStateStoped = 0,
	IMAudioPlayManagerStatePlaying,
	IMAudioPlayManagerStatePauseForNew,
};

@protocol IMAudioPlayManagerDataSource;

@interface IMAudioPlayManager : NSObject
{
	dispatch_queue_t _playQueue;
    void *IsOnPlayQueueOrTargetQueueKey;
}

@property IMAudioPlayManagerMode playMode;
@property IMAudioPlayManagerState mState;
@property (nonatomic, strong) IMAudioMsg *curMsg;
@property (nonatomic, strong) IMAudioMsg *indexMsg;
@property (nonatomic, assign) id <IMAudioPlayManagerDataSource> dataSource;

- (void)deliverMsg:(IMAudioMsg *)msg;
- (void)selectMsg:(IMAudioMsg *)msg;
- (void)startPlay;
- (void)stopPlay;
- (void)pausePlay;
- (void)resumePlay;
- (IMAudioMsg *)currentMsg;

- (void)playNextFromSelf:(BOOL)flag;
- (void)playMsg:(IMAudioMsg *)msg;

@end

@protocol IMAudioPlayManagerDataSource <NSObject>

@required

- (IMAudioMsg *)imAudioPlayManagerGetNextMsg:(IMAudioMsg *)msg includeSelf:(BOOL)flag;

@end
