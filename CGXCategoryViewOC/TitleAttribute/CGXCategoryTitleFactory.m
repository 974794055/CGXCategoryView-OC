//
//  CGXCategoryTitleFactory.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategoryTitleFactory.h"

@implementation CGXCategoryTitleFactory

+ (NSMutableAttributedString *)itemWithTitle:(NSString *)title
{
    return [self itemWithTitle:title TitleColor:[UIColor blackColor]];
}
+ (NSMutableAttributedString *)itemWithTitle:(NSString *)title TitleColor:(UIColor *)titleColor
{
    return [self itemWithTitle:title TitleColor:titleColor TitleFont:[UIFont systemFontOfSize:14]];
}
+ (NSMutableAttributedString *)itemWithTitle:(NSString *)title TitleColor:(UIColor *)titleColor TitleFont:(UIFont *)titleFont
{
    return [self itemWithTitle:title TitleColor:titleColor TitleFont:titleFont LineSpacing:2];
}
+ (NSMutableAttributedString *)itemWithTitle:(NSString *)title TitleColor:(UIColor *)titleColor TitleFont:(UIFont *)titleFont LineSpacing:(CGFloat)lineSpacing
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    
    [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:title]];
    [attributedString addAttribute:NSFontAttributeName
                             value:titleFont
                             range:NSMakeRange(0, [title length])];
    [attributedString addAttribute:NSForegroundColorAttributeName
                             value:titleColor
                             range:NSMakeRange(0, [title length])];
    //设置文本段落排版格式，
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.firstLineHeadIndent = 0;
    style.lineSpacing = lineSpacing;
    style.alignment = NSTextAlignmentCenter;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:style  range:NSMakeRange(0, attributedString.length)];
    return attributedString;
}


+ (NSMutableAttributedString *)itemWithImageStr:(NSString *)imageStr
{
    return [self itemWithImageStr:imageStr Width:20 Height:20];
}

+ (NSMutableAttributedString *)itemWithImageStr:(NSString *)imageStr Width:(CGFloat)width Height:(CGFloat)height
{
    NSMutableAttributedString* attributedString = [[NSMutableAttributedString alloc] init];
    NSTextAttachment* attach = [[NSTextAttachment alloc] init];
    attach.image = [UIImage imageNamed:imageStr];
    attach.bounds = CGRectMake(0, 0, width, height);
    NSAttributedString* attStr1 = [NSAttributedString attributedStringWithAttachment:attach];
    [attributedString appendAttributedString:attStr1];
    return attributedString;
}


+ (NSMutableAttributedString *)itemWithMoreTitle:(NSString *)title
                                        ImageStr:(NSString *)imageStr
{
    return [self itemWithMoreTitle:title ImageStr:imageStr Position:CGXCategoryTitlePositionTop];
}
+ (NSMutableAttributedString *)itemWithMoreTitle:(NSString *)title
                                        ImageStr:(NSString *)imageStr
                                        Position:(CGXCategoryTitlePosition)position
{
    return [self itemWithMoreTitle:title ImageStr:imageStr TitleColor:[UIColor blackColor] Position:position];
}

+ (NSMutableAttributedString *)itemWithMoreTitle:(NSString *)title
                                        ImageStr:(NSString *)imageStr
                                      TitleColor:(UIColor *)titleColor
                                        Position:(CGXCategoryTitlePosition)position
{
    return [self itemWithMoreTitle:title ImageStr:imageStr TitleColor:titleColor TitleFont:[UIFont systemFontOfSize:14] Position:position];
}

+ (NSMutableAttributedString *)itemWithMoreTitle:(NSString *)title
                                        ImageStr:(NSString *)imageStr
                                      TitleColor:(UIColor *)titleColor
                                       TitleFont:(UIFont *)titleFont
                                        Position:(CGXCategoryTitlePosition)position
{
    return [self itemWithMoreTitle:title ImageStr:imageStr TitleColor:titleColor TitleFont:titleFont LineSpacing:5 Position:position];
}

+ (NSMutableAttributedString *)itemWithMoreTitle:(NSString *)title
                                        ImageStr:(NSString *)imageStr
                                      TitleColor:(UIColor *)titleColor
                                       TitleFont:(UIFont *)titleFont
                                     LineSpacing:(CGFloat)lineSpacing
                                        Position:(CGXCategoryTitlePosition)position
{
    return [self itemWithMoreTitle:title ImageStr:imageStr TitleColor:titleColor TitleFont:titleFont LineSpacing:lineSpacing ImageSize:CGSizeMake(20, 20) Position:position];
}
+ (NSMutableAttributedString *)itemWithMoreTitle:(NSString *)title
                                        ImageStr:(NSString *)imageStr
                                      TitleColor:(UIColor *)titleColor
                                       TitleFont:(UIFont *)titleFont
                                     LineSpacing:(CGFloat)lineSpacing
                                       ImageSize:(CGSize)imageSize
                                        Position:(CGXCategoryTitlePosition)position
{
    NSMutableAttributedString* attributedString = [[NSMutableAttributedString alloc] init];
    switch (position) {
        case CGXCategoryTitlePositionTop:
        {
            [attributedString appendAttributedString:[self itemWithImageStr:imageStr Width:imageSize.width Height:imageSize.height]];
            [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
            [attributedString appendAttributedString:[self itemWithTitle:title TitleColor:titleColor TitleFont:titleFont]];
        }
            break;
        case CGXCategoryTitlePositionBottom:
        {
            [attributedString appendAttributedString:[self itemWithTitle:title TitleColor:titleColor TitleFont:titleFont]];
            [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
            [attributedString appendAttributedString:[self itemWithImageStr:imageStr Width:imageSize.width Height:imageSize.height]];
        }
            break;
        case CGXCategoryTitlePositionLeft:
        {
            [attributedString appendAttributedString:[self itemWithImageStr:imageStr Width:imageSize.width Height:imageSize.height]];
            [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@" "]];
            [attributedString appendAttributedString:[self itemWithTitle:title TitleColor:titleColor TitleFont:titleFont]];
        }
            break;
        case CGXCategoryTitlePositionRight:
        {
            [attributedString appendAttributedString:[self itemWithTitle:title TitleColor:titleColor TitleFont:titleFont]];
            [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@" "]];
            [attributedString appendAttributedString:[self itemWithImageStr:imageStr Width:imageSize.width Height:imageSize.height]];
        }
            break;
        default:
            break;
    }
    //设置文本段落排版格式，
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.firstLineHeadIndent = 0;
    style.lineSpacing = lineSpacing;
    style.alignment = NSTextAlignmentCenter;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:style  range:NSMakeRange(0, attributedString.length)];
    return attributedString;
}
@end
