/**
 * This file is part of the SYIMKit Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYIMKit (https://github.com/reesun1130/SYIMKit)
 */

#import "IMPicMsgCell.h"
#import "IMPicMsg.h"
#import <SYCore/SYCore.h>

@implementation IMPicMsgCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
		
		self.bgView = [UIButton buttonWithType:UIButtonTypeCustom];
		[self.bgView addTarget:self action:@selector(cellClick:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:_bgView];
		
		UILongPressGestureRecognizer *lpg = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longpress:)];
		lpg.cancelsTouchesInView = YES;
		[_bgView addGestureRecognizer:lpg];
		
		_picView = [[UIImageView alloc]initWithFrame:CGRectZero];
		_picView.backgroundColor = [UIColor clearColor];
		_picView.clipsToBounds = YES;
		[_bgView addSubview:_picView];
		
		UIImage * backgroundImage = [[UIImage imageNamed:@"chat_img_loading_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(2, 3, 2, 3)];
		UIImage * foregroundImage = [[UIImage imageNamed:@"chat_img_loading"] resizableImageWithCapInsets:UIEdgeInsetsMake(2, 3, 2, 3)];
		
        _progressBarView = [[MCProgressBarView alloc] initWithFrame:CGRectMake(10, 0, 70, 5)
													backgroundImage:backgroundImage
													foregroundImage:foregroundImage];
		[_bgView addSubview:_progressBarView];
	}
	return self;
}

- (void)dealloc
{
    @try
    {
        [self.msg removeObserver:self forKeyPath:@"procState"];
        [self.msg removeObserver:self forKeyPath:@"mprogress"];
    }
    @catch (NSException *exception) {
    }

    self.picView = nil;
    self.progressBarView = nil;
    self.bgView = nil;
}

- (void)setMsg:(IMMessage *)msg
{
	[self.msg removeObserver:self forKeyPath:@"procState"];
	[self.msg removeObserver:self forKeyPath:@"mprogress"];
    
	[super setMsg:msg];
	
	[self.msg addObserver:self forKeyPath:@"procState" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial context:nil];
	[self.msg addObserver:self forKeyPath:@"mprogress" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if([keyPath isEqualToString:@"procState"])
	{
		SYLog(@"testnew::%@", [change objectForKey:NSKeyValueChangeNewKey]);
		
        dispatch_async(dispatch_get_main_queue(), ^{
			[self refreshPic];
		});
	}
	else if([keyPath isEqualToString:@"mprogress"])
	{
		NSNumber *n = [change objectForKey:NSKeyValueChangeNewKey];
		
		dispatch_async(dispatch_get_main_queue(), ^{
			_progressBarView.progress = [n floatValue];
		});
	}
}

- (void)refreshPic
{
	IMPicMsg *tmpMsg = (IMPicMsg *)self.msg;
    
	if(self.msg.procState == IMMsgProcStateSuc)
	{
		_progressBarView.hidden = YES;
		self.errorView.hidden = YES;
        UIImage *temimage = [[UIImage alloc] initWithContentsOfFile:tmpMsg.localPath];
        tmpMsg.thumbImage = temimage;
        temimage = nil;
	}
	else if(self.msg.procState == IMMsgProcStateFaied)
	{
		_progressBarView.hidden = YES;
        self.errorView.hidden = NO;

        UIImage *temimage = [[UIImage alloc] initWithContentsOfFile:tmpMsg.localPath];

		//if(self.msg.fromself)
            //tmpMsg.thumbImage = temimage;
		//else
        tmpMsg.thumbImage = [UIImage imageNamed:@"chat_img_wrong.png"];
        
        temimage = nil;
	}
	else
	{
		_progressBarView.hidden = NO;
		self.errorView.hidden = YES;
        
        UIImage *temimage = [[UIImage alloc] initWithContentsOfFile:tmpMsg.localPath];

		//if(self.msg.fromself)
          //  tmpMsg.thumbImage = temimage;
		//else
        tmpMsg.thumbImage = [UIImage imageNamed:@"chat_img.png"];
        
        temimage = nil;
	}
	[self setNeedsLayout];
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	
	IMPicMsg *tmpMsg = (IMPicMsg *)self.msg;
    
	if(tmpMsg.thumbImage == nil)
	{
		if(self.msg.procState == IMMsgProcStateSuc || self.msg.fromself)
		{
			tmpMsg.thumbImage = [[UIImage alloc]initWithContentsOfFile:tmpMsg.localPath];
		}
        else if(self.msg.procState == IMMsgProcStateFaied)
		{
			tmpMsg.thumbImage = [UIImage imageNamed:@"chat_img_wrong.png"];
		}
		else
		{
			tmpMsg.thumbImage = [UIImage imageNamed:@"chat_img.png"];
		}
	}
    
	CGFloat width = tmpMsg.thumbImage.size.width;
	CGFloat height = tmpMsg.thumbImage.size.height;
	
    if(height > kMsgPicCellMaxHeight || height == 0)
		height = kMsgPicCellMaxHeight;
    
	if(width > kMsgPicCellMaxWidth || width == 0)
		width = kMsgPicCellMaxWidth;
	
	if(self.msg.fromself)
	{
		_bgView.frame = CGRectMake(self.userNameLabel.right - (width+2*kMsgCellUserBodyBackGroundHeading+2), self.userNameLabel.bottom+kMsgCellUserBodySpace, width+2*kMsgCellUserBodyBackGroundHeading+2, height * (width -10) / width + 2*kMsgCellUserBodyBackGroundHeading);
		_picView.frame = CGRectMake(kMsgCellUserBodyBackGroundHeading, kMsgCellUserBodyBackGroundHeading, width - 10, height * (width -10) / width);
		[_bgView setBackgroundImage:[[UIImage imageNamed:@"Team_08"] stretchableImageWithLeftCapWidth:11 topCapHeight:25] forState:UIControlStateNormal];
		self.errorView.frame = CGRectMake(self.bgView.left - self.errorView.width - kMsgCellPadding, self.bgView.top + (self.bgView.height - self.errorView.height)/2, self.errorView.width, self.errorView.height);
	}
	else
	{
		_bgView.frame = CGRectMake(self.userNameLabel.left, self.userNameLabel.bottom+kMsgCellUserBodySpace, width+2*kMsgCellUserBodyBackGroundHeading+2, height * (width -10) / width + 2*kMsgCellUserBodyBackGroundHeading);
		_picView.frame = CGRectMake(kMsgCellUserBodyBackGroundHeading+5+8, kMsgCellUserBodyBackGroundHeading, width - 10, height * (width -10) / width);
        [_bgView setBackgroundImage:[[UIImage imageNamed:@"Team_07"] stretchableImageWithLeftCapWidth:22 topCapHeight:25] forState:UIControlStateNormal];
		self.errorView.frame = CGRectMake(self.bgView.right + kMsgCellPadding, self.bgView.top + (self.bgView.height - self.errorView.height)/2, self.errorView.width, self.errorView.height);
	}
	_picView.image = tmpMsg.thumbImage;
	_progressBarView.left = _picView.left + (_picView.width - _progressBarView.width)/2;
	_progressBarView.top = _picView.bottom - 15;
    
    //[self refreshPic];
}

+ (CGFloat)heightForCellWithMsg:(IMMessage *)msg
{
	IMPicMsg *tmpMsg = (IMPicMsg *)msg;
	
	CGFloat bodyHeight = kMsgPicCellMaxHeight;
    
	if(tmpMsg.thumbImage != nil)
		bodyHeight = tmpMsg.thumbImage.size.height;
	
	if(bodyHeight > kMsgPicCellMaxHeight)
		bodyHeight = kMsgPicCellMaxHeight;
	
	return kMsgCellTopPading + 16.0f + kMsgCellUserBodySpace + bodyHeight + kMsgCellUserBodyBackGroundHeading*2 + kMsgCellBottomPadding;
}


#pragma mark -
#pragma mark gesture

- (void)cellClick:(id)sender
{
	if(self.msg.procState == IMMsgProcStateSuc)
	{
        if(self.delegate && [self.delegate respondsToSelector:@selector(imMsgCellPicDidSelected:)])
		{
			[self.delegate imMsgCellPicDidSelected:self];
		}
	}
	else if(self.msg.procState == IMMsgProcStateFaied)
	{
        if(self.delegate && [self.delegate respondsToSelector:@selector(imMsgCellBodyDidSelected:)])
		{
			[self.delegate imMsgCellBodyDidSelected:self];
		}
	}
}

- (void)longpress:(UIGestureRecognizer *)gesture
{
    if(gesture.state == UIGestureRecognizerStateBegan)
    {
		if([self.delegate respondsToSelector:@selector(imMsgCellLongPress:)])
		{
			[self.delegate imMsgCellLongPress:self];
		}
        
        [self becomeFirstResponder];
		UIMenuController *menu = [UIMenuController sharedMenuController];
		[menu setTargetRect:_bgView.frame inView:self];
		[menu setMenuVisible:YES animated:YES];
	}
}

@end
