/**
 * This file is part of the SYIMKit Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYIMKit (https://github.com/reesun1130/SYIMKit)
 */

#import "IMFileMsg.h"
#import <SYIMKit/IMAudioPlayer.h>

@interface IMAudioMsg : IMFileMsg <IMAudioPlayerDelegate>

@property (nonatomic, strong) IMAudioPlayer *audioPlayer;
@property (nonatomic, copy) NSString *audioURL;
@property (nonatomic, copy) NSString *audioPath;
@property (nonatomic, assign) NSUInteger audioTimeLength;
@property (nonatomic, assign) BOOL read;

- (long)audioFileLength;
- (void)playAudio;
- (void)stopAudio;
- (void)pauseAudio;
- (void)resumeAudio;
- (void)setAudioTimeLengthWithFramesLength:(NSUInteger)length;

@end
