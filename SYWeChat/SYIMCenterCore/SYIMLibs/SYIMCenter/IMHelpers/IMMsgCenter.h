/**
 * This file is part of the SYIMKit Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYIMKit (https://github.com/reesun1130/SYIMKit)
 */

#import <Foundation/Foundation.h>
#import "IMAudioMsg.h"
#import "IMPicMsg.h"
#import "IMMsgQueue.h"

@interface IMMsgCenter : NSObject
{
	dispatch_queue_t _proQueue;
}

@property (nonatomic, strong) NSDate *recordChangeTime;
@property (nonatomic, strong) SoftwareUser *pchatUser;
@property (nonatomic) BOOL isRecording;

+ (IMMsgCenter *)sharedIMMsgCenter;
+ (IMMessage *)generateIMMsg:(IMMsgType)type;

- (void)receiveMsg:(IMMessage *)msg;
//- (void)receiveOfflineMsg:(NSArray *)msgArr;

- (void)sendMsg:(IMMessage *)msg;
- (void)reSendFailMsg:(IMMessage *)msg;

- (IMMsgQueue *)privateMsgQueueWithUser:(SoftwareUser *)imUser;
- (void)leavePrivateMsgQueueWithUser:(SoftwareUser *)imUser;

@end
