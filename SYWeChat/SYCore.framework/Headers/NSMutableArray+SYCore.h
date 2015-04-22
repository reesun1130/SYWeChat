/**
 * This file is part of the SYCore Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYCore (https://github.com/reesun1130/SYCore)
 *
 */

#import <Foundation/Foundation.h>

@interface NSMutableArray (SYCore)

/*
 * Adding and removing entries
 */
- (id)addObjectIfNotNil:(id)object;
- (id)addNonEqualObjectIfNotNil:(id)object;
- (id)addNonIdenticalObjectIfNotNil:(id)object;
- (id)insertObject:(id)object atIndexIfNotNil:(NSUInteger)index;
- (id)moveObjectAtIndex:(NSUInteger)index toIndex:(NSUInteger)toIndex;
- (void)removeFirstObject;

/*
 * Ordering and filtering
 */
- (void)shuffle;
- (void)reverse;
- (void)unique;

/*
 * Stack
 */
- (id)push:(id)object;
- (id)pop;

/*
 * Queue
 */
- (id)enqueue:(id)object;
- (id)dequeue;

- (NSString *)jsonString;

@end
