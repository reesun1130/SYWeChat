/**
 * This file is part of the SYRefreshTable package.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 743523983@qq.com>
 *
 * For more information, please view SYRefreshTable (https://github.com/reesun1130/SYRefreshTable)
 */

#import <UIKit/UIKit.h>

@interface SYTableHeaderView : UIView

@property (nonatomic, weak) IBOutlet UILabel *title;
@property (nonatomic, weak) IBOutlet UILabel *time;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (strong, nonatomic) UIImageView *arrowImageView;

/**
 *  准备动画
 */
- (void)readyForRefresh;

/**
 *  取消动画
 */
- (void)cancleForRefresh;

/**
 *  开始动画
 */
- (void)beginForRefresh;

/**
 *  动画结束
 */
- (void)endForRefresh;

@end
