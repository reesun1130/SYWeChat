/**
 * This file is part of the SYCore Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYCore (https://github.com/reesun1130/SYCore)
 *
 */

#import <Foundation/Foundation.h>

#define kMessageNotifyKey @"MessageNotify"
#define kSoundNotifyKey @"SoundNotify"
#define kWIFINotifyKey @"WIFINotify"
#define kNoticeNotifyKey @"NoticeNotify"
#define kRemLoginNotifyKey @"RemLogin"
#define kRemPWDNotifyKey @"RemPWD"
#define kRemUKeyNotifyKey @"RemUKey"
#define kAutoLoginNotifyKey @"AutoLoginNotify"
#define kUserGuideNotifyKey @"UserGuideNotify"
#define kBaseUrlNotifyKey @"BaseUrlNotifyKey"

@interface SYSettings : NSObject

+ (void)initializeVTSetting;

+ (void)setShouldNotifyWhenMessageComing:(BOOL)shouldMessage;
+ (BOOL)shouldNotifyWhenMessageComming;

+ (void)setShouldNotifyWithSound:(BOOL)shouldSound;
+ (BOOL)shouldNotifyWithSound;

+ (void)setShouldNotifyWIFI:(BOOL)shouldWIFI;
+ (BOOL)shouldNotifyWIFI;

+ (void)setShouldNotifyNotice:(NSString *)shouldNotice;
+ (NSString *)shouldNotifyNotice;

+ (void)setShouldNotifyRemLogin:(NSString *)shouldRemLogin;
+ (NSString *)shouldNotifyRemLogin;

+ (void)setShouldNotifyRemPWD:(NSString *)shouldRemPWD;
+ (NSString *)shouldNotifyRemPWD;

//+ (void)setShouldNotifyRemUKey:(NSString *)shouldRemUKey;
+ (NSString *)shouldNotifyRemUKey;

+ (void)setShouldNotifyAutoLogin:(BOOL)shouldAutoLogin;
+ (BOOL)shouldNotifyAutoLogin;

+ (void)setShowUserGuide:(BOOL)shouldGuide;
+ (BOOL)showUserGuide;

+ (void)setShouldNotifyBaseUrl:(NSString *)shouldBaseUrl;
+ (NSString *)shouldNotifyBaseUrl;

+ (void)destroySetting;
+ (void)destroySettingByKey:(NSString *)key;

@end
