/**
 * This file is part of the SYIMKit Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYIMKit (https://github.com/reesun1130/SYIMKit)
 */

#import "IMTextMsgCell.h"
#import <SYCore/SYCore.h>
#import "NSAttributedString+Attributes.h"
#import "IMTextMessage.h"
#import <SYIMKit/SYIMSharedTool.h>

@implementation IMTextMsgCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
		
		self.textBgBtnView = [UIButton buttonWithType:UIButtonTypeCustom];
		[_textBgBtnView addTarget:self action:@selector(cellClick:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:_textBgBtnView];
		
		UILongPressGestureRecognizer *lpg = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longpress:)];
        lpg.cancelsTouchesInView = YES;
        [_textBgBtnView addGestureRecognizer:lpg];
		      
		_textView = [[SYTTTAttributedLabel alloc] initWithFrame:CGRectZero];
		_textView.backgroundColor = [UIColor clearColor];
		_textView.font = KMsgCellBodyTextFont;
		_textView.textColor = kMsgCellBodyTextColor;
		_textView.lineBreakMode = NSLineBreakByWordWrapping;
        _textView.userInteractionEnabled = NO;
		_textView.numberOfLines = 0;
        _textView.leading = 4.0f;
		_textView.dataDetectorTypes = UIDataDetectorTypeLink|UIDataDetectorTypePhoneNumber;
		_textView.verticalAlignment = SYTTTAttributedLabelVerticalAlignmentTop;
		_textView.highlightedTextColor = [UIColor whiteColor];
		[_textBgBtnView addSubview:_textView];
        
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activityView.frame = CGRectMake(0, 0, 19, 19);
        _activityView.userInteractionEnabled = NO;
        _activityView.hidesWhenStopped = YES;
        [self addSubview:_activityView];
    }
    return self;
}

- (void)dealloc
{
    @try
    {
        [self.msg removeObserver:self forKeyPath:@"procState"];
    }
    @catch (NSException *exception) {}
    
    self.textView = nil;
    self.activityView = nil;
    self.textBgBtnView = nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setMsg:(IMMessage *)msg
{
    [self.msg removeObserver:self forKeyPath:@"procState"];
    
	[super setMsg:msg];
	
	[self.msg addObserver:self forKeyPath:@"procState" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial context:nil];
    
    if (self.msg.fromself)
    {
        _textView.textColor = kRGB(47, 52, 48, 1.0);//[UIColor whiteColor];
    }
    else
    {
        _textView.textColor = kRGB(50, 50, 50, 1.0);
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if([keyPath isEqualToString:@"procState"])
	{
		SYLog(@"testnew::%@", [change objectForKey:NSKeyValueChangeNewKey]);
		
        dispatch_async(dispatch_get_main_queue(), ^{
            [self layoutActivityView];
		});
	}
}

- (void)layoutActivityView
{
	if(self.msg.procState == IMMsgProcStateProcessing)
	{
		[_activityView startAnimating];
		self.errorView.hidden = YES;
	}
	else if(self.msg.procState == IMMsgProcStateFaied)
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
	
	[_textView setImText:self.msg.Content];
	
	CGSize size = [_textView.attributedText sizeConstrainedToSize:CGSizeMake(kMsgCellBodyMaxWidth-kMsgCellUserBodyBackGroundHeadingW*2, CGFLOAT_MAX)];
    
    if(self.msg.fromself)
    {
        _textBgBtnView.frame = CGRectMake(self.userNameLabel.right-(size.width+kMsgCellUserBodyBackGroundHeadingW*2 + 8), self.userNameLabel.bottom + kMsgCellUserBodySpace,size.width+kMsgCellUserBodyBackGroundHeadingW*2 + 8, size.height+kMsgCellUserBodyBackGroundHeadingH*2);
        
        [_textBgBtnView setBackgroundImage:[[UIImage imageNamed:@"Team_08"] stretchableImageWithLeftCapWidth:10 topCapHeight:23] forState:UIControlStateNormal];
        
        _textView.frame = CGRectMake(kMsgCellUserBodyBackGroundHeadingW - 4, kMsgCellUserBodyBackGroundHeadingH, size.width, size.height+20);
        
        _activityView.frame = CGRectMake(self.textBgBtnView.left - _activityView.width - kMsgCellHeadUserSpace, self.textBgBtnView.top + (CGRectGetHeight(_textBgBtnView.frame) - _activityView.height)/2, _activityView.width, _activityView.height);
        
        self.errorView.frame = CGRectMake(self.textBgBtnView.left - self.errorView.width - kMsgCellPadding, self.textBgBtnView.top + (self.textBgBtnView.height - self.errorView.height)/2, self.errorView.width, self.errorView.height);
    }
    else
    {
        _textBgBtnView.frame = CGRectMake(self.userNameLabel.left, self.userNameLabel.bottom + kMsgCellUserBodySpace,size.width+kMsgCellUserBodyBackGroundHeadingW*2 + 6, size.height+kMsgCellUserBodyBackGroundHeadingH*2);
        
        [_textBgBtnView setBackgroundImage:[[UIImage imageNamed:@"Team_07"] stretchableImageWithLeftCapWidth:22 topCapHeight:23] forState:UIControlStateNormal];
        
        CGFloat spaceY = 0;
        
        if (self.msg.MesType == IMMsgTypePic)
        {
            spaceY = 3;
        }
        
        _textView.frame = CGRectMake(kMsgCellUserBodyBackGroundHeadingW + 10, kMsgCellUserBodyBackGroundHeadingH - spaceY, size.width, size.height+20);
        
        _activityView.frame = CGRectMake(self.textBgBtnView.right + kMsgCellHeadUserSpace , self.textBgBtnView.top + (CGRectGetHeight(_textBgBtnView.frame) - _activityView.height) / 2, _activityView.width, _activityView.height);
        
        self.errorView.frame = CGRectMake(self.textBgBtnView.right + kMsgCellPadding, self.textBgBtnView.top + (self.textBgBtnView.height - self.errorView.height)/2, self.errorView.width, self.errorView.height);
    }
    
    [self layoutActivityView];
}

+ (CGFloat)heightForCellWithMsg:(IMMessage *)msg
{
    NSString *amsg = [SYIMSharedTool parserInfo:msg.Content];
    
    CGFloat bodyHeight = 0.0;
    
    if (amsg) {
        bodyHeight = [amsg heightWithFont:KMsgCellBodyTextFont constrainedToWidth:kMsgCellBodyMaxWidth-kMsgCellUserBodyBackGroundHeading*2 lineBreakMode:NSLineBreakByWordWrapping];
    }
    
	return kMsgCellTopPading + 16.0f + kMsgCellUserBodySpace + bodyHeight + kMsgCellUserBodyBackGroundHeading*2 + kMsgCellBottomPadding + 10 + 10;
}


#pragma mark -
#pragma mark gesture

- (void)cellClick:(id)sender
{
	SYLog(@"btnClcik");
    
    if( self.delegate && [self.delegate respondsToSelector:@selector(imMsgCellBodyDidSelected:)])
    {
        [self.delegate imMsgCellBodyDidSelected:self];
    }
}

- (void)longpress:(UIGestureRecognizer *)gesture
{
	if(gesture.state == UIGestureRecognizerStateBegan)
    {
		if(self.delegate && [self.delegate respondsToSelector:@selector(imMsgCellLongPress:)])
		{
			[self.delegate imMsgCellLongPress:self];
		}
        
        [self becomeFirstResponder];
		UIMenuController *menu = [UIMenuController sharedMenuController];
        //UIMenuItem *copyMItem = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copy:)];
        //UIMenuItem *deleteMItem = [[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(delete:)];
        //[menu setMenuItems:@[copyMItem,deleteMItem]];
		[menu setTargetRect:_textBgBtnView.frame inView:self];
		[menu setMenuVisible:YES animated:YES];
	}
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    if (action == @selector(cut:)){
        return NO;
    }
    else if(action == @selector(copy:)){
        return YES;
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
    else
    {
        return [super canPerformAction:action withSender:sender];
    }
}

- (void)copy:(id)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:self.msg.Content];
}

@end
