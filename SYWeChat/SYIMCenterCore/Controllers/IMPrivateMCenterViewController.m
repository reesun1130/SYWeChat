/**
 * This file is part of the SYIMKit Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYIMKit (https://github.com/reesun1130/SYIMKit)
 */

#import "IMPrivateMCenterViewController.h"
#import "IMPrivateCenterCell.h"
#import "IMChatRecordMsg.h"
#import "IMPrivateChatViewController.h"
#import "SoftwareUser.h"

@interface IMPrivateMCenterViewController ()

@end

@implementation IMPrivateMCenterViewController

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
    
    self.tableView.frame = CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.bounds), KDeviceHeight);

    NSString *timeNow = [NSString stringWithFormat:@"%ld",(long)[[NSDate date] timeIntervalSince1970]];

    for (int i = 0; i < 10 ; i++)
    {
        IMChatRecordMsg *msg = [[IMChatRecordMsg alloc] init];
        msg.SendName = @"sun";
        msg.SendPhoto = @"http://cdn.yantiku.cn/KTS/Msg/12d1e4a5f91441f8b00ef471e3dc1e7.png";
        msg.unReadCount = 3;
        msg.Content = [NSString stringWithFormat:@"test msg %d",i];
        msg.SendTime = timeNow;
        [self.itemArray addObject:msg];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationItem.title = @"消息列表";
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}


#pragma mark -
#pragma mark 刷新界面

- (void)scrollTableToTop
{
    //tableview自动滚动到最后
    if ([self.itemArray count] > 0) {
        NSIndexPath *lastIndexPath = [NSIndexPath indexPathForRow:0  inSection:0];
        [self.tableView scrollToRowAtIndexPath:lastIndexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
}


#pragma mark -
#pragma mark UITableView DataSource Methods

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 15;
    }
    else
    {
        return 5;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.itemArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 67.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SystemCellIdentfier = @"SystemMessageCesllIdentfier";
    
    IMPrivateCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:SystemCellIdentfier];
    
    if (cell == nil) {
        cell = [[IMPrivateCenterCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SystemCellIdentfier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
    if (self.itemArray.count == 0 || !self.itemArray) {
        return cell;
    }
    
    id object = [self.itemArray objectAtIndex:indexPath.section];
    
    if ([object isKindOfClass:[IMChatRecordMsg class]])
    {
        cell.tag = indexPath.section;
        
        IMChatRecordMsg *message = (IMChatRecordMsg *)object;
        
        [cell clearBadgeBtnTitle];
        
        if (message.unReadCount > 0) {
            NSString *badgeNum = [NSString stringWithFormat:@"%d",message.unReadCount > 99 ? 99 : message.unReadCount];
            [cell addBadgeBtnTitleNum:badgeNum];
        }
        
        cell.nameLabel.text = message.SendName;
        [cell.headImageV setImage:kDefaultLoadingHeaderImage forState:UIControlStateNormal];
        cell.timeLable.text = [[SYSharedTool sharedTool] generateTime:message.SendTime.doubleValue style:SYTimeStyleShort];
        
        if(message.MesType.integerValue == IMMsgTypeAudio)
        {
            cell.detailLabel.text = @"[语音]";
        }
        else if(message.MesType.integerValue == IMMsgTypePic)
        {
            cell.detailLabel.text = @"[图片]";
        }
        else if(message.MesType.integerValue == IMMsgTypeLocation)
        {
            cell.detailLabel.text = @"[位置]";
        }
        else
        {
            [cell.detailLabel setText:message.Content];
        }
        
        cell.IMPrivateCenterCellLongPressBlock = ^(IMPrivateCenterCell *acell){
        
            IMChatRecordMsg *_msg = [self.itemArray objectAtIndex:acell.tag];

            NSIndexSet *deleteSet =  [self deleteChatMsg:_msg];
            
            if(deleteSet == nil)
                return;
            
            [self.tableView beginUpdates];
            [self.tableView deleteSections:deleteSet withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView endUpdates];
        };
    }
    
    return cell;
}

- (NSIndexSet *)deleteChatMsg:(IMChatRecordMsg *)msg
{
	NSInteger idx = [self.itemArray indexOfObject:msg];

    NSIndexSet *indexSet = nil;
    
	if(idx != NSNotFound)
	{
        indexSet = [NSIndexSet indexSetWithIndex:idx];
	}
	
	[self.itemArray removeObject:msg];
		
	return indexSet;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    IMPrivateCenterCell *cell = (IMPrivateCenterCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell clearBadgeBtnTitle];

    IMChatRecordMsg *msg = self.itemArray[indexPath.row];
    
    IMPrivateChatViewController *privateChatVC = [[IMPrivateChatViewController alloc] init];
    privateChatVC.recordMsg = msg;
    [self.navigationController pushViewController:privateChatVC animated:YES];
}

@end
