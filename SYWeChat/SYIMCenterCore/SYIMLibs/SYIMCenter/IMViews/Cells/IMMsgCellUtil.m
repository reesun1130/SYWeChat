/**
 * This file is part of the SYIMKit Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYIMKit (https://github.com/reesun1130/SYIMKit)
 */

#import "IMMsgCellUtil.h"

@implementation IMMsgCellUtil

+ (CGFloat)cellHeightForMsg:(id)msg
{
	if([msg isMemberOfClass:[IMTextMessage class]])
	{        
        return [IMTextMsgCell heightForCellWithMsg:msg];
	}
    else if([msg isMemberOfClass:[IMAudioMsg class]])
	{
		return [IMAudioMsgCell heightForCellWithMsg:msg];
	}
	else if([msg isMemberOfClass:[IMPicMsg class]])
	{
		return [IMPicMsgCell heightForCellWithMsg:msg];
	}
	else
	{
		return 24.0f;
	}
}

+ (UITableViewCell *)tableView:(UITableView *)tableView cellForMsg:(id)msg
{
	IMMsgCell *cell = nil;
    
	if([msg isMemberOfClass:[IMTextMessage class]])
	{
        static NSString *CellIdentifier_IMTextMsg = @"IMTextMsg";
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier_IMTextMsg];
        
        if(cell == nil)
        {
            cell = [[IMTextMsgCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier_IMTextMsg];
        }
		
		cell.msg = msg;
	}
	else if([msg isMemberOfClass:[IMAudioMsg class]])
	{
        static NSString *CellIdentifier_IMAudioMsg = @"IMAudioMsg";

		cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier_IMAudioMsg];
        
		if(cell == nil)
		{
			cell = [[IMAudioMsgCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier_IMAudioMsg];
		}
		
		cell.msg = msg;
	}
    else if([msg isMemberOfClass:[IMPicMsg class]])
	{
        static NSString *CellIdentifier_IIMPicMsg = @"IMPicMsg";

		cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier_IIMPicMsg];
        
		if(cell == nil)
		{
            cell = [[IMPicMsgCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier_IIMPicMsg];
		}
		cell.msg = msg;
	}
	else if([msg isKindOfClass:[NSString class]])
	{
		IMTimeCell *cell1 = nil;
        static NSString *CellIdentifier_ITimeLabel = @"TimeLabel";

		cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier_ITimeLabel];
		if(cell1 == nil)
		{
			cell1 = [[IMTimeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier_ITimeLabel];
		}
		cell1.msgTime = (NSString *)msg;
		return cell1;
	}
    
    return cell;
}

@end
