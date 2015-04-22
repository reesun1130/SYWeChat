//
//  SYIMSharedTool.h
//  kuakao
//
//  Created by sunbb on 14-11-5.
//  Copyright (c) 2014年 KUAKAO.COM. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, SYTimeStyle) {
    SYTimeStyleShort = 0,
    SYTimeStyleLong,
    SYTimeStyleMsg
};

@interface SYIMSharedTool : NSObject

@property (strong, nonatomic) NSDateFormatter *dateFormatter;

+ (SYIMSharedTool *)sharedTool;

//+ (BOOL)isNetWorkActive;

//生成唯一标示符
+ (NSString *)generateUUID;

//版本号 build
+ (NSString *)getAppVersionBuild;

//版本号 short
+ (NSString *)getAppVersionShort;

//解析信息
+ (id)parserInfo:(id)info;

/**
 *  判断摄像头是否可用
 */
+ (BOOL)isAVCaptureActive;

/**
 *  设置时间格式 默认SYTimeStyleLong
 */

- (NSString *)generateTime:(NSTimeInterval)timeInterval;

/**
 *  设置时间格式
 */

- (NSString *)generateTime:(NSTimeInterval)timeInterval style:(SYTimeStyle)style;


#pragma mark -
#pragma mark 文件操作

/**
 *  创建文件目录
 *
 *  @param filePath 路径
 */
+ (void)createFileDoc:(NSString *)filePath;

/**
 *  删除文件
 *
 *  @param path 路径
 */
+ (void)deleteFileAtPath:(NSString *)path;

/**
 *  手机号正则表达式 
 *
 *
 */

+ (BOOL)checkMobileNumber:(NSString *)checkStr;

/**
 *  密码正则表达式 密码 6-20个 数字、字母、下划线
 *
 *
 */

+ (BOOL)checkUPwd:(NSString *)checkStr;

/**
 *  获取文件大小
 */

+ (long)getFileSize:(NSString *)path;

@end
