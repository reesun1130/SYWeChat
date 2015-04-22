/**
 * This file is part of the SYIMKit Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYIMKit (https://github.com/reesun1130/SYIMKit)
 */

#import <UIKit/UIKit.h>

typedef enum SYTALKVIEWSTAT
{
    SYTALKVIEWSTATSTART = 0,
    SYTALKVIEWSTATRELEASING,
    SYTALKVIEWSTATTOOSHORT,
    SYTALKVIEWSTATTOOLONG,
    SYTALKVIEWSTATDELETE,
    SYTALKVIEWSTATNOMIC,
}SYTALKVIEWSTAT;

#define kDefaultTalkViewWidth 180.0
#define kDefaultTalkViewHeight 190.0

@interface SYTalkView : UIImageView

@property (nonatomic) SYTALKVIEWSTAT tstat;
@property (nonatomic) float talkProgress;

@end
