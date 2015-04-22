/**
 * This file is part of the SYCore Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYCore (https://github.com/reesun1130/SYCore)
 *
 */

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (SYCore)

- (void)setObject:(id)object forKeyIfNotNil:(id)key;

- (NSString *)jsonString;

@end
