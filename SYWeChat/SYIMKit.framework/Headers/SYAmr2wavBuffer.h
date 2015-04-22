/**
 * This file is part of the SYIMKit Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYIMKit (https://github.com/reesun1130/SYIMKit)
 */

#import <Foundation/Foundation.h>
#import "SYAmrFileCodec.h"

@interface SYAmr2wavBuffer : NSObject
{
    FILE *fp;
    BOOL initOK;
    BOOL isFirst;
    char magic[8];
	void * destate;
	int nFrameCount ;
	int stdFrameSize;
	unsigned char stdFrameHeader;
	
	unsigned char amrFrame[MAX_AMR_FRAME_SIZE];
	short pcmFrame[PCM_FRAME_SIZE];
    BOOL tintSend;
}
- (id)initWithPath:(NSString *)path;
- (id)initWithPath2:(NSString *)path;
- (size_t)getWavBuffer:(void *)outbuff;
- (void)resetAmrfp;
- (int)nFrameCount;
@end
