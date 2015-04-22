/**
 * This file is part of the SYCore Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYCore (https://github.com/reesun1130/SYCore)
 *
 */

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface SYToast : NSObject

+ (void)showActiveMessage:(NSString *)message withBackground:(BOOL)backG;
+ (void)hideActiveHud;
+ (void)showSubActiveMessage:(NSString *)message withBackground:(BOOL)backG inView:(UIView *)view;
+ (void)hideSubActiveHud;
+ (void)show:(NSString*)message inView:(UIView *)view;
+ (void)showCheckmarkViewWithMessage:(NSString *)message inView:(UIView *)view;
+ (void)showCheckmarkViewWithWaitMessage:(NSString *)message inView:(UIView *)view;

@end
