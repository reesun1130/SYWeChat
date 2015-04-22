//
//  MCProgressBarView.m
//  MCProgressBarView
//
//  Created by Baglan on 12/29/12.
//  Copyright (c) 2012 MobileCreators. All rights reserved.
//

#import "MCProgressBarView.h"

@implementation MCProgressBarView {
    UIImageView * _backgroundImageView;
    UIImageView * _foregroundImageView;
    CGFloat minimumForegroundWidth;
    CGFloat availableWidth;
}

- (id)initWithFrame:(CGRect)frame backgroundImage:(UIImage *)backgroundImage foregroundImage:(UIImage *)foregroundImage
{
    self = [super initWithFrame:frame];
    if (self) {
        _backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _backgroundImageView.image = backgroundImage;
        [self addSubview:_backgroundImageView];
        
        _foregroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _foregroundImageView.image = foregroundImage;
        [self addSubview:_foregroundImageView];
        
        UIEdgeInsets insets = foregroundImage.capInsets;
        minimumForegroundWidth = insets.left + insets.right;
        
        availableWidth = self.bounds.size.width - minimumForegroundWidth;
        
        self.progress = 0.5;
    }
    return self;
}

- (void)setProgress:(double)progress
{
    _progress = progress;
    
    CGRect frame = _foregroundImageView.frame;
    frame.size.width = roundf(minimumForegroundWidth + availableWidth * progress);
    _foregroundImageView.frame = frame;
}

@end
