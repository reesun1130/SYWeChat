/**
 * This file is part of the SYCore Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYCore (https://github.com/reesun1130/SYCore)
 *
 */

#import <Foundation/Foundation.h>

@interface NSDate (SYCore)

+ (id)dateWithISO8601Date:(NSString *)inDateString;
+ (id)dateWithYYYYMMDD:(NSString *)inDateString;
+ (id)dateWithYYYYMMDDhhmmss:(NSString *)inDateString;

- (NSString *)toISO8601;
- (NSString *)toYYYYMMDD;
- (NSString *)toYYYYMMDDhhmmss;

- (NSDateComponents *)dateComponents;

/*
 * Comparing
 */
- (BOOL)isEarlierThanDate:(NSDate *)dt;
- (BOOL)isLaterThanDate:(NSDate *)dt;

- (BOOL)isSameYearAsDate:(NSDate *)dt;
- (BOOL)isSameMonthAsDate:(NSDate *)dt;
- (BOOL)isSameDayAsDate:(NSDate *)dt;

- (BOOL)isToday;

@end
