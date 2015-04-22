/**
 * This file is part of the SYIMKit Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYIMKit (https://github.com/reesun1130/SYIMKit)
 */

#import "SYNavBasedController.h"

static CGFloat const leftBtnWidth = 25;
static CGFloat const leftBtnHeight = 44;
static CGFloat const rightBtnWidth = 44;
static CGFloat const rightBtnHeight = 44;

@interface SYNavBasedController ()

@end

@implementation SYNavBasedController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationItem setHidesBackButton:YES];    
    
    [self createBackBtn];
    //[self observerTheme];
}

- (id)init
{
    if (self = [super init])
    {
        [self createBackBtn];
        //[self observerTheme];
        
        //SYLog(@"--=====%s",class_getName([self class]));
    }
    
    return self;
}

- (void)dealloc
{
    @try
    {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
    @catch (NSException *exception)
    {
        // do nothing, only unregistering self from notifications
    }
}


#pragma mark -
#pragma mark 导航条、右侧按钮相关

- (void)createBackBtn
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, 0, leftBtnWidth, leftBtnHeight)];
    [btn setImage:[UIImage imageNamed:@"top_back"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backsAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBar = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [self.navigationItem setLeftBarButtonItem:backBar];
    //self.navigationItem.leftBarButtonItem = backBar;
}

- (void)createRightBtnWithTitle:(NSString *)atitle
{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setFrame:CGRectMake(0, 0, rightBtnWidth, rightBtnHeight)];
    [rightBtn setTitle:atitle forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *itemBarBtn = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    [self.navigationItem setRightBarButtonItem:itemBarBtn];
    //self.navigationItem.rightBarButtonItem = itemBarBtn;
}

- (void)createRightBtnWithImage:(NSString *)imageString
{
    UIImage *image = [UIImage imageNamed:imageString];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0.0, 0.0, image.size.width, image.size.height);
    [button addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor clearColor]];
    
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    [self.navigationItem setRightBarButtonItem:btn];
}

- (IBAction)backsAction:(id)sender
{
    //[MKNetworkEngine cancelOperationsContainingURLString:kBase_URL];
    //[MKNetworkEngine cancelOperationsContainingURLString:kBase_URL_Pre];

    if ([self.navigationController canPerformAction:@selector(popViewControllerAnimated:) withSender:sender])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

/*- (void)createRightBtnWithTitle:(NSString *)atitle
{
    if (self.topTitleLab)
    {
        CGRect frame = self.topTitleLab.frame;
        frame.origin.x += 10;
        frame.size.width -= 10 * 2;
        self.topTitleLab.frame = frame;
    }
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setFrame:CGRectMake(kDeviceWidth - backBtnWidth - 10, topBgHeight - backBtnHeight, backBtnWidth, backBtnHeight)];
    [rightBtn setTitle:atitle forState:UIControlStateNormal];
    //rightBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightBtn];
}

- (void)createRightBtnWithImage:(NSString *)imageString
{
    UIImage *image = [UIImage imageNamed:imageString];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(kDeviceWidth - backBtnWidth, topBgHeight - backBtnHeight, backBtnWidth, backBtnHeight);
    [button addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [self.view addSubview:button];
}*/

- (void)rightBtnClick
{
    //override
}


#pragma mark -
#pragma mark 提示框

- (void)showLoadingHUD
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)hideLoadingHUD
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

//提示指示符
- (void)showToastWithMessage:(NSString *)aMsg
{
    [SYSharedTool showTostWithMsg:aMsg];
    //[[TKAlertCenter defaultCenter] postAlertWithMessage:aMsg];
}

- (void)showToastSuccessWithMessage:(NSString *)aMsg
{
    [SYSharedTool showToastSuccessWithMsg:aMsg];
    //[[TKAlertCenter defaultCenter] postAlertWithMessage:aMsg image:[UIImage imageNamed:@"37x-Checkmark"]];
}

- (void)showToastFailWithMessage:(NSString *)aMsg
{
    [SYSharedTool showToastFailWithMsg:aMsg];
    //[[TKAlertCenter defaultCenter] postAlertWithMessage:aMsg image:[UIImage imageNamed:@"37x-Checkmark-Error"]];
}

- (void)showToastServerError
{
    [SYSharedTool showToastFailWithMsg:kMsg_NETWORK_SERVER_Fail];
}

@end
