/**
 * This file is part of the SYIMKit Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYIMKit (https://github.com/reesun1130/SYIMKit)
 */

#import "IMMsgCell.h"

@interface IMAudioMsgCell : IMMsgCell

@property (nonatomic, strong) UIButton *bgView;
@property (nonatomic, strong) UIActivityIndicatorView *activityView;
@property (nonatomic, strong) UIImageView *playStateView,*unReadNotice;
@property (nonatomic, strong) UILabel *secLabel;

@end
