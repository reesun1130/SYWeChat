/**
 * This file is part of the SYIMKit Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYIMKit (https://github.com/reesun1130/SYIMKit)
 */

#import <SYCore/SYObjectBase.h>
#import "SoftwareUser.h"

@interface SYSystemManager : SYObjectBase

@property (strong, nonatomic) SoftwareUser *user;

+ (SYSystemManager *)sharedSManager;

/**
 *  用户工作目录
 *
 *  @return 路径
 */
- (NSString *)getUserWorkPath;

/**
 *  用户信息缓存
 *
 *  @return 路径
 */
- (NSString *)getUserInfoCachePath;

/**
 *  个人头像本地缓存路径
 *
 *  @return 本地路径
 */
- (NSString *)createPcenterHeaderPicPath;

/**
 *  销毁系统信息
 */

- (void)destroySYSystemInfo;

@end
