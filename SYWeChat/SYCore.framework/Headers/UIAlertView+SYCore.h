/**
 * This file is part of the SYCore Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYCore (https://github.com/reesun1130/SYCore)
 *
 */

@import UIKit;

@interface UIAlertView (SYCore) <UIAlertViewDelegate>

- (id)initWithTitle:(NSString *)title block:(void (^)(NSInteger))completion;
- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle block:(void (^)(NSInteger))completion;

@end
