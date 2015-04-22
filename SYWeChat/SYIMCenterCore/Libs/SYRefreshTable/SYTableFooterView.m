/**
 * This file is part of the SYRefreshTable package.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 743523983@qq.com>
 *
 * For more information, please view SYRefreshTable (https://github.com/reesun1130/SYRefreshTable)
 */

#import "SYTableFooterView.h"

@implementation SYTableFooterView

- (void)dealloc
{
    if (self.loadMoreBlock) {
        self.loadMoreBlock = nil;
    }
}

- (void)awakeFromNib
{
    [super awakeFromNib];

    self.infoBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.infoBtn.layer.borderWidth = .5;
    //self.backgroundColor = [UIColor clearColor];
}

- (void)readyForLoadMore
{
    [self.infoBtn setTitle:@"松开加载更多" forState:UIControlStateNormal];
}

- (void)beginForLoadMore
{
    [self.activityIndicator startAnimating];
    [self.infoBtn setTitle:@"请稍后..." forState:UIControlStateNormal];
}

- (void)endForLoadMore
{
    [self.activityIndicator stopAnimating];
    [self.infoBtn setTitle:@"上拉加载更多" forState:UIControlStateNormal];
}

- (IBAction)loadMoreAction:(id)sender
{
    if (self.loadMoreBlock) {
        self.loadMoreBlock();
    }
}

@end
