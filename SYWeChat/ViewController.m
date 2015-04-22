//
//  ViewController.m
//  SYWeChat
//
//  Created by sunbb on 15-4-11.
//  Copyright (c) 2015年 SunYang. All rights reserved.
//

#import "ViewController.h"
#import "IMPrivateMCenterViewController.h"
#import <SYCore/UIImage+SYCore.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.title = @"SYWeChatDemo";
    
    SoftwareUser *muser = [[SoftwareUser alloc]init];
    muser.UserId = @"111";//[rs stringForColumn:@"msguserid"];
    muser.StudentName = @"11111";//[rs stringForColumn:@"msgnickname"];
    muser.Photo = @"http://cdn.yantiku.cn/KTS/Msg/12d1e4a5f91441f8b00ef471e3dc1e7.png";//[rs stringForColumn:@"avatar"];
    [SYSystemManager sharedSManager].user = muser;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)enterMsgList:(id)sender
{
    
    IMPrivateMCenterViewController *mlvc = [[IMPrivateMCenterViewController alloc] init];
    [self.navigationController pushViewController:mlvc animated:YES];
}

@end
