/**
 * This file is part of the SYRefreshTable package.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 743523983@qq.com>
 *
 * For more information, please view SYRefreshTable (https://github.com/reesun1130/SYRefreshTable)
 */

#import <UIKit/UIKit.h>

@interface SYTableFooterView : UIView

@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, weak) IBOutlet UIButton *infoBtn;

@property (nonatomic, copy) void (^loadMoreBlock)(void);//在点击加载更多按钮时处理相关事件

/**
 *  准备加载更多
 */
- (void)readyForLoadMore;

/**
 *  开始加载更多
 */
- (void)beginForLoadMore;

/**
 *  加载完毕
 */
- (void)endForLoadMore;

@end
