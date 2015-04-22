/**
 * This file is part of the SYIMKit Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYIMKit (https://github.com/reesun1130/SYIMKit)
 */

#import "IMMsgCell.h"
#import <SYCore/SYCore.h>

@implementation IMMsgCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
		self.backgroundColor = [UIColor clearColor];
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		self.detailTextLabel.hidden = YES;
		self.textLabel.hidden = YES;
		self.layer.shouldRasterize = YES;
		self.layer.rasterizationScale = [[UIScreen mainScreen] scale];
        
		self.userHeadView = [[UIImageView alloc] initWithFrame:CGRectMake(kMsgCellLeftPading, kMsgCellTopPading, kMsgCellUserHeadViewWidth, kMsgCellUserHeadViewHeight)];
		self.userHeadView.userInteractionEnabled = YES;
        //[self.userHeadView makeCircleViewWithBorderColor:[UIColor whiteColor]];
		
        [self.contentView addSubview:_userHeadView];

        self.userNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		self.userNameLabel.backgroundColor = [UIColor clearColor];
		self.userNameLabel.textColor = kMsgCellUserNameColor;
		self.userNameLabel.font = kMsgCellUserNameFont;
		
		[self.contentView addSubview:_userNameLabel];

        UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headViewClick:)];
        tapGesture1.numberOfTapsRequired = 1;
        tapGesture1.numberOfTouchesRequired = 1;
        [self.userHeadView addGestureRecognizer:tapGesture1];
		
        UIImage *image = [UIImage imageNamed:@"msg_wrong"];
        
		self.errorView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
		self.errorView.image = image;
		self.errorView.hidden = YES;
        
        [self.contentView addSubview:_errorView];
    }
    return self;
}

- (void)dealloc
{
    self.delegate = nil;
    
    self.userHeadView = nil;
    self.userNameLabel = nil;
    self.errorView = nil;
    _msg = nil;
}

- (void)setMsg:(IMMessage *)msg
{
	_msg = msg;
    
	[self setNeedsLayout];
}

- (void)layoutSubviews
{
	if(_msg == nil)
	{
		[super layoutSubviews];
        
		return;
	}
    
    if(!_msg.fromself)
    {
        _userHeadView.frame = CGRectMake(kMsgCellLeftPading, kMsgCellTopPading, kMsgCellUserHeadViewWidth, kMsgCellUserHeadViewHeight);
        
        //CGFloat nameWidth = self.width - self.userHeadView.right - kMsgCellHeadUserSpace - kMsgCellLeftPading;
        //NSString *anickname = [SYSharedTool parserInfo:self.msg.fromUser.StudentName] ? self.msg.fromUser.StudentName : kApp_DisplayName;
        //CGSize size = SY_TEXTSIZE(anickname, self.userNameLabel.font);//[anickname sizeWithFont:self.userNameLabel.font constrainedToSize:CGSizeMake(nameWidth, CGFLOAT_MAX)];
        self.userNameLabel.frame = CGRectMake(self.userHeadView.right + kMsgCellHeadUserSpace,kMsgCellTopPading-2, 0, 5);
    }
    else
    {
        _userHeadView.frame = CGRectMake(self.width-kMsgCellUserHeadViewWidth-kMsgCellLeftPading, kMsgCellTopPading, kMsgCellUserHeadViewWidth, kMsgCellUserHeadViewHeight);
        
        //CGFloat nameWidth = self.width - self.userHeadView.width - kMsgCellHeadUserSpace - kMsgCellLeftPading;
        //NSString *anickname = [SYSharedTool parserInfo:self.msg.msgUser.StudentName ] ? self.msg.msgUser.StudentName : kApp_DisplayName;
        //CGSize size = SY_TEXTSIZE(anickname, self.userNameLabel.font);;//[anickname sizeWithFont:self.userNameLabel.font constrainedToSize:CGSizeMake(nameWidth, CGFLOAT_MAX)];
        self.userNameLabel.frame = CGRectMake(self.userHeadView.left - kMsgCellHeadUserSpace, kMsgCellTopPading-2, 0, 5);
    }
}

+ (CGFloat)heightForCellWithMsg:(IMMessage *)msg
{
	return kMsgCellUserHeadViewHeight + kMsgCellTopPading;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark -
#pragma mark gesture

- (void)cellBodyClick:(id)sender
{
	if(_delegate && [_delegate respondsToSelector:@selector(imMsgCellBodyDidSelected:)])
	{
		[_delegate imMsgCellBodyDidSelected:self];
	}
}

- (void)headViewClick:(id)sender
{
	if(_delegate && [_delegate respondsToSelector:@selector(imMsgCellHeadDidSelected:)])
	{
		[_delegate imMsgCellHeadDidSelected:self];
	}
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(cut:)){
        return NO;
    }
    else if(action == @selector(copy:)){
        return NO;
    }
    else if(action == @selector(paste:)){
        return NO;
    }
    else if(action == @selector(select:)){
        return NO;
    }
    else if(action == @selector(selectAll:)){
        return NO;
    }
	else if(action == @selector(delete:))
	{
		return NO;
	}
    else
    {
        return [super canPerformAction:action withSender:sender];
    }
}

@end
