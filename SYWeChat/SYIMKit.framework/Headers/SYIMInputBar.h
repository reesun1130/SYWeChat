/**
 * This file is part of the SYIMKit Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYIMKit (https://github.com/reesun1130/SYIMKit)
 */

#import <UIKit/UIKit.h>
#import "HPGrowingTextView.h"
#import "SYTalkButton.h"

typedef NS_ENUM(NSInteger, SYIMInputBarType)
{
	SYIMInputBarTypeAudio = 0,
	SYIMInputBarTypeText,
	SYIMInputBarTypeFace,
	SYIMInputBarTypeMenu
};

typedef NS_ENUM(NSInteger, SYIMInputBarStyle)
{
    SYIMInputBarStyleText = 0,
    SYIMInputBarStyleTextAndFace,
    SYIMInputBarStyleTextAndPhoto,
    SYIMInputBarStyleTextAndAudio,
    SYIMInputBarStyleTextPhotoAndFace,
    SYIMInputBarStyleTextPhotoAndAudio,
    SYIMInputBarStyleTextPhotoFaceAndAudio
};

typedef void (^SYIMInputActionBlock)(void);
typedef void (^SYIMInputInitRecordFailBlock)(void);

#define kSYIMInputHeight 50.0

@protocol SYIMInputBarDelegate;

@interface SYIMInputBar : UIView <HPGrowingTextViewDelegate>

@property (nonatomic, assign) id <SYIMInputBarDelegate> delegate;

@property (nonatomic) NSInteger limitWordsNum;
@property (nonatomic) SYIMInputBarStyle barStyle;

@property (nonatomic, copy) SYIMInputActionBlock recordStartActionBlock;
@property (nonatomic, copy) SYIMInputActionBlock recordMayEndActionBlock;
@property (nonatomic, copy) SYIMInputActionBlock recordResumeActionBlock;
@property (nonatomic, copy) SYIMInputActionBlock recordEndActionBlock;
@property (nonatomic, copy) SYIMInputActionBlock recordCancelledActionBlock;
@property (nonatomic, copy) SYIMInputInitRecordFailBlock recordInitFailBlock;//初始化录音失败，可做相应提示，如："无法访问您的麦克风，请到手机系统的设置-隐私-麦克风中设置！"

- (instancetype)initWithFrame:(CGRect)frame style:(SYIMInputBarStyle)style;//默认SYIMInputBarStyleText

- (void)closeInputBar;
- (void)appendFaceText:(NSString *)faceText;
- (void)sendInputText;
- (void)deleteLastCharOrFace;

@end

@protocol SYIMInputBarDelegate <NSObject>

@optional

- (BOOL)syIMInputBarSendText:(NSString *)message;
- (void)syIMInputBarHideFaceViewAndShowMenuView;
- (void)syIMInputBarShowFaceView;
- (void)syIMInputBarHideFaceViewAndMenuView;
- (void)syIMInputBarKeyBoardDidShow:(CGFloat)keyBoardHeight;
- (void)syIMInputBarKeyBoardDidHide;

@end
