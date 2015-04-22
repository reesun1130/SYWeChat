/**
 * This file is part of the SYIMKit Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYIMKit (https://github.com/reesun1130/SYIMKit)
 */

#import "IMSocketManager.h"
#import "SoftwareUser.h"
#import "IMMsgCenter.h"
#import "IMPicMsg.h"
#import "IMAudioMsg.h"
#import "SYMainHeader.h"

#import <SYCore/SYCore.h>
#import <SYIMKit/SYIMSharedTool.h>

static IMSocketManager *_gInstance = nil;
static NSString *PrivateContext = @"PrivateContext";

@implementation IMSocketManager

+ (IMSocketManager *)sharedManager
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _gInstance = [[[self class] alloc] init];
    });
    
    return _gInstance;
}

- (id)init
{
    if (self = [super init])
    {
        privateChatFileArr = [[NSMutableArray alloc] initWithCapacity:0];
        privateChatFileArrLock = [[NSLock alloc] init];
        
        SYLog(@"socket created ok");
    }
    return self;
}

- (BOOL)sendMessage:(IMMessage *)messageModel
{
    tempMsg = messageModel;

    [privateChatFileArrLock lock];
    [privateChatFileArr addObject:tempMsg];
    [tempMsg addObserver:self forKeyPath:@"procState" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionOld context:(void *)&PrivateContext];
    [privateChatFileArrLock unlock];

    if (![SYSharedTool isNetWorkActive])
    {
        tempMsg.procState = IMMsgProcStateFaied;
        
        return NO;
    }
    
    if([tempMsg isMemberOfClass:[IMMessage class]] || [tempMsg isMemberOfClass:[IMTextMessage class]])
    {
        tempMsg.procState = IMMsgProcStateProcessing;
        [self sendMsg:tempMsg];
    }
    else if([tempMsg isMemberOfClass:[IMAudioMsg class]] || [tempMsg isMemberOfClass:[IMPicMsg class]])
    {
        IMFileMsg *fileMsg = (IMFileMsg *)tempMsg;
        [fileMsg sendFile];

        return YES;
    }
    else
    {
        SYLog(@"%@ unsport!", tempMsg);
        
        return NO;
    }
    
    return YES;
}

- (void)sendMsg:(id)msg
{
    /**
     *  测试用，正常应该是你的网络请求，根据请求结果改变procState
     */
    tempMsg.procState = IMMsgProcStateSuc;
}


#pragma mark -
#pragma mark obser msgstatus

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if(context == (void *)&PrivateContext)
	{
		if([keyPath isEqualToString:@"procState"])
		{
			NSNumber *n = [change objectForKey:NSKeyValueChangeNewKey];
			NSNumber *o = [change objectForKey:NSKeyValueChangeOldKey];
            
			SYLog(@"testnew:%@:%@", n, o);
            
            /**
             *  发送到文件server后通知刷新界面，再发送url下载链接到消息服务器
             */
			if([n integerValue] == IMMsgProcStateSuc)
			{
                IMMessage *message = (IMMessage *)object;
                
                if ([message isMemberOfClass:[IMPicMsg class]] || [message isMemberOfClass:[IMAudioMsg class]])
                {
                    //[self sendMsg:message];
                }
                else
                {
                    [privateChatFileArrLock lock];
                    [privateChatFileArr removeObject:object];
                    [privateChatFileArrLock unlock];
                }
                
                [object removeObserver:self forKeyPath:@"procState" context:&PrivateContext];
			}
			else if([n integerValue] == IMMsgProcStateFaied && [o integerValue] == IMMsgProcStateProcessing)
			{
				[privateChatFileArrLock lock];
				[privateChatFileArr removeObject:object];
				[privateChatFileArrLock unlock];
			}
		}
	}
}

@end
