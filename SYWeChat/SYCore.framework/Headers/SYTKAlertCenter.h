/**
 * This file is part of the SYCore Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYCore (https://github.com/reesun1130/SYCore)
 *
 */
/**
 *此文件由ree sun修改，fix bugs
 *获得支持请联系 QQ:1507602555 EMAIL:ree.sun.cn@hotmail.com
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class SYTKAlertView;

/** A notification center for displaying quick bursts of alert information to the user. */
@interface SYTKAlertCenter : NSObject {
	NSMutableArray *_alerts;
	BOOL _active;
	SYTKAlertView *_alertView;
	CGRect _alertFrame;
}

/** Returns the process’s default notification center. 
 @return The current process’s default notification center, which is used for alert notifications.
 */
+ (SYTKAlertCenter*) defaultCenter;


/** Posts a given alert message to the user.
 @param message The message shown under an image.
 @param image The image displayed to the user. If image is nil, the message will only be shown.
 */
- (void) postAlertWithMessage:(NSString*)message image:(UIImage*)image;

/** Posts a given alert message to the user.
 @param message The message shown under an image.
 */
- (void) postAlertWithMessage:(NSString *)message;

@end