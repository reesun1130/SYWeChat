/**
 * This file is part of the SYIMKit Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYIMKit (https://github.com/reesun1130/SYIMKit)
 */

#import "IMBasedViewController.h"
#import <SYCore/SYCore.h>
#import "IMAudioMsg.h"
#import "IMMsgCell.h"
#import "IMPicMsg.h"
#import "IMMsgCellUtil.h"

@interface IMBasedViewController ()

@property (nonatomic, strong) UIImagePickerController *imgPicker;
@property (nonatomic, strong) SYTalkView *talkMaskView;

@end

@implementation IMBasedViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // Custom initialization
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newMsg:) name:kIMMsgQueueChanged object:nil];

    [self configIMTableView];
    [self configIMInputBar];
    [self configIMAmrRecorder];
    [self configIMMenuView];
    [self configIMFaceView];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [self.recorder stopAndCancel];
    [self.msgQueue stopAudioPlay];
    
    self.inputBar.delegate = nil;
    self.inputBar = nil;
    //_groupTime = nil;
    self.mainTableView = nil;
    self.msgArray = nil;
    
    self.recorder.delegate = nil;
    self.recorder = nil;
    
    self.kbfaceView.delegate = nil;
    self.kbfaceView = nil;
    
    self.kbmenuView.delegate = nil;
    self.kbmenuView = nil;
    
    //_actView = nil;
    self.msgQueue = nil;
    self.fromUser = nil;
    
    self.imgPicker.delegate = nil;
    self.imgPicker = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backsAction:(id)sender
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    [self.recorder stopAndCancel];
    [self.msgQueue stopAudioPlay];

    [_inputBar closeInputBar];

    [super backsAction:sender];
}

- (void)configIMTableView
{
    self.mainTableView = [[SYIMTableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight - 44 - 20) style:UITableViewStylePlain];
    self.mainTableView.backgroundColor = [UIColor clearColor];
    self.mainTableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight;
    self.mainTableView.showsVerticalScrollIndicator = NO;
    self.mainTableView.showsHorizontalScrollIndicator = NO;
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.mainTableView];
}

- (void)configIMInputBar
{
    _inputBar = [[SYIMInputBar alloc] initWithFrame:CGRectMake(0, self.view.height - kSYIMInputHeight, kDeviceWidth, kSYIMInputHeight) style:SYIMInputBarStyleTextPhotoFaceAndAudio];
    
    SYLog(@"----- he %f   %f",KDeviceHeight,self.view.frame.size.height);
    
    _inputBar.delegate = self;
    _inputBar.limitWordsNum = 500;
    [self.view addSubview:_inputBar];
    
    __weak IMBasedViewController *weakself = self;
    
    self.inputBar.recordStartActionBlock = ^{
        
        [weakself.msgQueue pauseAudioPlay];
        
        NSString *filePath = [kCachesPath stringByAppendingPathComponent:[[SYSystemManager sharedSManager].user createRelateRandAudioPath]];
        
        if(filePath && [filePath length] > 0)
        {
            [SYSharedTool createFileDoc:filePath];
            [weakself.recorder startRecodeWithPath:filePath];
        }
        else
        {
            [weakself showToastFailWithMessage:kMsg_NETWORK_WEAK_Fail];
        }
    };
    
    self.inputBar.recordMayEndActionBlock = ^{
        [weakself.recorder cancle];
    };
    
    self.inputBar.recordResumeActionBlock = ^{
        [weakself.recorder recording];
    };
    
    self.inputBar.recordCancelledActionBlock = ^{
        [weakself.recorder stopAndCancel];
        weakself.recording = NO;
    };
    
    self.inputBar.recordEndActionBlock = ^{
        [weakself.recorder stopRecord];
    };
}

- (void)configIMAmrRecorder
{
    self.recorder = [[SYAmrRecorder alloc] init];
    self.recorder.delegate = self;
    self.recorder.showMeter = YES;
    self.recorder.limitRecordFrames = AMR_FRAME_COUNT_PER_SECOND * 60; //最长一分钟（每帧20ms，一秒［1000ms］50帧）
}

- (void)configIMMenuView
{
    if (_inputBar.barStyle == SYIMInputBarStyleTextAndPhoto || _inputBar.barStyle == SYIMInputBarStyleTextPhotoAndAudio || _inputBar.barStyle == SYIMInputBarStyleTextPhotoAndFace || _inputBar.barStyle == SYIMInputBarStyleTextPhotoFaceAndAudio)
    {
        _kbmenuView = [[SYMenuView alloc] initWithFrame:CGRectMake(0, self.view.height, self.view.width, kSYMenuViewHeight)];
        _kbmenuView.delegate = self;
        [self.view addSubview:_kbmenuView];
    }
}

- (void)configIMFaceView
{
    if (_inputBar.barStyle == SYIMInputBarStyleTextAndFace || _inputBar.barStyle == SYIMInputBarStyleTextPhotoAndFace || _inputBar.barStyle == SYIMInputBarStyleTextPhotoFaceAndAudio)
    {
        _kbfaceView = [[SYIMFaceView alloc] initWithFrame:CGRectMake(0, self.view.height, self.view.width, kSYFaceViewHeight)];
        _kbfaceView.backgroundColor = [UIColor grayColor];
        _kbfaceView.delegate = self;
        
        [self.view addSubview:_kbfaceView];
    }
}


#pragma mark -
#pragma mark NewMsg

- (void)newMsg:(NSNotification *)note
{
    //IMMessage *message = (IMMessage *)note.object;
    
	[self.mainTableView reloadData];
	[self.mainTableView scrollToBottom:YES];
}

- (void)adjustTableViewContentInset
{
    self.mainTableView.contentInset = UIEdgeInsetsMake(9.0f, 0.0f, 0.0f, 0.0f);
}


#pragma mark -
#pragma mark tableView delegate/datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.msgArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id msg = [self.msgArray objectAtIndex:indexPath.row];
    
	return [IMMsgCellUtil cellHeightForMsg:msg];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id msg = [self.msgArray objectAtIndex:indexPath.row];
    
	UITableViewCell *cell = nil;

	cell = [IMMsgCellUtil tableView:tableView cellForMsg:msg];
    cell.backgroundColor = [UIColor clearColor];
    
    if([cell isKindOfClass:[IMMsgCell class]])
    {
        IMMsgCell *a = (IMMsgCell *)cell;
        a.delegate = self;
        
        NSString *avatar_temp = [SYSharedTool parserInfo:a.msg.fromUser.Photo];
        
        if (avatar_temp)
        {
            if ([avatar_temp hasPrefix:@"http"])
            {
                a.userHeadView.image = kDefaultLoadingHeaderImage;

                /*[a.userHeadView sd_setImageWithURL:[NSURL URLWithString:avatar_temp] placeholderImage:kDefaultLoadingHeaderImage options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
                    a.userHeadView.image = image;
                }];*/
            }
            else
            {
                a.userHeadView.image = [UIImage imageNamed:a.msg.fromUser.Photo];
            }
        }
        else
        {
            a.userHeadView.image = kDefaultLoadingHeaderImage;
        }
    }
    
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    [_inputBar closeInputBar];
    
    self.mainTableView.height = self.view.height - self.inputBar.height;
}

- (void)IMChatTableViewScrollToBottomAnimated:(BOOL)animate
{
    CGFloat bottomOriginY = self.mainTableView.contentSize.height > self.mainTableView.frame.size.height ? (self.mainTableView.contentSize.height - self.mainTableView.bounds.size.height) : 0.0;
    [self.mainTableView setContentOffset:CGPointMake(0.0, bottomOriginY + kSYIMInputHeight) animated:animate];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
	[_inputBar closeInputBar];
}


#pragma mark - CellClcik

- (void)imMsgCellBodyDidSelected:(IMMsgCell *)cell
{
    if(cell.msg.procState == IMMsgProcStateFaied)
    {
        if (cell.msg.fromself)
        {
            [[IMMsgCenter sharedIMMsgCenter] reSendFailMsg:cell.msg];
        }
        else
        {
            if ([cell.msg isKindOfClass:[IMPicMsg class]] || [cell.msg isKindOfClass:[IMAudioMsg class]])
            {
                IMFileMsg *amsg = (IMFileMsg *)cell.msg;
                [amsg downLoadFile];
            }
        }
        return;
    }
    
    if([cell.msg isMemberOfClass:[IMAudioMsg class]])
    {
        [self.msgQueue selectMsg:cell.msg];
    }
}

- (void)imMsgCellPicDidSelected:(IMMsgCell *)cell
{
    SYLog(@"查看大图－－");
}

- (void)imMsgCellLongPress:(IMMsgCell *)cell
{
	SYLog(@"Long Press!");
    
	[_inputBar closeInputBar];
}

- (void)imMsgCellShouldDelete:(IMMsgCell *)cell
{
	IMMessage *msg = cell.msg;
	
    NSInteger i = [self.msgQueue.displayMsgArray indexOfObject:msg];
	
    if(i != NSNotFound)
	{
		NSArray *ar =  [self.msgQueue deleteMsg:msg];
        
		if(ar == nil)
			return;
        
		[self.mainTableView beginUpdates];
		[self.mainTableView deleteRowsAtIndexPaths:ar withRowAnimation:UITableViewRowAnimationFade];
		[self.mainTableView endUpdates];
	}
}


#pragma mark -
#pragma mark iminput delegate

- (BOOL)syIMInputBarSendText:(NSString *)message
{
	SYLog(@"send:%@", message);

	return YES;
}

- (void)syIMInputBarHideFaceViewAndShowMenuView
{
	[UIView animateWithDuration:0.25f
						  delay:0.0f
						options:UIViewAnimationOptionCurveEaseInOut|UIViewAnimationOptionBeginFromCurrentState
					 animations:^{
                         
                         _kbfaceView.top = self.view.height;
						 _kbmenuView.top = self.view.height - _kbmenuView.height;
						 _inputBar.top = self.view.height - _kbmenuView.height - _inputBar.height;
						 
                         [self tableViewChangeToEidtMode];
					 }
					 completion:^(BOOL finished){
						 
                     }];
}

- (void)syIMInputBarShowFaceView
{
    [UIView animateWithDuration:0.25f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseInOut|UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         
                         _kbfaceView.top = self.view.height - _kbfaceView.height;
                         _inputBar.top = self.view.height - _kbfaceView.height - _inputBar.height;

                         [self tableViewChangeToEidtMode];
                     }
                     completion:^(BOOL finished){
                         
                     }];
}

- (void)syIMInputBarHideFaceViewAndMenuView
{
	[UIView animateWithDuration:0.25f
						  delay:0.0f
						options:UIViewAnimationOptionCurveEaseInOut|UIViewAnimationOptionBeginFromCurrentState
					 animations:^{
                         
                         _kbmenuView.top = self.view.height;
						 _kbfaceView.top = self.view.height;
						 _inputBar.top = self.view.height -  _inputBar.height;

						 [self tableViewChangeToNormal];
					 }
					 completion:^(BOOL finished){
					 }];
}

- (void)syIMInputBarKeyBoardDidShow:(CGFloat)keyBoardHeight
{
	[self tableViewChangeToEidtMode];
}

- (void)syIMInputBarKeyBoardDidHide
{
	[self tableViewChangeToNormal];
}

#pragma mark TableViewChange

- (void)tableViewChangeToEidtMode
{
	self.mainTableView.height = self.inputBar.top;
    if(self.mainTableView.contentSize.height > self.mainTableView.frame.size.height)
    {
        [self.mainTableView setContentOffset:CGPointMake(0, self.mainTableView.contentSize.height - self.mainTableView.frame.size.height) animated:NO];
    }
}

- (void)tableViewChangeToNormal
{
	self.mainTableView.height = self.view.height - self.inputBar.height;
}


#pragma mark - 
#pragma mark faceview delegate

- (void)faceViewDeleteLastFace:(SYIMFaceView *)faceView
{
	[_inputBar deleteLastCharOrFace];
}

- (void)faceView:(SYIMFaceView *)faceView addFaceStr:(NSString *)facestr
{
	[_inputBar appendFaceText:facestr];
}

- (void)faceViewSend:(SYIMFaceView *)faceView
{
	[_inputBar sendInputText];
}


#pragma mark -
#pragma mark  RecordDelegate

- (void)syAmrRecorderDidSatart:(SYAmrRecorder *)recorder
{
    self.recording = YES;
}

- (void)syAmrRecorderDidCancel:(SYAmrRecorder *)recorder
{
    [self.msgQueue resumeAudioPlay];

    self.recording = NO;
}

- (void)syAmrRecorderDidFail:(SYAmrRecorder *)recorder
{
    [SYSharedTool showAlertWithTitle:@"访问麦克风失败" message:@"无法访问您的麦克风，请到手机系统的设置-隐私-麦克风中设置！" cancleTitle:@"知道了" okTitle:nil delegate:nil];
}


#pragma mark -
#pragma mark MenuViewDelegate

- (void)syMenuViewSelectedPhoto:(SYMenuView *)menuView
{
	if(self.imgPicker == nil)
	{
		self.imgPicker = [[UIImagePickerController alloc]init];
		self.imgPicker.delegate = self;
	}
	
	self.imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	self.imgPicker.allowsEditing = NO;
    
	[self presentViewController:self.imgPicker animated:YES completion:nil];
}

- (void)syMenuViewSelectedCamera:(SYMenuView *)menuView
{
	if(self.imgPicker == nil)
	{
		self.imgPicker = [[UIImagePickerController alloc] init];
		self.imgPicker.delegate = self;
	}
	
	if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
		return;
	self.imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
	self.imgPicker.allowsEditing = NO;
    
	[self presentViewController:self.imgPicker animated:YES completion:nil];
}

- (void)syMenuViewSelectedLocation:(SYMenuView *)menuView
{
    [self sendLocationMsg];
}

- (void)sendLocationMsg
{
    //overwrite
}


#pragma mark -
#pragma mark UIGesture Recognizer Delegate Methods

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && self.isRecording) {
        return NO;
    }
    return YES;
}

@end
