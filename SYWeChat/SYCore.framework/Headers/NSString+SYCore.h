/**
 * This file is part of the SYCore Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYCore (https://github.com/reesun1130/SYCore)
 *
 */

#import <UIKit/UIKit.h>

@interface NSString (SYCore)

/*
 检查是否特殊字符
 */

- (BOOL)isEmailAddress;
- (BOOL)isLetters;
- (BOOL)isNumbers;
- (BOOL)isNumberOrLetters;
- (BOOL)isPhoneNumber;

/*
 字符串尺寸
 */
- (CGFloat)widthWithFont:(UIFont *)font;
- (CGFloat)widthWithFont:(UIFont *)font
      constrainedToWidth:(CGFloat)width;
- (CGFloat)widthWithFont:(UIFont *)font
      constrainedToWidth:(CGFloat)width
           lineBreakMode:(NSLineBreakMode)lineBreakMode;

- (CGFloat)heightWithFont:(UIFont *)font
       constrainedToWidth:(CGFloat)width;
- (CGFloat)heightWithFont:(UIFont *)font
       constrainedToWidth:(CGFloat)width
            lineBreakMode:(NSLineBreakMode)lineBreakMode;

/*
 计算文本的size ios7 or later
 */
-(CGSize)boundingRectWithSize:(CGSize)size
                 withTextFont:(UIFont *)font
              withLineSpacing:(CGFloat)lineSpacing;

/*
 sting转AttributedString
 */
-(NSMutableAttributedString *)attributedStringFromStingWithFont:(UIFont *)font
                                                withLineSpacing:(CGFloat)lineSpacing;

/*
 检测是否含有某字符
 */
- (BOOL)containsSYString:(NSString *)string;
- (BOOL)containsSYString:(NSString *)string
            ignoringCase:(BOOL)ignore;

/*
 判断字符串里首否含有汉字
 */
- (BOOL)containsHanZiString;

/*
 两字符串是否==
 */
- (BOOL)equalsToString:(NSString *)string;
- (BOOL)equalsToString:(NSString *)string ignoringCase:(BOOL)ignore;

/**
 *  判断字符串是否为空 nil @"" 等
 *
 *  @return yes/no
 */
- (BOOL)isNULLString;

/**
 *  获取题目下划线属性
 *
 *  @return 带有下划线属性的字符串
 */
- (NSAttributedString *)getKuaKaoAttributeStringHTML;

/**
 *  获取详细带有html属性的文本
 *
 *  @return html文本
 */
//- (NSAttributedString *)getKuaKaoAttributeStringHTMLDetail;

- (NSInteger)hexIntegerValue;

- (NSString *)fixUrl;

@end
