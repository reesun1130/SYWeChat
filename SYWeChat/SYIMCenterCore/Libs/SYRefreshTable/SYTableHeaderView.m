/**
 * This file is part of the SYRefreshTable package.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 743523983@qq.com>
 *
 * For more information, please view SYRefreshTable (https://github.com/reesun1130/SYRefreshTable)
 */

#import "SYTableHeaderView.h"

@implementation SYTableHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];

    UIImage *arrowImage = [UIImage imageNamed:@"arrowDown"];
    
    CGRect frame = CGRectMake(98, (self.frame.size.height - 10) / 2.0, arrowImage.size.width * 10 / arrowImage.size.height, 10);

    self.arrowImageView = [[UIImageView alloc] initWithFrame:frame];
    self.arrowImageView.image = arrowImage;
    [self addSubview:self.arrowImageView];
}

- (void)beginForRefresh
{
    self.arrowImageView.hidden = YES;
    [self.activityIndicator startAnimating];
    
    self.title.text = @"请稍候...";
}

- (void)endForRefresh
{
    self.arrowImageView.hidden = NO;
    self.arrowImageView.layer.transform = CATransform3DIdentity;
    [self.activityIndicator stopAnimating];

    //self.appImageV.layer.transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
}

- (void)readyForRefresh
{
    self.arrowImageView.layer.transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
    self.title.text = @"松开刷新...";
}

- (void)cancleForRefresh
{
    self.arrowImageView.layer.transform = CATransform3DIdentity;
    self.title.text = @"下拉刷新...";
}

@end
