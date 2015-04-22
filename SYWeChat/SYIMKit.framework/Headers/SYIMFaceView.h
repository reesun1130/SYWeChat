/**
 * This file is part of the SYIMKit Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYIMKit (https://github.com/reesun1130/SYIMKit)
 */

#import <UIKit/UIKit.h>

#define kSYFaceViewHeight 190.0

@protocol SYIMFaceViewDelegate;

@interface SYIMFaceView : UIView<UIScrollViewDelegate>

@property (nonatomic, assign) id <SYIMFaceViewDelegate> delegate;

@end

@protocol SYIMFaceViewDelegate <NSObject>

@optional

- (void)faceViewDeleteLastFace:(SYIMFaceView *)faceView;
- (void)faceView:(SYIMFaceView *)faceView addFaceStr:(NSString *)facestr;
- (void)faceViewSend:(SYIMFaceView *)faceView;

@end
