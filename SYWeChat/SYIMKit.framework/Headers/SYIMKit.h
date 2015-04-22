/**
 * This file is part of the SYIMKit Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYIMKit (https://github.com/reesun1130/SYIMKit)
 *
 * SYIMKit 模仿了微信聊天UI布局，其中支持用户输入模块(可灵活定制包含输入框、录音、表情选择、拍照、从相册选取照片功能)、录音模块(采用opencore-amr[支持armv7、armv7s、arm64]，语音输出格式amr并完美支持IOS和Android系统播放)
 *
 * 使用时需添加SYCore.framework及SYIMKit.bundle资源文件
 */

#import <UIKit/UIKit.h>

//! Project version number for SYIMKit.
FOUNDATION_EXPORT double SYIMKitVersionNumber;

//! Project version string for SYIMKit.
FOUNDATION_EXPORT const unsigned char SYIMKitVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <SYIMKit/PublicHeader.h>

#import <SYIMKit/SYIMTableView.h>
#import <SYIMKit/SYIMFaceView.h>
#import <SYIMKit/SYIMInputBar.h>
#import <SYIMKit/SYMenuView.h>
#import <SYIMKit/SYTalkButton.h>
#import <SYIMKit/SYTalkView.h>
#import <SYIMKit/SYIMMsgTool.h>
#import <SYIMKit/HPGrowingTextView.h>
#import <SYIMKit/HPTextViewInternal.h>
#import <SYIMKit/SYAmr2wavBuffer.h>
#import <SYIMKit/SYWav2amrBuffer.h>
#import <SYIMKit/SYAmrRecorder.h>
#import <SYIMKit/interf_dec.h>
#import <SYIMKit/interf_enc.h>
#import <SYIMKit/SYAmrFileCodec.h>
#import <SYIMKit/IMAudioPlayer.h>
#import <SYIMKit/SYTTTAttributedLabel.h>
#import <SYIMKit/SYIMSharedTool.h>
#import <SYIMKit/SYIMNormalDefineHeader.h>
