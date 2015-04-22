/**
 * This file is part of the SYIMKit Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYIMKit (https://github.com/reesun1130/SYIMKit)
 */

#import "SYMainHeader.h"

@implementation SYSystemManager

static SYSystemManager *sharedS = nil;

+ (SYSystemManager *)sharedSManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedS = [[[self class] alloc] init];
    });
    
    return sharedS;
}

- (id)init
{
    if (self = [super init])
    {
    }
    
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone
{
    SYSystemManager *theCopy = [[[self class] allocWithZone:zone] init];
    [theCopy setUser:[self.user copy]];
    
    return theCopy;
}

- (instancetype)mutableCopyWithZone:(NSZone *)zone
{
    SYSystemManager *theCopy = [[[self class] allocWithZone:zone] init];
    [theCopy setUser:[self.user copy]];
    
    return theCopy;
}

- (void)setUser:(SoftwareUser *)user
{
    _user = nil;
    _user = user;
    //[user sySaveToFile:[[SYSystemManager sharedSManager] getUserInfoCachePath]];
}

- (NSString *)getUserWorkPath
{
    NSString *prefix = [NSString stringWithFormat:@"/%@",_user.UserId];
    NSString *path = [kUserWorkBasedPath stringByAppendingPathComponent:prefix];
    
    if(![[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return path;
}

- (NSString *)getUserInfoCachePath
{
    return [kUserWorkBasedPath stringByAppendingPathComponent:@"/tempInfo.user"];
}

- (void)destroyUserInfo
{
    [SYSettings destroySettingByKey:kAutoLoginNotifyKey];
}

- (NSString *)createPcenterHeaderPicPath
{
    return [kDocumentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_header.jpg",_user.UserId]];
    
    //return [NSString stringWithFormat:@"/%@/Header/header.jpg",[[UserModel sharedUser] getUserWorkPath]];
}

- (void)destroySYSystemInfo
{
    [SYSettings destroySettingByKey:kAutoLoginNotifyKey];
    [SYSystemManager sharedSManager].user = nil;
}

@end
