/**
 * This file is part of the SYIMKit Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYIMKit (https://github.com/reesun1130/SYIMKit)
 */

#import "IMMsgCell.h"
#import "MCProgressBarView.h"

@interface IMPicMsgCell : IMMsgCell

@property (nonatomic, strong) UIButton *bgView;
@property (nonatomic, strong) UIImageView *picView;
@property (nonatomic, strong) MCProgressBarView *progressBarView;

@end
