/**
 * This file is part of the SYIMKit Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYIMKit (https://github.com/reesun1130/SYIMKit)
 */

#import <SYCore/SYObjectBase.h>

@interface IMChatRecordMsg : SYObjectBase

@property (nonatomic, copy) NSString *Id;
@property (nonatomic, copy) NSString *ObjectId;
@property (nonatomic, copy) NSString *ObjectName;
@property (nonatomic, copy) NSString *ObjectPhoto;
@property (nonatomic, copy) NSString *ObjectUserType;

@property (nonatomic, copy) NSString *SendId;
@property (nonatomic, copy) NSString *SendName;
@property (nonatomic, copy) NSString *SendPhoto;
@property (nonatomic, copy) NSString *SendUserType;

@property (copy, nonatomic) NSString *Content;
@property (copy, nonatomic) NSString *Flag;
@property (copy, nonatomic) NSString *RelationId;
@property (copy, nonatomic) NSString *SendTime;
@property (copy, nonatomic) NSString *SessionId;
@property (copy, nonatomic) NSString *RelationType;
@property (copy, nonatomic) NSString *MesType;

@property (nonatomic, assign) int unReadCount;

@end
