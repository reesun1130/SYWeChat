/**
 * This file is part of the SYCore Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYCore (https://github.com/reesun1130/SYCore)
 *
 */

@import UIKit;

#define kMAX_IMAGEDATA_LEN 200.0 * 1024 * 2  //max data length 200K

typedef enum {
    PPImageRoundCornerModeAll = 0,
    PPImageRoundCornerModeLeft,
    PPImageRoundCornerModeTop,
    PPImageRoundCornerModeRight,
    PPImageRoundCornerModeBottom,
    PPImageRoundCornerModeLeftTop,
    PPImageRoundCornerModeTopRight,
    PPImageRoundCornerModeRightBottom,
    PPImageRoundCornerModeBottomLeft
} PPImageRoundCornerMode;

typedef enum {
    PPImageCropModeTopLeft = 0,
    PPImageCropModeTopCenter,
    PPImageCropModeTopRight,
    PPImageCropModeBottomLeft,
    PPImageCropModeBottomCenter,
    PPImageCropModeBottomRight,
    PPImageCropModeLeftCenter,
    PPImageCropModeRightCenter,
    PPImageCropModeCenter
} PPImageCropMode;

@interface UIImage (SYCore)

/*
 * Stretchable image
 */
- (UIImage *)stretchableImage;
- (UIImage *)stretchableImageWithCapInsets:(UIEdgeInsets)capInsets;

/*
 * Round corner
 */
- (UIImage *)makeRoundCornersOfSize:(CGSize)cornerSize; // All
- (UIImage *)makeRoundCornersOfSize:(CGSize)cornerSize usingMode:(PPImageRoundCornerMode)mode;

/*
 * Cropping
 */
- (UIImage *)cropCenter;
- (UIImage *)cropToSize:(CGSize)newSize; // TopLeft
- (UIImage *)cropToSize:(CGSize)newSize usingMode:(PPImageCropMode)mode;
- (UIImage *)cropAt:(CGRect)rect;

/*
 * Scaling
 */
- (UIImage *)scaleToFitSize:(CGSize)bounds;
- (UIImage *)scaleByFactor:(CGFloat)factor;
- (UIImage *)scaleToSize:(CGSize)size;
- (UIImage *)scalingAndCroppingToSize:(CGSize)targetSize;

/*
 * Merging
 */
- (UIImage *)mergeWithImage:(UIImage *)image;
- (UIImage *)mergeAtCenterWithImage:(UIImage *)image;
- (UIImage *)mergeWithImage:(UIImage *)image atPoint:(CGPoint)point;

/*
 * Masking
 */
//- (UIImage *)maskWithImage:(UIImage *)image;

/*
 * Filtering
 */
- (UIImage *)sepia;
- (UIImage *)grayscale;
- (UIImage *)negative;

/**
 *  fix ori
 */

- (UIImage *)fixOrientation;

/**
 *  压缩
 */

- (NSData *)compressedData;

/**
 *  旋转
 */

- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;

/**
 * 模糊度
 */

- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;

/**
 *  读取bundle image
 */

+ (UIImage *)imagesNamed:(NSString *)imageName fromBundle:(NSString *)bundleName;

@end
