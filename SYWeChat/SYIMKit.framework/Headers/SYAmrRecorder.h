/**
 * This file is part of the SYIMKit Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYIMKit (https://github.com/reesun1130/SYIMKit)
 */

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioQueue.h>
#include <AudioToolbox/AudioToolbox.h>
#import "SYWav2amrBuffer.h"

@protocol SYAmrRecorderDelegate;

/**
 *  采用opencore本地做wav->amr格式互转
 *
 *  采样率8khz、单声道(默认左)、录制格式pcm
 * 
 *  输出文件：amr，IOS&ANDROID通用
 *  输出文件大小：1s 3/5k,1min 3/5*60k 36-40k
 */
@interface SYAmrRecorder : NSObject

@property (nonatomic, assign) id <SYAmrRecorderDelegate> delegate;
@property (nonatomic, readonly) NSUInteger mRecordFrames;

@property (nonatomic, readonly) BOOL isRecording;
@property (nonatomic, readonly) BOOL recrodEnd;
@property (nonatomic, readonly) BOOL isCanceled;
@property (nonatomic, assign) BOOL showMeter;

//限制最长时间（每帧20ms，一秒［1000ms］50帧）(如：AMR_FRAME_COUNT_PER_SECOND * 60 == 1分钟)
@property (nonatomic) NSUInteger limitRecordFrames;
@property (nonatomic, copy) NSString *mPath;

- (int)startRecodeWithPath:(NSString *)path;
- (void)recording;
- (void)cancle;
- (void)stopAndCancel;
- (void)stopRecord;

/**
 *  录制时间太长
 *
 *  @return 是否录制时间太长 最长时间60s
 */
- (BOOL)isRecordTooLong;

/**
 *  录制时间太短
 *
 *  @return 是否录制时间太长 最短时间1s
 */
- (BOOL)isRecordTooShort;

@end

@protocol SYAmrRecorderDelegate <NSObject>

@optional

- (void)syAmrRecorderDidSatart:(SYAmrRecorder *)recorder;
- (void)syAmrRecorderDidCancel:(SYAmrRecorder *)recorder;
- (void)syAmrRecorderDidStop:(SYAmrRecorder *)recorder;
- (void)syAmrRecorderDidFail:(SYAmrRecorder *)recorder;

@end


