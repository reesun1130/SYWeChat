/**
 * This file is part of the SYIMKit Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYIMKit (https://github.com/reesun1130/SYIMKit)
 */

#import "IMPicMsg.h"
#import <SYCore/SYCore.h>
#import "SYMainHeader.h"
#import <SYIMKit/SYIMSharedTool.h>

@implementation IMPicMsg

- (id)init
{
	if(self = [super init])
	{
		self.MesType = IMMsgTypePic;
		self.fromself = NO;
		self.originPicLoaclPath = @"";
		self.originPicURL = @"";
	}
	return self;
}

- (void)dealloc
{
    self.thumbImage = nil;
    self.originPicLoaclPath = nil;
    self.originPicURL = nil;
}

- (void)generateLoaclPath
{
    if (self.fileURL)
    {
        NSString *filePath = [kCachesPath stringByAppendingPathComponent:self.fileURL];
        
        [SYIMSharedTool createFileDoc:filePath];
        
        self.localPath = filePath;
        self.originPicLoaclPath = filePath;
    }
    else
    {
        NSString *filePath = [kCachesPath stringByAppendingPathComponent:[self.msgUser createRelateRandPicPath]];
        
        [SYIMSharedTool createFileDoc:filePath];
        
        self.localPath = filePath;
        self.originPicLoaclPath = filePath;
    }
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
    
    /**
     *  上传文件（图片）
     */
    
    self.processFileSize = 0;
    self.procState = IMMsgProcStateProcessing;
    
    /**
     *  测试用，正常应该是你的网络请求，根据请求结果改变消息状态
     */
    [self uploadPicTestDone];
}

- (void)uploadPicTestDone
{
    self.mprogress = 1;
    self.fileURL = self.localPath;
    self.processFileSize = 100;
    self.originSize = 200;
    self.procState = IMMsgProcStateSuc;
}

@end
