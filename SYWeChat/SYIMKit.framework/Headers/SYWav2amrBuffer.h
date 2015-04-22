/**
 * This file is part of the SYIMKit Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYIMKit (https://github.com/reesun1130/SYIMKit)
 */

#import <Foundation/Foundation.h>
#import "SYAmrFileCodec.h"

@interface SYWav2amrBuffer : NSObject
{
    FILE *fp;
    BOOL initOK;
    BOOL isFirst;
    char magic[8];
	void * enstate;
	int nFrameCount ;
	int bytes;
	unsigned char stdFrameHeader;
	
	unsigned char amrFrame[MAX_AMR_FRAME_SIZE];
}

- (id)initWithPath:(NSString *)path;
- (int)putWavBuffer:(void *)buffer bsize:(size_t)bufsize;

@end
