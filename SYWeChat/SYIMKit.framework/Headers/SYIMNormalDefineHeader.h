//
//  SYIMNormalDefineHeader.h
//  kuakao
//
//  Created by sunbb on 14-11-28.
//  Copyright (c) 2014年 KUAKAO.COM. All rights reserved.
//

#ifndef kuakao_SYIMNormalDefineHeader_h
#define kuakao_SYIMNormalDefineHeader_h

//默认加载的图片
#define kDefaultDisplayImage [UIImage imageNamed:@"bg_dyUnOpen"]
#define kDefaultHeaderImage [UIImage imageNamed:@"uc_defaultHeader"]
#define kDefaultUCenterHeaderImage [UIImage imageNamed:@"uc_defaultNanNv"]

// xib加载
#define NibName(name) [[[NSBundle mainBundle] loadNibNamed:name owner:self options:nil] lastObject]

#define kMainStoryBoard kStoryBoard(@"Main")
#define kStoryBoard(name) [UIStoryboard storyboardWithName:name bundle:nil]
#define kGetControllerWithMainID(xibID) [kMainStoryBoard instantiateViewControllerWithIdentifier:xibID]
#define kGetControllerWithNormalID(storyID,xibID) [kStoryBoard(storyID) instantiateViewControllerWithIdentifier:xibID]

#define kAppDelegate (AppDelegate *)[UIApplication sharedApplication].delegate

// UserDefaults
#define UserDefSet(object,key) [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];[[NSUserDefaults standardUserDefaults] synchronize]
#define UserDefGet(key) [[NSUserDefaults standardUserDefaults] valueForKey:key]
#define UserDefRemove(key) [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];[[NSUserDefaults standardUserDefaults] synchronize]

// 颜色宏
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

/**
 *  sunbb 2014.10.15
 */

//documents目录
#define kDocumentPath [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]

//用户缓存目录(唯一性)
#define kUserWorkBasedPath [kDocumentPath stringByAppendingPathComponent:@"/Users"]
#define kCachesPath [NSHomeDirectory() stringByAppendingPathComponent:@"Library"]

//设备宽/高/坐标
#define kDeviceWidth [UIScreen mainScreen].bounds.size.width
#define KDeviceHeight [UIScreen mainScreen].bounds.size.height
#define KDeviceFrame [UIScreen mainScreen].bounds
#define kWindow [UIApplication sharedApplication].keyWindow
#define kSystemVersion [[UIDevice currentDevice].systemVersion floatValue]
#define kIOS7_OR_LATER ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)
#define kIs_IPhone5x ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define kIs_IPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define kIs_IPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1080, 1920), [[UIScreen mainScreen] currentMode].size) : NO)

#define kRGB(R,G,B,ALPHA) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:ALPHA]
#define kRGBRef(R,G,B,ALPHA) [kRGB(R,G,B,ALPHA) CGColor]

//只在debug模式下才打印日志
//release后不打印日志
#ifndef SYLog
#if DEBUG
#define SYLog(xxx, ...) NSLog((@"%s [%d行]: " xxx), __FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define SYLog(xxx, ...)
#endif
#endif

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
#define SY_TEXTSIZE(text, font) [text length] > 0 ? [text \
sizeWithAttributes:@{NSFontAttributeName:font}] : CGSizeZero;
#else
#define SY_TEXTSIZE(text, font) [text length] > 0 ? [text sizeWithFont:font] : CGSizeZero;
#endif

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
#define SY_MULTILINE_TEXTSIZE(text, font, maxSize, mode) [text length] > 0 ? [text \
boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) \
attributes:@{NSFontAttributeName:font} context:nil].size : CGSizeZero;
#else
#define SY_MULTILINE_TEXTSIZE(text, font, maxSize, mode) [text length] > 0 ? [text \
sizeWithFont:font constrainedToSize:maxSize lineBreakMode:mode] : CGSizeZero;
#endif

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
#define SY_DrawInRect(text, rect, attribute, font, mode, alignment) [text drawInRect:rect withAttributes:attribute];
#else
#define SY_DrawInRect(text, rect, attribute, font, mode, alignment) [text drawInRect:rect withFont:font lineBreakMode:mode alignment:alignment];
#endif

#endif
