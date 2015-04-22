//
//  UIBadgeView.m
//  UIBadgeView
//  
//  Copyright (C) 2011 by Omer Duzyol
// 
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
// 
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
// 
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.


#define HEXCOLOR(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#import "UIBadgeView.h"
#import "SYNormalDefineHeader.h"

@interface UIBadgeView()

@property (nonatomic, retain) UIFont *font;
@property (nonatomic, assign) NSUInteger width;

@end


@implementation UIBadgeView

@synthesize width, badgeString, parent, badgeColor, badgeColorHighlighted, shadowEnabled,delegate;
// from private
@synthesize font;

- (id) initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame])
	{
		font = [UIFont boldSystemFontOfSize: 14];
		
		self.backgroundColor = [UIColor clearColor];
	}
	
	return self;	
}

- (void) setBadgeString:(NSString *)value
{
	badgeString = value;
	
	[self setNeedsDisplay];
}

- (void) setShadowEnabled:(BOOL)value{
	shadowEnabled = value;
	
	[self setNeedsDisplay];
}

- (void) drawRect:(CGRect)rect
{	
	NSString *countString = badgeString;
	
    CGSize numberSize = SY_TEXTSIZE(countString, font);//[countString sizeWithFont: font];
	
	self.width = numberSize.width + 16;
	
	CGRect bounds = CGRectMake(0 , 0, numberSize.width + 13 , 21);
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	UIColor *col;
	if (parent.highlighted || parent.selected) {
		if (self.badgeColorHighlighted) {
			col = self.badgeColorHighlighted;
		} else {
			col = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
		}
	} else {
		if (self.badgeColor) {
			col = self.badgeColor;
		} else {
			col = HEXCOLOR(0xf61f29ff);
			//col = HEXCOLOR(0xff0000ff);
		}
	}
	
	if (shadowEnabled) {
		// draw shadow first
		CGContextSaveGState(context);
		CGContextClearRect(context, bounds);
	
		CGContextSetShadowWithColor(context, CGSizeMake(0, 3), 2, [HEXCOLOR(0x000000ff) CGColor]);
	
		CGContextSetFillColorWithColor(context, [HEXCOLOR(0xffffffff) CGColor]);
	
		CGRect shadowRect = CGRectMake(bounds.origin.x + 2, 
									   bounds.origin.y + 1, 
									   bounds.size.width - 4, 
									   bounds.size.height - 3);
	
		[self drawRoundedRect:shadowRect inContext:context withRadius:8];
	
		CGContextDrawPath(context, kCGPathFill);
	
		CGContextRestoreGState(context);
	}
	
	CGContextSaveGState(context);	
	//CGContextClearRect(context, bounds);
	CGContextSetAllowsAntialiasing(context, true);
	CGContextSetLineWidth(context, 0.0);
	CGContextSetAlpha(context, 1.0); 
	
	CGContextSetLineWidth(context, 2.0);
		
	CGContextSetStrokeColorWithColor(context, [HEXCOLOR(0xffffffff) CGColor]);
	CGContextSetFillColorWithColor(context, [col CGColor]);
		
	// Draw background
	
	CGFloat backOffset = 2;
	CGRect backRect = CGRectMake(bounds.origin.x + backOffset, 
								 bounds.origin.y + backOffset, 
								 bounds.size.width - backOffset*2, 
								 bounds.size.height - backOffset*2);
	
	[self drawRoundedRect:backRect inContext:context withRadius:8];

	CGContextDrawPath(context, kCGPathFillStroke);
	/*
	// Clip Context
	CGRect clipRect = CGRectMake(backRect.origin.x + backOffset-1, 
								 backRect.origin.y + backOffset-1, 
								 backRect.size.width - (backOffset-1)*2, 
								 backRect.size.height - (backOffset-1)*2);
	
	[self drawRoundedRect:clipRect inContext:context withRadius:8];
	CGContextClip (context);
	
	CGContextSetBlendMode(context, kCGBlendModeClear);*/

	CGContextRestoreGState(context);

	
	CGRect ovalRect = CGRectMake(2, 1, bounds.size.width-4, 
								 bounds.size.height /2);
	
	bounds.origin.x = (bounds.size.width - numberSize.width) / 2 + 0.5;
	bounds.origin.y++;
	
	CGContextSetFillColorWithColor(context, [HEXCOLOR(0xffffffff)  CGColor]);
	
    [countString drawInRect:bounds withAttributes:@{NSFontAttributeName:self.font,NSForegroundColorAttributeName:[UIColor whiteColor]}];
	
	CGContextSaveGState(context);
	
	//Draw highlight
	CGGradientRef glossGradient;
	CGColorSpaceRef rgbColorspace;
	size_t num_locations = 9;
	CGFloat locations[9] = { 0.0, 0.10, 0.25, 0.40, 0.45, 0.50, 0.65, 0.75, 1.00 };
//	CGFloat components[8] = { 1.0, 1.0, 1.0, 0.40, 1.0, 1.0, 1.0, 0.06 };
	CGFloat components[36] = { 
		1.0, 1.0, 1.0, 1.00,
		1.0, 1.0, 1.0, 0.55,
		1.0, 1.0, 1.0, 0.20,
		1.0, 1.0, 1.0, 0.20,
		1.0, 1.0, 1.0, 0.15,
		1.0, 1.0, 1.0, 0.10,
		1.0, 1.0, 1.0, 0.10,
		1.0, 1.0, 1.0, 0.05,
		1.0, 1.0, 1.0, 0.05 };
	rgbColorspace = CGColorSpaceCreateDeviceRGB();
	glossGradient = CGGradientCreateWithColorComponents(rgbColorspace, 
														components, locations, num_locations);
	
	CGPoint start = CGPointMake(bounds.origin.x, bounds.origin.y);
	CGPoint end = CGPointMake(bounds.origin.x, bounds.size.height*2);
	
	CGContextSetAlpha(context, 1.0); 

	//[self drawRoundedRect:ovalRect inContext:context withRadius:4];
	
	CGContextBeginPath (context);
	
	CGFloat minx = CGRectGetMinX(ovalRect), midx = CGRectGetMidX(ovalRect), 
	maxx = CGRectGetMaxX(ovalRect);
	
	CGFloat miny = CGRectGetMinY(ovalRect), midy = CGRectGetMidY(ovalRect), 
	maxy = CGRectGetMaxY(ovalRect);
	
	CGContextMoveToPoint(context, minx, midy);
	CGContextAddArcToPoint(context, minx, miny, midx, miny, 8);
	CGContextAddArcToPoint(context, maxx, miny, maxx, midy, 8);
	CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, 4);
	CGContextAddArcToPoint(context, minx, maxy, minx, midy, 4);
	CGContextClosePath(context);

	CGContextClip (context);
	
//	CGContextDrawLinearGradient(context, glossGradient, start, end, 0);
	CGContextDrawLinearGradient(context, glossGradient, start, end, 0);
	
	CGGradientRelease(glossGradient);
	CGColorSpaceRelease(rgbColorspace); 

	CGContextSetFillColorWithColor(context, [HEXCOLOR(0x000000ff) CGColor]);
	
	CGContextRestoreGState(context);
}

- (void) drawRoundedRect:(CGRect) rrect
               inContext:(CGContextRef) context
			  withRadius:(CGFloat) radius
{
	CGContextBeginPath (context);
	
	CGFloat minx = CGRectGetMinX(rrect), midx = CGRectGetMidX(rrect), 
	maxx = CGRectGetMaxX(rrect);
	
	CGFloat miny = CGRectGetMinY(rrect), midy = CGRectGetMidY(rrect), 
	maxy = CGRectGetMaxY(rrect);
	
	CGContextMoveToPoint(context, minx, midy);
	CGContextAddArcToPoint(context, minx, miny, midx, miny, radius);
	CGContextAddArcToPoint(context, maxx, miny, maxx, midy, radius);
	CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
	CGContextAddArcToPoint(context, minx, maxy, minx, midy, radius);
	CGContextClosePath(context);
}

//badge按下事件
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	//UIButton *btn = (UIButton *)self.superview;
	//[self.delegate performSelector:@selector(selectedTab:) withObject:btn];
}

- (void) dealloc
{
    font = nil;
    badgeString = nil;
    badgeColor = nil;
    badgeColorHighlighted = nil;    
}

@end
