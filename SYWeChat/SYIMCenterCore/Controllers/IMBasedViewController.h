/**
 * This file is part of the SYIMKit Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYIMKit (https://github.com/reesun1130/SYIMKit)
 */

#import "SYNavBasedController.h"
#import "IMMsgCell.h"
#import "IMMsgQueue.h"
#import "IMMsgCenter.h"
#import <SYIMKit/SYIMKit.h>

@class SoftwareUser;

@interface IMBasedViewController : SYNavBasedController <UITableViewDataSource, UITableViewDelegate, SYIMInputBarDelegate, UIGestureRecognizerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate,SYAmrRecorderDelegate,SYMenuViewDelegate,IMMsgCellDelegate,SYIMFaceViewDelegate>
{    
    BOOL isLoading;
    int showIndex;
    
    NSMutableArray *moreArray;
}

@property (nonatomic, strong) SYIMInputBar *inputBar;
@property (nonatomic, strong) NSString *groupTime;

@property (nonatomic, strong) SYIMTableView *mainTableView;
@property (nonatomic, strong) NSMutableArray *msgArray;
@property (nonatomic, strong) SYAmrRecorder *recorder;
@property (nonatomic, strong) SYIMFaceView *kbfaceView;
@property (nonatomic, strong) SYMenuView *kbmenuView;

@property (nonatomic, strong) IMMsgQueue *msgQueue;
@property (nonatomic, strong) SoftwareUser *fromUser;

@property (nonatomic, assign, getter = isRecording) BOOL recording;

- (void)newMsg:(NSNotification *)note;
- (void)adjustTableViewContentInset;

- (void)IMChatTableViewScrollToBottomAnimated:(BOOL)animate;

@end
