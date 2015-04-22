/**
 * This file is part of the SYCore Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYCore (https://github.com/reesun1130/SYCore)
 *
 */

#import <Foundation/Foundation.h>

@interface NSFileManager (SYCore)

- (NSString *)cacheDirectoryPath;
- (NSString *)documentsDirectoryPath;

- (BOOL)createFileAtPath:(NSString *)path intermediate:(BOOL)intermediate;
- (BOOL)createFileAtPath:(NSString *)path contents:(NSData *)data intermediate:(BOOL)intermediate;

@end
