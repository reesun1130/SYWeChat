/**
 * This file is part of the SYCore Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYCore (https://github.com/reesun1130/SYCore)
 *
 */

#import <UIKit/UIKit.h>

@interface UIWindow (SYCore)

/**
 * Searches the view hierarchy recursively for the first responder, starting with this window.
 */
- (UIView*)findFirstResponder;

/**
 * Searches the view hierarchy recursively for the first responder, starting with topView.
 */
- (UIView*)findFirstResponderInView:(UIView*)topView;

@end
