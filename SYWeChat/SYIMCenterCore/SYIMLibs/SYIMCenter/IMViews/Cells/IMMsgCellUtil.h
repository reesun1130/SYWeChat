/**
 * This file is part of the SYIMKit Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYIMKit (https://github.com/reesun1130/SYIMKit)
 */

#import <Foundation/Foundation.h>

#import "IMTextMessage.h"
#import "IMPicMsg.h"
#import "IMAudioMsg.h"

#import "IMTextMsgCell.h"
#import "IMTimeCell.h"
#import "IMPicMsgCell.h"
#import "IMAudioMsgCell.h"

@interface IMMsgCellUtil : NSObject

+ (CGFloat)cellHeightForMsg:(id)msg;
+ (UITableViewCell *)tableView:(UITableView *)tableView cellForMsg:(id)msg;

@end
