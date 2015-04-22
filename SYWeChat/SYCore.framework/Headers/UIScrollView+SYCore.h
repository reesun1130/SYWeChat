/**
 * This file is part of the SYCore Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYCore (https://github.com/reesun1130/SYCore)
 *
 */

#import <UIKit/UIKit.h>

@interface UIScrollView (SYCore)

- (void)scrollToTopAnimated:(BOOL)animated;
- (void)scrollToCenterAnimated:(BOOL)animated;
- (void)scrollToBottomAnimated:(BOOL)animated;
- (void)stopScrollingAnimated:(BOOL)animated;

@end
