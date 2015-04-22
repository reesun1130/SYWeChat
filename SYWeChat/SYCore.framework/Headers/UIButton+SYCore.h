/**
 * This file is part of the SYCore Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYCore (https://github.com/reesun1130/SYCore)
 *
 */

#import <UIKit/UIKit.h>

@interface UIButton (SYCore)

- (void)centerButtonAndImageWithSpacing:(CGFloat)spacing;
- (void)exchangeImageAndTitleWithSpacing:(CGFloat)spacing;
- (void)centerMyTitle:(CGFloat)spacing;
- (void)normalMyTitle;

/** Creates and returns a new button of type `UIButtonCustom` with the specified frame.
 @param frame The frame for the button view.
 @return A newly create button.
 */
+ (UIButton*) buttonWithFrame:(CGRect)frame;

/** Creates and returns a new button of type `UIButtonCustom` with the specified frame and title.
 @param frame The frame for the button view.
 @param title The title for `UIControlStateNormal`.
 @return A newly create button.
 */
+ (UIButton*) buttonWithFrame:(CGRect)frame title:(NSString*)title;

/** Creates and returns a new button of type `UIButtonCustom` with the specified frame, title and background image.
 @param frame The frame for the button view.
 @param title The title for `UIControlStateNormal`.
 @param backgroundImage The background image for `UIControlStateNormal`.
 @return A newly create button.
 */
+ (UIButton*) buttonWithFrame:(CGRect)frame title:(NSString*)title backgroundImage:(UIImage*)backgroundImage;

/** Creates and returns a new button of type `UIButtonCustom` with the specified frame, title and background image.
 @param frame The frame for the button view.
 @param title The title for `UIControlStateNormal`.
 @param backgroundImage The background image for `UIControlStateNormal`.
 @param highlightedBackgroundImage The background image for `UIControlStateHighlighted`
 @return A newly create button.
 */
+ (UIButton*) buttonWithFrame:(CGRect)frame title:(NSString*)title backgroundImage:(UIImage*)backgroundImage highlightedBackgroundImage:(UIImage*)highlightedBackgroundImage;


/** Creates and returns a new button of type `UIButtonCustom` with the specified frame and image.
 @param frame The frame for the button view.
 @param image The image for `UIControlStateNormal`.
 @return A newly create button.
 */
+ (UIButton*) buttonWithFrame:(CGRect)frame image:(UIImage*)image;

/** Creates and returns a new button of type `UIButtonCustom` with the specified frame, title and background image.
 @param frame The frame for the button view.
 @param image The image for `UIControlStateNormal`.
 @param highlightedImage The image for `UIControlStateHighlighted`.
 @return A newly create button.
 */
+ (UIButton*) buttonWithFrame:(CGRect)frame image:(UIImage*)image highlightedImage:(UIImage*)highlightedImage;

@end
