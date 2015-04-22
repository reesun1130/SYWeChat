/**
 * This file is part of the SYIMKit Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYIMKit (https://github.com/reesun1130/SYIMKit)
 */

#import "SYMainHeader.h"

@interface SYNavBasedController : UIViewController

/**
 *  设置topbar名称
 *
 *  @param atitle 名字
 */
//- (void)setTopBarTitle:(NSString *)atitle;

/**
 *  返回按钮
 */
- (IBAction)backsAction:(id)sender;

/**
 *  右侧按钮-标题
 *
 *  @param atitle 名字
 */
- (void)createRightBtnWithTitle:(NSString *)atitle;

/**
 *  右侧按钮-图片
 *
 *  @param imageString 图片名字
 */
- (void)createRightBtnWithImage:(NSString *)imageString;

/**
 *  右侧按钮事件
 */
- (void)rightBtnClick;

//加载指示符

/**
 *  显示加载指示符
 */
- (void)showLoadingHUD;

/**
 *  移除加载指示符
 */
- (void)hideLoadingHUD;

//提示指示符

/**
 *  弹出提示指示符
 *
 *  @param aMsg 要显示的内容
 */
- (void)showToastWithMessage:(NSString *)aMsg;

/**
 *  弹出带有图片的指示符：一般用于成功或操作完成提示
 *
 *  @param aMsg 要显示的内容
 */
- (void)showToastSuccessWithMessage:(NSString *)aMsg;

/**
 *  弹出带有图片的指示符：一般用于失败提示
 *
 *  @param aMsg 要显示的内容
 */
- (void)showToastFailWithMessage:(NSString *)aMsg;

/**
 *  提示服务器错误
 */
- (void)showToastServerError;

@end
