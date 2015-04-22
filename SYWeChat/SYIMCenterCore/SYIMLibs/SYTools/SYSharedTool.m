/**
 * This file is part of the SYIMKit Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYIMKit (https://github.com/reesun1130/SYIMKit)
 */

#import "SYSharedTool.h"
#import "SYNormalDefineHeader.h"
#import "Reachability.h"
#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>
#import <SYCore/SYTKAlertCenter.h>

@implementation SYSharedTool

static SYSharedTool *appShared = nil;
+ (SYSharedTool *)sharedTool
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appShared = [[[self class] alloc] init];
    });
    
    return appShared;
}

- (id)init
{
    if (self = [super init])
    {
    }
    
    return self;
}

+ (id)showAlertWithTitle:(NSString *)atitle message:(NSString *)amsg cancleTitle:(NSString *)acantitle okTitle:(NSString *)oktitle delegate:(id)adelegate
{
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
    UIAlertController *alerVC = [UIAlertController alertControllerWithTitle:atitle message:amsg preferredStyle:UIAlertControllerStyleAlert];
    
    if (acantitle)
    {
        UIAlertAction *actCancle = [UIAlertAction actionWithTitle:acantitle style:UIAlertActionStyleCancel handler:nil];
        
        [alerVC addAction:actCancle];
    }
    
    return alerVC;
#else
        UIAlertView *alerV = [[UIAlertView alloc] initWithTitle:atitle message:amsg delegate:adelegate cancelButtonTitle:acantitle otherButtonTitles:oktitle, nil];
        [alerV show];
        
        return alerV;
#endif
}


#pragma mark -
#pragma mark 监测网络联通状况

//网络连接检测
+ (BOOL)isNetWorkActive
{
    //判断网络连接
    BOOL isExistNetwork = FALSE;
    
    Reachability *r = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    
    switch ([r currentReachabilityStatus])
    {
        case NotReachable:
            isExistNetwork = FALSE;
            //SYLog(@"没有连接网络");
            break;
        case ReachableViaWWAN:
            isExistNetwork = TRUE;
            //SYLog(@"连接3G网络");
            break;
        case ReachableViaWiFi:
            isExistNetwork = TRUE;
            //SYLog(@"连接WiFi网络");
            break;
        default:
            isExistNetwork = FALSE;
            break;
    }
    return isExistNetwork;
}


#pragma mark -
#pragma mark 弹窗

+ (void)showTostWithMsg:(NSString *)aMsg
{
    [[SYTKAlertCenter defaultCenter] postAlertWithMessage:aMsg];
}

+ (void)showToastSuccessWithMsg:(NSString *)aMsg
{
    [[SYTKAlertCenter defaultCenter] postAlertWithMessage:aMsg image:[UIImage imageNamed:@"37x-Checkmark"]];
}

+ (void)showToastFailWithMsg:(NSString *)aMsg
{
    [[SYTKAlertCenter defaultCenter] postAlertWithMessage:aMsg image:[UIImage imageNamed:@"37x-Checkmark-Error"]];
}

+ (void)showAlertWithMsg:(NSString *)aMsg
{
    id gfAlert = [SYSharedTool showAlertWithTitle:nil message:aMsg cancleTitle:@"确定" okTitle:nil delegate:nil];
    
    if ([gfAlert isKindOfClass:[UIAlertView class]])
    {
    }
    else
    {
        [[kAppDelegate window].rootViewController presentViewController:gfAlert animated:YES completion:nil];
    }
}

@end
