/**
 * This file is part of the SYCore Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYCore (https://github.com/reesun1130/SYCore)
 *
 */

#import <UIKit/UIKit.h>

@interface UIColor (SYCore)

+ (UIColor *)colorWithHexString:(NSString *)hexString;

+ (UIColor *)randomColor;

/*
 * Components
 */
- (CGFloat)red;
- (CGFloat)green;
- (CGFloat)blue;
- (CGFloat)alpha;
- (NSString *)hexString;

@end
