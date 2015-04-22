/**
 * This file is part of the SYCore Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYCore (https://github.com/reesun1130/SYCore)
 *
 */

#import <Foundation/Foundation.h>

@interface SYObjectBase : NSObject <NSCoding>

@property (nonatomic, assign) NSInteger tag;

- (BOOL)sySaveToFile:(NSString *)path;
+ (id)syLoadFromFile:(NSString *)path;

/**
 *  objc-dic,dic-objc
 */
+ (NSDictionary *)syPropertiesForClass:(Class)cls;

/** Create a new object with given class and populate it with value from dictionary
 */
+ (id)syObjectWithClass:(Class)cls fromDictionary:(NSDictionary*)dict;

@end
