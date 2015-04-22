/**
 * This file is part of the SYIMKit Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYIMKit (https://github.com/reesun1130/SYIMKit)
 */

#import <UIKit/UIKit.h>
#import "IMTextMessage.h"

@interface IMFileMsg : IMTextMessage

@property (nonatomic, copy) NSString *fileURL;
@property (nonatomic, copy) NSString *localPath;
@property unsigned long long processFileSize;
@property unsigned long long totalSize;
@property CGFloat mprogress;

- (void)generateLoaclPath;
- (void)downLoadFile;
- (void)sendFile;
- (void)deleteFile;

@end
