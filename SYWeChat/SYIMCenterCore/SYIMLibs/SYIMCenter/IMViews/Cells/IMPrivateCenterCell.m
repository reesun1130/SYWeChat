/**
 * This file is part of the SYIMKit Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYIMKit (https://github.com/reesun1130/SYIMKit)
 */

#import "IMPrivateCenterCell.h"
#import "SYMainHeader.h"

@implementation IMPrivateCenterCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        //头像        
        self.headImageV = [[UIButton alloc] initWithFrame:CGRectMake(kIMCellMaxTopPading, kIMCellMaxTopPading, 55, 55)];
        self.headImageV.userInteractionEnabled = NO;
		[self.contentView addSubview:self.headImageV];
        self.headImageV.layer.cornerRadius = 5.0;
        self.headImageV.layer.masksToBounds = YES;
        
        //名字
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headImageV.frame) + kIMCellMaxTopPading, kIMCellMaxTopPading, 135, 20)];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        [self.contentView addSubview:_nameLabel];
        
        //详细信息
        _detailLabel = [[SYTTTAttributedLabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_nameLabel.frame), CGRectGetMaxY(_nameLabel.frame) + kIMCellMaxTopPading, 232, 20)];
        _detailLabel.backgroundColor = [UIColor clearColor];
		//_detailLabel.dataDetectorTypes = UIDataDetectorTypeLink|UIDataDetectorTypePhoneNumber;
        _detailLabel.textColor = [UIColor grayColor];
        _detailLabel.font = [UIFont systemFontOfSize:14.0f];
        _detailLabel.verticalAlignment = SYTTTAttributedLabelVerticalAlignmentTop;
		_detailLabel.highlightedTextColor = [UIColor whiteColor];
		_detailLabel.shadowColor = [UIColor colorWithWhite:0.87 alpha:1.0];
		_detailLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
		_detailLabel.delegate = self;
        [self.contentView addSubview:_detailLabel];

        //时间
        _timeLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_nameLabel.frame) + kIMCellMaxTopPading, kIMCellMaxTopPading, 88, 20)];
        _timeLable.backgroundColor = [UIColor clearColor];
        _timeLable.textColor = [UIColor grayColor];
        _timeLable.textAlignment = NSTextAlignmentRight;
        _timeLable.font = [UIFont systemFontOfSize:12.0f];
        [self.contentView addSubview:_timeLable];
        
        UILongPressGestureRecognizer *lpg = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longpress:)];
		lpg.cancelsTouchesInView = YES;
		[self addGestureRecognizer:lpg];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)dealloc
{
    _headImageV = nil;
    _nameLabel = nil;
    _detailLabel = nil;
    _timeLable = nil;
    _badgeBtn = nil;
    self.IMPrivateCenterCellLongPressBlock = nil;
}


#pragma mark -
#pragma mark gesture

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
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
		return YES;
	}
    else
    {
        return [super canPerformAction:action withSender:sender];
    }
}

- (void)delete:(id)sender
{
    if (self.IMPrivateCenterCellLongPressBlock) {
        self.IMPrivateCenterCellLongPressBlock(self);
    }
}

- (void)longpress:(UIGestureRecognizer *)gesture
{
	if(gesture.state == UIGestureRecognizerStateBegan)
    {
		[self becomeFirstResponder];
		UIMenuController * menu = [UIMenuController sharedMenuController];
		[menu setTargetRect:_nameLabel.frame inView:self];
		[menu setMenuVisible: YES animated: YES];
	}
}


#pragma mark -
#pragma mark TTTAttributedLabel delegate

- (void)attributedLabel:(SYTTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url {
    SYLog(@"%@", url);
}


#pragma mark -
#pragma mark 添加/删除badge

- (void)addBadgeBtnTitleNum:(NSString *)title
{
    if (!_badgeBtn)
    {
        _badgeBtn = [[UIBadgeView alloc] initWithFrame:CGRectMake(kIMCellMaxTopPading - 5, kIMCellMaxTopPading - 5, 30, 20)];
        _badgeBtn.badgeColor = [UIColor redColor];
        [self.contentView addSubview:_badgeBtn];
    }
    _badgeBtn.hidden = NO;
    _badgeBtn.badgeString = title;
    
    CGRect rect = _detailLabel.frame;
    rect.size.width = 220;
}

- (void)clearBadgeBtnTitle
{
    [_badgeBtn setBadgeString:@""];
    _badgeBtn.hidden = YES;
    
    CGRect rect = _detailLabel.frame;
    rect.size.width = 250;
}

@end
