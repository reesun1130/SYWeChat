//
//  MCProgressBarView.h
//  MCProgressBarView
//
//  Created by Baglan on 12/29/12.
//  Copyright (c) 2012 MobileCreators. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCProgressBarView : UIView

- (id)initWithFrame:(CGRect)frame backgroundImage:(UIImage *)backgroundImage foregroundImage:(UIImage *)foregroundImage;

@property (nonatomic, assign) double progress;

@end
