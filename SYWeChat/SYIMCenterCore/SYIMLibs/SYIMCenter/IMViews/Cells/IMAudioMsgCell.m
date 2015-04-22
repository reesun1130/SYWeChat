/**
 * This file is part of the SYIMKit Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYIMKit (https://github.com/reesun1130/SYIMKit)
 */

#import "IMAudioMsgCell.h"
#import "IMAudioMsg.h"
#import <SYCore/SYCore.h>
#import "SYMainHeader.h"

@implementation IMAudioMsgCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
		
		self.bgView = [UIButton buttonWithType:UIButtonTypeCustom];
		[_bgView addTarget:self action:@selector(cellClick:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:_bgView];
		
		UILongPressGestureRecognizer *lpg = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longpress:)];
		lpg.cancelsTouchesInView = YES;
		[_bgView addGestureRecognizer:lpg];
		
		_activityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activityView.frame = CGRectMake(0, 0, 19, 19);
        _activityView.userInteractionEnabled = NO;
        _activityView.hidesWhenStopped = YES;
        [self addSubview:_activityView];
		
        _unReadNotice = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        _unReadNotice.image = [UIImage imageNamed:@"icon_new_msg.png"];
        _unReadNotice.hidden = YES;
        [self addSubview:_unReadNotice];

		_playStateView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 19, 17)];
		[self addSubview:_playStateView];
        	
		_secLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
		_secLabel.backgroundColor = [UIColor clearColor];
		_secLabel.textColor = [UIColor blackColor];
		_secLabel.font = [UIFont systemFontOfSize:14.0f];
		[self addSubview:_secLabel];
	}
	return self;
}

- (void)dealloc
{
    @try
    {
        [self.msg removeObserver:self forKeyPath:@"procState"];
        [self.msg removeObserver:self forKeyPath:@"playState"];
    }
    @catch (NSException *exception) {
    }

    self.secLabel = nil;
    self.playStateView = nil;
    self.activityView = nil;
    self.bgView = nil;
    self.unReadNotice = nil;
}

- (void)setMsg:(IMMessage *)msg
{
	[self.msg removeObserver:self forKeyPath:@"procState"];
	[self.msg removeObserver:self forKeyPath:@"playState"];

	[super setMsg:msg];
    
	[self.msg addObserver:self forKeyPath:@"procState" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial context:nil];
	[self.msg addObserver:self forKeyPath:@"playState" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial context:nil];
}

- (void)hideActive
{
    [_activityView stopAnimating];
    self.errorView.hidden = YES;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if([keyPath isEqualToString:@"procState"])
	{
		SYLog(@"testnew::%@", [change objectForKey:NSKeyValueChangeNewKey]);
        
		[self layoutActivityView];
	}
	else if([keyPath isEqualToString:@"playState"])
	{
		SYLog(@"readstate:%@", [change objectForKey:NSKeyValueChangeNewKey]);

		[self layoutPlayView];
	}
}

- (void)layoutPlayView
{
	IMAudioMsg *tmpMsg = (IMAudioMsg *)self.msg;

	[_playStateView stopAnimating];
	
	if(tmpMsg.playState == IMMsgPlayStateUnPlay)
	{
		_playStateView.animationImages = nil;
   
        if (tmpMsg.fromself)
        {
            _playStateView.image = [UIImage imageNamed:@"Team_47"];
            _unReadNotice.hidden = YES;
        }
        else
        {
            _playStateView.image = [UIImage imageNamed:@"Team_40"];
            _unReadNotice.hidden = NO;
        }
        
		//[self layoutPayView];
	}
	else if(tmpMsg.playState == IMMsgPlayStatePlayed || tmpMsg.playState == IMMsgPlayStatePause)
	{
        if (tmpMsg.fromself)
        {
            _playStateView.image = [UIImage imageNamed:@"Team_47"];
        }
        else
        {
            _playStateView.image = [UIImage imageNamed:@"Team_43"];
        }
        
		_playStateView.animationImages = nil;
        _unReadNotice.hidden = YES;

		//[self layoutPayView];
	}
	else
	{
        _unReadNotice.hidden = YES;

		_playStateView.animationDuration = 0.8f;
        
        if (tmpMsg.fromself)
        {
            _playStateView.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"Team_44"],[UIImage imageNamed:@"Team_45"],[UIImage imageNamed:@"Team_46"],[UIImage imageNamed:@"Team_47"], nil];
        }
        else
        {
            _playStateView.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"Team_40"],[UIImage imageNamed:@"Team_41"],[UIImage imageNamed:@"Team_42"],[UIImage imageNamed:@"Team_43"], nil];
        }
		[_playStateView startAnimating];
	}
}

- (void)layoutActivityView
{
	IMAudioMsg *tmpMsg = (IMAudioMsg *)self.msg;
	if(tmpMsg.procState == IMMsgProcStateProcessing)
	{
		[_activityView startAnimating];
		self.errorView.hidden = YES;
	}
	else if(tmpMsg.procState == IMMsgProcStateFaied)
	{
		[_activityView stopAnimating];
		self.errorView.hidden = NO;
	}
	else
	{
		[_activityView stopAnimating];
		self.errorView.hidden = YES;
	}
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	
	IMAudioMsg *tmpMsg = (IMAudioMsg *)self.msg;
	
	CGFloat width = kMsgCellBodyMaxWidth;
    
	NSInteger sec = [tmpMsg audioFileLength];
	
    //width = 70.0;
    
    if(sec < 60)
	{
		width = ceilf((((CGFloat)(kMsgCellBodyMaxWidth - 70.0) / 60.0) * sec + 70.0));
	}
		
	_secLabel.text = [NSString stringWithFormat:@"%d\"", sec];
	
    CGSize secSize = SY_TEXTSIZE(_secLabel.text, _secLabel.font);//[_secLabel.text sizeWithFont:_secLabel.font];
	 
	CGFloat height = kMsgCellAudioCellHeiht;
	
	if(tmpMsg.fromself)
	{
		_bgView.frame = CGRectMake(self.userNameLabel.right - width, self.userNameLabel.bottom+kMsgCellUserBodySpace, width, height);

		[_bgView setBackgroundImage:[[UIImage imageNamed:@"Team_08"] stretchableImageWithLeftCapWidth:11 topCapHeight:25] forState:UIControlStateNormal];
        
		_activityView.frame = CGRectMake(self.bgView.left - _activityView.width - kMsgCellHeadUserSpace, self.bgView.top + (height - _activityView.height)/2, _activityView.width, _activityView.height);
        _unReadNotice.frame = CGRectMake(self.bgView.left - 10 - kMsgCellHeadUserSpace, self.bgView.top + (height - 10) / 2 - 1, 10, 10);

        _playStateView.frame = CGRectMake(self.bgView.right - _playStateView.width - kMsgCellHeadUserSpace - kMsgCellPadding * 2, self.bgView.top + (height - _playStateView.height) / 2, _playStateView.width, _playStateView.height);
		//_playStateView.layer.transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
		      
		_secLabel.frame = CGRectMake(self.bgView.left + kMsgCellPadding, self.bgView.top +(height - secSize.height)/2, secSize.width, secSize.height);
        
		self.errorView.frame = CGRectMake(self.bgView.left - self.errorView.width - kMsgCellPadding, self.bgView.top + (height - self.errorView.height) / 2, self.errorView.width, self.errorView.height);
        
        _secLabel.textColor = kRGB(89.0, 89.0, 89.0, 1.0);
	}
	else
	{
		_bgView.frame = CGRectMake(self.userNameLabel.left, self.userNameLabel.bottom+kMsgCellUserBodySpace, width, height);
        [_bgView setBackgroundImage:[[UIImage imageNamed:@"Team_07"] stretchableImageWithLeftCapWidth:22 topCapHeight:25] forState:UIControlStateNormal];

		_activityView.frame = CGRectMake(self.bgView.right + kMsgCellHeadUserSpace , self.bgView.top + (height - _activityView.height) / 2, _activityView.width, _activityView.height);
		_unReadNotice.frame = CGRectMake(self.bgView.right + kMsgCellHeadUserSpace , self.bgView.top + (height - 10) / 2 - 1, 10, 10);

		_playStateView.frame = CGRectMake(self.bgView.left + kMsgCellHeadUserSpace + kMsgCellPadding * 2, self.bgView.top + (height - _playStateView.height) / 2, _playStateView.width, _playStateView.height);
		//_playStateView.layer.transform = CATransform3DIdentity;
        
		_secLabel.frame = CGRectMake(self.bgView.right - kMsgCellPadding - secSize.width, self.bgView.top +(height - secSize.height) / 2, secSize.width, secSize.height);
		self.errorView.frame = CGRectMake(self.bgView.right + kMsgCellPadding, self.bgView.top + (height - self.errorView.height) / 2, self.errorView.width, self.errorView.height);
        
        _secLabel.textColor = [UIColor whiteColor];
	}
	
	[self layoutActivityView];
	[self layoutPlayView];
}

+ (CGFloat)heightForCellWithMsg:(IMMessage *)msg
{
	return kMsgCellTopPading + 16.0f + kMsgCellUserBodySpace + kMsgCellAudioCellHeiht + kMsgCellBottomPadding;
}


#pragma mark -
#pragma mark gesture

- (void)cellClick:(id)sender
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(imMsgCellBodyDidSelected:)])
    {
        [self.delegate imMsgCellBodyDidSelected:self];
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
		[menu setTargetRect:_bgView.frame inView: self];
		[menu setMenuVisible: YES animated: YES];
	}
}

@end
