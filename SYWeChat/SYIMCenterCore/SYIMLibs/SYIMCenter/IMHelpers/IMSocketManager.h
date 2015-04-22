/**
 * This file is part of the SYIMKit Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYIMKit (https://github.com/reesun1130/SYIMKit)
 */

//#import "GCDAsyncSocket.h"
#import <Foundation/Foundation.h>

@class IMMessage;
@class IMSocketManager;
@class SoftwareUser;

extern NSString * const kIMSocketDidConnectedNotification;
extern NSString * const kIMSocketOfflinedNotification;

@interface IMSocketManager : NSObject
{
    NSMutableArray *privateChatFileArr;
    NSLock *privateChatFileArrLock;
    
@private
    IMMessage *tempMsg;
}

+ (IMSocketManager *)sharedManager;

/*
 发送消息
 */
- (BOOL)sendMessage:(IMMessage *)messageModel;

@end
