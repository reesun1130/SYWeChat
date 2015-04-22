/**
 * This file is part of the SYIMKit Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYIMKit (https://github.com/reesun1130/SYIMKit)
 */

#import "IMFileMsg.h"
#import <SYCore/SYCore.h>

#import "SYMainHeader.h"
#import "IMAudioMsg.h"
#import "IMPicMsg.h"

@implementation IMFileMsg

- (id)init
{
	if((self = [super init]))
	{
		self.MesType = IMMsgTypeFile;
		self.fromself = NO;
		self.localPath = @"";
		self.fileURL = @"";
	}
	return self;
}


- (void)dealloc
{
    self.fileURL = nil;
    self.localPath = nil;
}

- (void)generateLoaclPath
{
	NSString *docDir = [[NSFileManager defaultManager] documentsDirectoryPath];
	self.localPath = [docDir stringByAppendingPathComponent:[self.fileURL lastPathComponent]];
}

- (void)deleteFile
{
    NSFileManager *manager = [NSFileManager defaultManager];
    [manager removeItemAtPath:self.localPath error:nil];
}

- (void)downLoadFile
{
    if(self.procState == IMMsgProcStateSuc || self.procState == IMMsgProcStateProcessing || [SYIMSharedTool parserInfo:self.fileURL] == nil || [SYIMSharedTool parserInfo:self.localPath])
	{
		return;
	}
	
	self.processFileSize = 0;
	[self generateLoaclPath];
	self.procState = IMMsgProcStateProcessing;
    
    /**
     *  测试用，正常应该是你的网络请求，根据请求结果改变消息状态
     */
    [self downloadTestDone];
}

- (void)sendFile
{
	if(!self.fromself || self.procState == IMMsgProcStateSuc || self.procState == IMMsgProcStateProcessing ||self.localPath == nil)
	{
		return;
	}
    
	if(![SYSharedTool isNetWorkActive])
	{
		self.procState = IMMsgProcStateFaied;

		return;
	}
    
    self.processFileSize = 0;
	self.procState = IMMsgProcStateProcessing;

    /**
     *  测试用，正常应该是你的网络请求，根据请求结果改变消息状态
     */
    [self uploadTestDone];
}

- (void)uploadTestDone
{
    self.mprogress = 1;
    self.fileURL = self.localPath;
    self.processFileSize = 100;
    self.procState = IMMsgProcStateSuc;
}

- (void)downloadTestDone
{
    self.mprogress = 1;
    self.processFileSize = 100 * 1;
    self.totalSize = 100;
    self.procState = IMMsgProcStateSuc;
}

@end
