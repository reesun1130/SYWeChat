/**
 * This file is part of the SYCore Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYCore (https://github.com/reesun1130/SYCore)
 *
 */

#import <Foundation/Foundation.h>

@interface NSArray (SYCore)

/*
 * Querying
 */
- (id)objectOrNilAtIndex:(NSUInteger)i;
- (id)firstObject;
- (id)randomObject;

/*
 * Ordering and filtering
 */
- (NSArray *)shuffledArray;
- (NSArray *)reversedArray;
- (NSArray *)uniqueArray;

/*
 * json
 */

- (NSString *)jsonString;

@end
