/**
 * This file is part of the SYIMKit Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYIMKit (https://github.com/reesun1130/SYIMKit)
 */

#import <UIKit/UIKit.h>
#import "IMMessage.h"
#import "SYMainHeader.h"

#define kMsgCellTopPading 8
#define kMsgCellLeftPading 8
#define kMsgCellRightPading 8
#define kMsgCellBottomPadding 8

#define kMsgCellPadding 5.0f
#define kMsgCellUserHeadViewWidth 45
#define kMsgCellUserHeadViewHeight 45
#define kMsgCellTotalWidth [UIScreen mainScreen].bounds.size.width

//userName
#define kMsgCellUserNameColor kRGB(75,75,75,1.0)
#define kMsgCellUserNameFont [UIFont systemFontOfSize:12.0f]
#define kMsgCellHeadUserSpace 6.0

//body
#define KMsgCellBodyTextFont [UIFont systemFontOfSize:14.0f]
#define kMsgCellBodyTextColor [UIColor blackColor]
#define kMsgCellBodyMaxWidth (kMsgCellTotalWidth - kMsgCellUserHeadViewWidth * 2 - kMsgCellHeadUserSpace - kMsgCellLeftPading - kMsgCellRightPading)
#define kMsgCellUserBodySpace 2.0
#define kMsgCellUserBodyBackGroundHeading 6.0f
#define kMsgCellUserBodyBackGroundHeadingW 10.0f * 1.5
#define kMsgCellUserBodyBackGroundHeadingH 7.0f * 1.5
#define kMsgCellAudioCellHeiht 29.0f + 10.0f

//pic
#define kMsgPicCellMaxWidth 90
#define kMsgPicCellMaxHeight 90

@class IMMsgCell;

@protocol IMMsgCellDelegate <NSObject>

@optional

- (void)imMsgCellBodyDidSelected:(IMMsgCell *)cell;
- (void)imMsgCellHeadDidSelected:(IMMsgCell *)cell;
- (void)imMsgCellPicDidSelected:(IMMsgCell *)cell;
- (void)imMsgCellLocationDidSelected:(IMMsgCell *)cell;
- (void)imMsgCellLongPress:(IMMsgCell *)cell;

@end

@interface IMMsgCell : UITableViewCell

@property (nonatomic, strong) UIImageView *userHeadView;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UIImageView *errorView;
@property (nonatomic, strong) IMMessage *msg;
@property (nonatomic, assign) id <IMMsgCellDelegate> delegate;

+ (CGFloat)heightForCellWithMsg:(IMMessage *)msg;
- (void)cellBodyClick:(id)sender;

@end
