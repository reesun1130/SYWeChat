/**
 * This file is part of the SYIMKit Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYIMKit (https://github.com/reesun1130/SYIMKit)
 */

#import <Foundation/Foundation.h>
#import "IMAudioPlayManager.h"
#import "IMMessage.h"

static NSString *const kIMMsgQueueChanged = @"kIMMsgQueueChanged";
//static NSString *const kIMMsgOldMsgLoaded = @"kIMMsgOldMsgLoaded";

//时间标志 间隔时间
#define kGROUP_SEC 60 * 3
#define kHISTROYNUM 10

@interface IMMsgQueue : NSObject <IMAudioPlayManagerDataSource>
{
	IMAudioPlayManagerMode _qmode;
	dispatch_queue_t msgQueue;
}

@property (nonatomic, copy) NSString *groupTime;
@property (nonatomic, strong) NSMutableArray *displayMsgArray;
@property (nonatomic, strong) SoftwareUser *from;

- (id)initWithMode:(IMAudioPlayManagerMode)mode fromUser:(SoftwareUser *)user;
- (BOOL)deliverMsg:(IMMessage *)msg;
- (NSArray *)deleteMsg:(IMMessage *)msg;
- (void)addSelfMsg:(IMMessage *)msg;
- (void)selectMsg:(IMMessage *)msg;
- (void)startAudioPlay;
- (void)stopAudioPlay;
- (void)pauseAudioPlay;
- (void)resumeAudioPlay;
//- (BOOL)beginLoadHistroy;

@end
