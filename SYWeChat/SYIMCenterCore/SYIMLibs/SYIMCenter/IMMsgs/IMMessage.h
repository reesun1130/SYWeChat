/**
 * This file is part of the SYIMKit Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYIMKit (https://github.com/reesun1130/SYIMKit)
 */

#import <Foundation/Foundation.h>

@class SoftwareUser;

typedef NS_ENUM(NSInteger, IMMsgReadState)
{
	IMMsgReadStateUnRead = 0,
	IMMsgReadStateReaded
};

typedef NS_ENUM(NSInteger, IMMsgProcState)
{
	IMMsgProcStateSuc = 0,
	IMMsgProcStateUnproc,
	IMMsgProcStateProcessing,
	IMMsgProcStateFaied
};

typedef NS_ENUM(NSInteger, IMMsgPlayState)
{
	IMMsgPlayStateUnPlay = 0,
	IMMsgPlayStatePlaying,
	IMMsgPlayStatePause,
	IMMsgPlayStatePlayed
};

typedef NS_ENUM(NSInteger, IMMsgType)
{
	IMMsgTypeText = 1,
	IMMsgTypePic,
    IMMsgTypeAudio,
    IMMsgTypeLocation,
	IMMsgTypeFile,
    IMMsgTypeSystem
};

@interface IMMessage : NSObject

@property (copy, nonatomic) NSString *msgflag;
@property (copy, nonatomic) NSString *Content;
@property (copy, nonatomic) NSString *Flag;
@property (copy, nonatomic) NSString *SendTime;
@property (copy, nonatomic) NSString *SessionId;
@property (copy, nonatomic) NSString *RelationType;
@property (copy, nonatomic) NSString *RelationId;
@property (copy, nonatomic) NSString *Id;

@property (assign, nonatomic) BOOL fromself;

/////
//@property (copy, nonatomic) NSString *cmd;

@property NSInteger msgSize;

@property IMMsgType MesType;
@property IMMsgReadState readState;
@property IMMsgProcState procState;
@property IMMsgPlayState playState;

@property (nonatomic, strong) SoftwareUser *fromUser;
@property (nonatomic, strong) SoftwareUser *msgUser;

@end
