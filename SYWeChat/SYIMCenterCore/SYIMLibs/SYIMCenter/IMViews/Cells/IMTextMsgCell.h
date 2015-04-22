/**
 * This file is part of the SYIMKit Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYIMKit (https://github.com/reesun1130/SYIMKit)
 */

#import "IMMsgCell.h"
#import <SYIMKit/SYTTTAttributedLabel.h>

@interface IMTextMsgCell : IMMsgCell

@property (nonatomic, strong) SYTTTAttributedLabel *textView;
@property (nonatomic, strong) UIButton *textBgBtnView;
@property (nonatomic, strong) UIActivityIndicatorView *activityView;

@end
