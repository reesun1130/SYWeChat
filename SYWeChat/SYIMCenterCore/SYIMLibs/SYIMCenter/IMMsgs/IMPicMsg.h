/**
 * This file is part of the SYIMKit Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYIMKit (https://github.com/reesun1130/SYIMKit)
 */

#import "IMFileMsg.h"

@interface IMPicMsg : IMFileMsg

@property (nonatomic, copy) NSString *originPicURL;
@property (nonatomic, copy) NSString *originPicLoaclPath;
@property (nonatomic, strong) UIImage *thumbImage;
@property (nonatomic) NSUInteger originSize;

@end
