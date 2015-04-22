/**
 * This file is part of the SYIMKit Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYIMKit (https://github.com/reesun1130/SYIMKit)
 */

#import <UIKit/UIKit.h>

@interface IMTimeCell : UITableViewCell
{
	UIImageView *_bgImageView;
	UILabel *_timeLabel;
}
@property (nonatomic, copy) NSString *msgTime;

@end
