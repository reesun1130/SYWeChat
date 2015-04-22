/**
 * This file is part of the SYIMKit Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYIMKit (https://github.com/reesun1130/SYIMKit)
 */

#import <UIKit/UIKit.h>

#define kSYMenuViewHeight 120

@protocol SYMenuViewDelegate;

@interface SYMenuView : UIView

@property (nonatomic, assign) id <SYMenuViewDelegate> delegate;

@end

@protocol SYMenuViewDelegate <NSObject>

@optional

- (void)syMenuViewSelectedPhoto:(SYMenuView *)menuView;
- (void)syMenuViewSelectedCamera:(SYMenuView *)menuView;
- (void)syMenuViewSelectedLocation:(SYMenuView *)menuView;

@end