/**
 * This file is part of the SYIMKit Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYIMKit (https://github.com/reesun1130/SYIMKit)
 */

#import "IMMsgCenter.h"
#import "SYMainHeader.h"
#import "IMSocketManager.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import <SYIMKit/SYIMSharedTool.h>

static IMMsgCenter *sharedCenter = nil;

@interface IMMsgCenter()

@property (nonatomic, strong) IMMsgQueue *userQueue;

@end

@implementation IMMsgCenter

+ (IMMsgCenter *)sharedIMMsgCenter
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedCenter = [[[self class] alloc] init];
    });
    
	return sharedCenter;
}

- (id)init
{
	if((self = [super init]))
	{
		//[self initAudioSession];
	}
	return self;
}

- (void)dealloc
{
    self.recordChangeTime = nil;
    //self.roomUser = nil;
    self.pchatUser = nil;
    //self.roomInfo = nil;
    //self.roomQueue = nil;
    self.userQueue = nil;
}

+ (IMMessage *)generateIMMsg:(IMMsgType)type
{
    NSString *timeNow = [NSString stringWithFormat:@"%ld",(long)[[NSDate date] timeIntervalSince1970]];

    IMMessage *msg;
    
    if (type == IMMsgTypeText)
    {
       msg = [[IMTextMessage alloc] init];
    }
    else if (type == IMMsgTypePic)
    {
        msg = [[IMPicMsg alloc] init];
    }
    else if (type == IMMsgTypeAudio)
    {
        msg = [[IMAudioMsg alloc] init];
    }
    
    msg.MesType = type;
    msg.SendTime = timeNow;
    msg.msgflag = [SYIMSharedTool generateUUID];
    msg.msgUser = [SYSystemManager sharedSManager].user;
    msg.fromself = YES;
    
    return msg;
}

- (void)updateChatRecordList:(IMMessage *)msg
{
	//[[[Common sharedInstance] dbManager] saveInChatRecord:msg];

	self.recordChangeTime = [NSDate date];
}

- (void)receiveOfflineMsg:(NSArray *)msgArr
{
    if (msgArr == nil || msgArr.count == 0) {
        return;
    }    
}

- (void)receiveMsg:(IMMessage *)msg
{
	if(msg == nil)
		return;
	
	//[[[Common sharedInstance] dbManager] saveMsg:msg];
	
	BOOL flag = NO;
    
    if([self.pchatUser isEqual:msg.fromUser])
    {
        flag = [self.userQueue deliverMsg:msg];
    }

    if(flag)
        msg.readState = IMMsgReadStateReaded;
    
	SYLog(@"recvice msg:%@", msg);
    
	if(!flag) //不再聊天界面，提示新消息
	{
		//[self playUserNewMsgAudio];
	}
}

- (void)sendMsg:(IMMessage *)msg
{
	SYLog(@"send Msg:%@", msg);
    
	//[[[Common sharedInstance] dbManager] saveMsg:msg];

    if(self.userQueue != nil)
    {
        [self.userQueue addSelfMsg:msg];
        [[IMSocketManager sharedManager] sendMessage:msg];
    }
    
    [self updateChatRecordList:msg];
    [self playUserMsgSendAudio:nil];
}

- (void)reSendFailMsg:(IMMessage *)msg
{
    if(self.userQueue != nil)
    {
        [[IMSocketManager sharedManager] sendMessage:msg];
    }
}


#pragma mark -
#pragma mark PrivateMsg

- (IMMsgQueue *)privateMsgQueueWithUser:(SoftwareUser *)imUser
{
    if([imUser isEqual:self.pchatUser])
    {
        if(self.userQueue != nil)
            return self.userQueue;
    }
    self.userQueue = [[IMMsgQueue alloc] initWithMode:IMAudioPlayManagerModeSelectStartOrStop fromUser:imUser];
    self.pchatUser = imUser;
    
    //[[[Common sharedInstance] dbManager] resetReadNum:imUser];
    
    self.recordChangeTime = [NSDate date];
    
    return self.userQueue;
}

- (void)leavePrivateMsgQueueWithUser:(SoftwareUser *)imUser
{
    if([imUser isEqual:self.pchatUser])
    {
        //[Common sharedInstance].pCount = 0;
        //[[NSNotificationCenter defaultCenter] postNotificationName:kRefreshIMCenterMainView object:@"205"];
        
        [self.userQueue stopAudioPlay];
        
        self.pchatUser = nil;
    }
}

- (void)playUserMsgSendAudio:(SoftwareUser *)fromUser
{
    static SystemSoundID soundIDSend = 0;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"sendmsg" ofType:@"caf"];
    
    if (path)
    {
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &soundIDSend);
    }
    
    AudioServicesPlaySystemSound(soundIDSend);
}

@end
