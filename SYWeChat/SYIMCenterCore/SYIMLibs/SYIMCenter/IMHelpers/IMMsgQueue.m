/**
 * This file is part of the SYIMKit Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYIMKit (https://github.com/reesun1130/SYIMKit)
 */

#import "IMMsgQueue.h"
#import "IMPicMsg.h"
#import "IMPrvAudioPlayManager.h"

@interface IMMsgQueue()

@property (nonatomic, strong) IMAudioPlayManager *audioPlayManager;
@property (nonatomic, strong) IMAudioMsg *myAudioMsg;

@end

@implementation IMMsgQueue

- (id)initWithMode:(IMAudioPlayManagerMode)mode fromUser:(SoftwareUser *)user
{
	if((self = [super init]))
	{
		self.displayMsgArray = [[NSMutableArray alloc] initWithCapacity:0];
        
		self.groupTime = nil;
		self.from = user;
		
        _qmode = mode;
		
        msgQueue = dispatch_queue_create("msgQueue", NULL);
		      
		if(mode == IMAudioPlayManagerModeAuto || mode == IMAudioPlayManagerModeOne)
		{
            //self.isFromChatRoom = YES;
            
			self.audioPlayManager = [[IMAudioPlayManager alloc] init];
			self.audioPlayManager.dataSource = self;
			self.audioPlayManager.playMode = mode;
			
			IMAudioMsg *audioMsg = [self findAudioMsgFrom:0];
            
			if(audioMsg != nil)
			{
				[self.audioPlayManager selectMsg:audioMsg];
			}
			else
			{
				self.audioPlayManager.mState = IMAudioPlayManagerStatePauseForNew;
			}
		}
		else
		{
            //self.isFromChatRoom = NO;

			self.audioPlayManager = [[IMPrvAudioPlayManager alloc] init];
			self.audioPlayManager.dataSource = self;
		}
        
        //[self loadRecentHistoryMsg];
	}
	return self;
}

- (void)dealloc
{
    //dispatch_release(msgQueue);
    self.audioPlayManager = nil;
    self.myAudioMsg = nil;
    self.displayMsgArray = nil;
    //_lastMsg = nil;
    self.from = nil;
    self.groupTime = nil;
    
    //self.isFromChatRoom = NO;
}

- (NSString *)getFirstMsgId
{
	for(id obj in self.displayMsgArray)
	{
		if([obj isKindOfClass:[IMMessage class]])
		{
			IMMessage *mg = (IMMessage *)obj;
			return mg.msgflag;
		}
	}
	return nil;
}

- (void)addGroupLabel:(IMMessage *)msg
{
	if(_groupTime == nil)
	{
		self.groupTime = [msg.SendTime substringToIndex:10];
		[self.displayMsgArray addObject:_groupTime];
	}
	else
	{
        int distance = (int)difftime([[msg.SendTime substringToIndex:10] doubleValue], [self.groupTime doubleValue]);
        
        distance = abs(distance);

		if(distance > kGROUP_SEC)
		{
			self.groupTime = [msg.SendTime substringToIndex:10];
			[self.displayMsgArray addObject:_groupTime];
		}
	}
}

- (BOOL)deliverMsg:(IMMessage *)msg
{
	//self.lastMsg = msg;

	//add group Label
	[self addGroupLabel:msg];
	
	[self.displayMsgArray addObject:msg];
	
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:kIMMsgQueueChanged object:msg];
	});

    //加入播放
	if([msg isMemberOfClass:[IMAudioMsg class]])
	{
		[self.audioPlayManager deliverMsg:(IMAudioMsg *)msg];
	}
	
	if([msg isMemberOfClass:[IMPicMsg class]])
	{
		IMPicMsg *picMsg = (IMPicMsg *)msg;
		[picMsg downLoadFile];
	}
	return YES;
}

- (void)addSelfMsg:(IMMessage *)msg
{
	//self.lastMsg = msg;
	
	[self addGroupLabel:msg];
	[self.displayMsgArray addObject:msg];
	
	//加入播放
	if([msg isMemberOfClass:[IMAudioMsg class]])
	{
		[self.audioPlayManager deliverMsg:(IMAudioMsg *)msg];
	}

	dispatch_async(dispatch_get_main_queue(), ^{
		[[NSNotificationCenter defaultCenter] postNotificationName:kIMMsgQueueChanged object:msg];
	});
}

- (NSArray *)deleteMsg:(IMMessage *)msg
{
	NSInteger idx = [self.displayMsgArray indexOfObject:msg];
	id labobj = nil;
	NSMutableArray *array = nil;
	if(idx != NSNotFound)
	{
		array = [NSMutableArray array];
		NSInteger laidx = idx -1;
		if(laidx >= 0 && laidx < [self.displayMsgArray	count])
		{
			id obj = [self.displayMsgArray objectAtIndex:laidx];
			if([obj isKindOfClass:[NSString class]])
			{
				labobj = obj;
				[array addObject:[NSIndexPath indexPathForRow:laidx inSection:0]];
			}
		}
		[array addObject:[NSIndexPath indexPathForRow:idx inSection:0]];
	}
	
	[self.displayMsgArray removeObject:msg];
	[self.displayMsgArray removeObject:labobj];
	
    if(labobj == self.groupTime)
		self.groupTime = nil;
    
	//[[[Common sharedInstance] dbManager] delMsg:msg];
    
    [self deleteFileMsg:msg];
	
	return array;
}

- (void)deleteFileMsg:(IMMessage *)msg
{
    if ([msg isMemberOfClass:[IMAudioMsg class]] || [msg isMemberOfClass:[IMPicMsg class]])
    {
        IMFileMsg *temp_msg = (IMFileMsg *)msg;
        [temp_msg deleteFile];
    }
}

- (void)selectMsg:(IMMessage *)msg
{
	IMAudioMsg *aMsg = (IMAudioMsg *)msg;
	[self.audioPlayManager selectMsg:aMsg];
}

- (void)startAudioPlay
{
	[self.audioPlayManager startPlay];
}

- (void)stopAudioPlay
{
	[self.audioPlayManager stopPlay];
}

- (void)pauseAudioPlay
{
	[self.audioPlayManager pausePlay];
}

- (void)resumeAudioPlay
{
	[self.audioPlayManager resumePlay];
}

- (IMAudioMsg *)findAudioMsgFrom:(NSInteger)index
{
	IMAudioMsg *ret = nil;
    
	for(NSInteger i = index; i < [self.displayMsgArray count]; i++)
	{
		id tmp = [self.displayMsgArray objectAtIndex:i];
		if([tmp isMemberOfClass:[IMAudioMsg class]])
		{
			IMAudioMsg *t = (IMAudioMsg *)tmp;
			if(t.playState == IMMsgPlayStateUnPlay && t.fromself == NO)
			{
				ret = t;
				break;
			}
		}
	}
    
#if DEBUG
	NSLog(@"%@", ret);
#endif

	return ret;
}

- (IMAudioMsg *)imAudioPlayManagerGetNextMsg:(IMAudioMsg *)msg includeSelf:(BOOL)flag
{
	NSInteger n = [self.displayMsgArray indexOfObject:msg];
	
    if(n == NSNotFound)
		return nil;
	
    if(!flag)
		n++;
    
	return [self findAudioMsgFrom:n];
}

@end
