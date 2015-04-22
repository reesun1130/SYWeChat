/**
 * This file is part of the SYIMKit Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYIMKit (https://github.com/reesun1130/SYIMKit)
 */

#import <UIKit/UIKit.h>
#import "UIBadgeView.h"
#import <SYIMKit/SYTTTAttributedLabel.h>

#define kIMCellMaxTopPading 6

//@class IMChatRecordMsg;

@interface IMPrivateCenterCell : UITableViewCell <SYTTTAttributedLabelDelegate>

@property (nonatomic, strong) UIButton *headImageV;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) SYTTTAttributedLabel *detailLabel;
@property (nonatomic, strong) UILabel *timeLable;
@property (nonatomic, strong) UIBadgeView *badgeBtn;

//@property (nonatomic, retain) IMChatRecordMsg *msg;

@property (nonatomic, copy) void (^IMPrivateCenterCellLongPressBlock)(IMPrivateCenterCell *cell);

- (void)addBadgeBtnTitleNum:(NSString *)title;
- (void)clearBadgeBtnTitle;

@end
