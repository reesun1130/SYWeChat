/**
 * This file is part of the SYIMKit Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYIMKit (https://github.com/reesun1130/SYIMKit)
 */

#import <Foundation/Foundation.h>

@interface SYIMMsgTool : NSObject

+ (NSMutableArray *)getAssembleArrayWithStr:(NSString *)msgstr;
+ (BOOL)isFaceStr:(NSString *)str;
+ (NSArray *)getFaceArray;
+ (NSString *)getFaceImageWithStr:(NSString *)str;

@end
