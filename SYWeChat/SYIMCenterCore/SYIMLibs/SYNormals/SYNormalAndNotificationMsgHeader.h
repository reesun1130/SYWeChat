/**
 * This file is part of the SYIMKit Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYIMKit (https://github.com/reesun1130/SYIMKit)
 */

#ifndef kuakao_SYNormalAndNotificationMsgHeader_h
#define kuakao_SYNormalAndNotificationMsgHeader_h

static NSString * const kMsg_Collect_Ok = @"收藏成功,您可在个人中心查看";
static NSString * const kMsg_Collect_Fail = @"收藏失败";
static NSString * const kMsg_Collect_Cancle_Ok = @"取消收藏成功";
static NSString * const kMsg_Collect_Cancle_Fail = @"取消收藏失败";

static NSString * const kMsg_FeedBack_Nil = @"请输入反馈内容";
static NSString * const kMsg_POST_Ok = @"提交成功";
static NSString * const kMsg_POST_Fail = @"提交失败";

static NSString * const kMsg_NO_UNCOMPLECT_EX = @"暂无未完成的练习";

static NSString * const kMsg_NO_NEWVERSION = @"当前已经是最新版本";

static NSString * const kMsg_USERNAME_Nil = @"请输入正确的手机号";
static NSString * const kMsg_PWD_Nil = @"请输入密码";
static NSString * const kMsg_PWD_ERROR = @"请输入正确的密码";
static NSString * const kMsg_PWD_NOTEQ = @"两次密码不一致,请重新输入";
static NSString * const kMsg_YanZhengMa_ERROR = @"请输入正确的验证码";
static NSString * const kMsg_USERNAME_OR_PWD_ERROR = @"账号或密码不正确";

static NSString * const kMsg_UNCompelatQue = @"你还有未作答的题,请继续作答后提交";

static NSString * const kMsg_Normal_JiuCuoLeiXing = @"请选择纠错类型";
static NSString * const kMsg_Normal_JiuCuoFanWei = @"请选择纠错范围";
static NSString * const kMsg_Normal_JiuCuoNeiRong = @"请输入纠错内容";
static NSString * const kMsg_Normal_JiuCuoPostOK = @"提交成功,感谢您的反馈";
static NSString * const kMsg_Normal_JiuCuoPostFail = @"提交失败,请稍后再试";
static NSString * const kMsg_Normal_NoData = @"暂无数据";
static NSString * const kMsg_Paper_NoData = @"暂无试卷信息";
static NSString * const kMsg_Paper_GuFen_Unavailable = @"估分暂未开始,敬请期待";

static NSString * const kMsg_GETDATA_Fail = @"获取数据失败,请稍后再试";
static NSString * const kMsg_DOWNLOAD_Fail = @"下载失败,请稍后再试";
static NSString * const kMsg_NETWORK_UNALIVE_Fail = @"网络不可用,请稍后再试";
static NSString * const kMsg_NETWORK_TIMEOUT_Fail = @"请求超时,请稍后再试";
static NSString * const kMsg_NETWORK_WEAK_Fail = @"网络不给力,请稍候再试";
static NSString * const kMsg_NETWORK_SERVER_Fail = @"服务器繁忙,请稍后再试";

static NSString * const kMsg_Input_Nil = @"请输入内容";
static NSString * const kMsg_Saved_OK = @"保存成功";
static NSString * const kMsg_Saved_Fail = @"保存失败";

static NSString * const kMsg_Shared_OK = @"分享成功";
static NSString * const kMsg_Shared_Fail = @"分享失败";
static NSString * const kMsg_Shared_Cancle = @"分享取消";

static NSString * const kMsg_QRCode_Read_Fail = @"扫描失败";
static NSString * const kMsg_QRCode_Read_Cancle = @"扫描取消";
static NSString * const kMsg_QRCode_Read_OK = @"扫描成功";
static NSString * const kMsg_QRCode_Init_Fail = @"您没有权限访问相机,请在<设置-隐私-相机>中允许系统访问您的相机";

static NSString * const kMsg_Copy_Ok = @"复制成功,您可用QQ等发送到电脑,然后用浏览器打开作答页面";

/**
 *  通知
 */

static NSString * const kWanShanUserInfoOKNotification = @"wanShanUserInfoOKNotification";
static NSString * const kMyInfoChangedNotification = @"myInfoChangedNotification";
static NSString * const kKeMuChangedNotification = @"keMuChangedNotification";

#define kSharedImagePath [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"AppIcon57x57@2x.png"]

#endif
