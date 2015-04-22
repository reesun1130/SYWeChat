/**
 * This file is part of the SYIMKit Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYIMKit (https://github.com/reesun1130/SYIMKit)
 */

#import "IMTimeCell.h"
#import "SYMainHeader.h"
#import <SYIMKit/SYIMSharedTool.h>

@implementation IMTimeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		
		UIImage *img = [[UIImage imageNamed:@"chat_time"] resizableImageWithCapInsets:UIEdgeInsetsMake(2, 2, 2, 2)];
		
		_bgImageView = [[UIImageView alloc]initWithImage:img];
		_bgImageView.frame = CGRectMake(0, 0, 10, 5);
		
		_bgImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
		[self.contentView addSubview:_bgImageView];
        
		_timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 10,5)];
		_timeLabel.backgroundColor = [UIColor clearColor];
		_timeLabel.textAlignment = NSTextAlignmentCenter;
		_timeLabel.textColor = [UIColor whiteColor];
		_timeLabel.font = [UIFont systemFontOfSize:12];
		
		[self.contentView addSubview:_timeLabel];
    }
    return self;
}

- (void)setMsgTime:(NSString *)msgTime
{
	if(_msgTime != msgTime)
	{
        _msgTime = nil;
		_msgTime = [[[SYIMSharedTool sharedTool] generateTime:msgTime.doubleValue style:SYTimeStyleMsg] copy];
	}
	[self setNeedsLayout];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)layoutSubviews
{
	[super layoutSubviews];
    
    CGSize size = SY_TEXTSIZE(_msgTime, [UIFont systemFontOfSize:12]);
	_bgImageView.frame = CGRectMake(0, 0, size.width+10, size.height+5);
	_bgImageView.center = CGPointMake(kDeviceWidth/2, (size.height+5)/2 + 5);
	
	_timeLabel.frame = CGRectMake(0, 0, size.width+10, size.height);
	_timeLabel.center = CGPointMake(kDeviceWidth/2, (size.height+5)/2+5);
	_timeLabel.text = _msgTime;
}

@end
