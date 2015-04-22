/**
 * This file is part of the SYIMKit Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYIMKit (https://github.com/reesun1130/SYIMKit)
 */

#import <Foundation/Foundation.h>
#import "SoftwareUser.h"
#import <SYIMKit/SYIMSharedTool.h>

@interface SYSharedTool : SYIMSharedTool

+ (SYSharedTool *)sharedTool;

+ (id)showAlertWithTitle:(NSString *)atitle message:(NSString *)amsg cancleTitle:(NSString *)acantitle okTitle:(NSString *)oktitle delegate:(id)adelegate;

+ (BOOL)isNetWorkActive;

//tost
+ (void)showTostWithMsg:(NSString *)aMsg;
+ (void)showToastSuccessWithMsg:(NSString *)aMsg;
+ (void)showToastFailWithMsg:(NSString *)aMsg;

//alert
+ (void)showAlertWithMsg:(NSString *)aMsg;

@end
