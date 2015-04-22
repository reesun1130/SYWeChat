/**
 * This file is part of the SYIMKit Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYIMKit (https://github.com/reesun1130/SYIMKit)
 */

#import "IMMessage.h"

@implementation IMMessage

- (id)init
{
	if((self = [super init]))
	{
        self.SendTime =  [NSString stringWithFormat:@"%ld",(long)[[NSDate date] timeIntervalSince1970]];

		_readState = IMMsgReadStateUnRead;
		_procState = IMMsgProcStateUnproc;
		_playState = IMMsgPlayStateUnPlay;
		_MesType = IMMsgTypeText;
	}
	return self;
}


- (void)dealloc
{
    self.fromUser = nil;
    self.msgUser = nil;
    
    self.SendTime = nil;
    self.Content = nil;
    self.msgflag = nil;
    self.Flag = nil;
    self.SessionId = nil;
    self.RelationType = nil;
    self.RelationId = nil;
}

- (void)readMsg
{
	_readState = IMMsgReadStateReaded;
	//DB
}

- (void)saveMsg
{
    //
}

@end
