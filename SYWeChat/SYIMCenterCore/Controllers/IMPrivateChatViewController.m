/**
 * This file is part of the SYIMKit Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYIMKit (https://github.com/reesun1130/SYIMKit)
 */

#import "IMPrivateChatViewController.h"
#import "SYMainHeader.h"
#import "IMMsgCellUtil.h"
#import "IMMsgQueue.h"
#import "SoftwareUser.h"
#import <SYCore/SYCore.h>
#import "IMChatRecordMsg.h"

@interface IMPrivateChatViewController ()

@end

@implementation IMPrivateChatViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //[self showLoadingHUD];

    self.msgQueue = [[IMMsgCenter sharedIMMsgCenter] privateMsgQueueWithUser:self.fromUser];
    self.msgArray = self.msgQueue.displayMsgArray;    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.msgArray && self.msgArray.count == 0)
    {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            SoftwareUser *msgUser = [[SoftwareUser alloc] init];
            msgUser.UserId = self.recordMsg.SendId;
            msgUser.StudentName = self.recordMsg.SendName;
            msgUser.Photo = self.recordMsg.SendPhoto;
            msgUser.userType = self.recordMsg.SendUserType.integerValue;
            self.fromUser = msgUser;
            
            for (int i = 0; i < 10; i++)
            {
                IMTextMessage *msg = (IMTextMessage *)[IMMsgCenter generateIMMsg:IMMsgTypeText];
                msg.fromUser = self.fromUser;
                
                if (i % 2 == 0)
                {
                    msg.fromself = YES;
                    msg.Content = @"sdsdsdsdfkfkfkfkfkfkfkfkkfkfkfkfkfkfkfkfk";
                }
                else
                {
                    msg.Content = @"222222222222222222222222222";
                    msg.fromself = NO;
                }
                
                [self.msgArray addObject:msg];
            }

            dispatch_async(dispatch_get_main_queue(), ^{
                [self.mainTableView reloadData];
                [self IMChatTableViewScrollToBottomAnimated:NO];
                self.navigationItem.title = self.fromUser.StudentName;
            });
        });
    }
    
    self.navigationItem.title = self.fromUser.StudentName;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark -
#pragma mark 发送/接受消息

- (BOOL)syIMInputBarSendText:(NSString *)message
{
    IMTextMessage *msg = (IMTextMessage *)[IMMsgCenter generateIMMsg:IMMsgTypeText];//[[IMTextMessage alloc] init];
    msg.Content = message;
    msg.fromUser = self.fromUser;
    
    [[IMMsgCenter sharedIMMsgCenter] sendMsg:msg];
    
    return YES;
}

- (void)syAmrRecorderDidStop:(SYAmrRecorder *)recorder
{
    [self.msgQueue resumeAudioPlay];
    
    SYLog(@"amr file size -- %ldKb",[SYIMSharedTool getFileSize:recorder.mPath] / 1024);
    
    IMAudioMsg *msg = (IMAudioMsg *)[IMMsgCenter generateIMMsg:IMMsgTypeAudio];
    msg.fromUser = self.fromUser;
    msg.localPath = recorder.mPath;
    msg.msgSize = recorder.mRecordFrames;
    msg.readState = IMMsgReadStateReaded;
    msg.playState = IMMsgPlayStatePlayed;
    [msg setAudioTimeLengthWithFramesLength:recorder.mRecordFrames];
    
    [[IMMsgCenter sharedIMMsgCenter] sendMsg:msg];
    
    self.recording = NO;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [MBProgressHUD showHUDAddedTo:picker.view.window animated:YES];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIImage *image_temp = [info objectForKey:UIImagePickerControllerOriginalImage];
        UIImage *image = [image_temp fixOrientation];
        
        NSString *filePath = [kCachesPath stringByAppendingPathComponent:[[SYSystemManager sharedSManager].user createRelateRandPicPath]];
        NSString *smallPath = [kCachesPath stringByAppendingPathComponent:[[SYSystemManager sharedSManager].user createRelateRandPicPath]];
        
        [SYIMSharedTool createFileDoc:filePath];
        
        NSData *data = UIImageJPEGRepresentation(image, 1.0f);
        NSUInteger dataL = [data length];
        
        if (dataL > kMAX_IMAGEDATA_LEN)
        {
            data = nil;
            data = [image compressedData];
        }
        
        [data writeToFile:filePath atomically:YES];
        SYLog(@"filePath:%@", filePath);
        
        IMPicMsg *msg = (IMPicMsg *)[IMMsgCenter generateIMMsg:IMMsgTypePic];
        msg.fromUser = self.fromUser;
        msg.originPicLoaclPath = filePath;
        msg.localPath = smallPath;
        msg.thumbImage = [image scalingAndCroppingToSize:CGSizeMake(kMsgPicCellMaxWidth, kMsgPicCellMaxHeight)];
        
        data = UIImageJPEGRepresentation(msg.thumbImage, 0.75f);
        [data writeToFile:smallPath atomically:YES];
        
        msg.msgSize = [data length];
        
        [[IMMsgCenter sharedIMMsgCenter] sendMsg:msg];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideAllHUDsForView:picker.view.window animated:YES];
            [self dismissViewControllerAnimated:YES completion:nil];
        });
    });
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
