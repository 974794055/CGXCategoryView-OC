//
//  CGXCategoryTitleFactory.h
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CGXCategoryViewDefines.h"
NS_ASSUME_NONNULL_BEGIN



@interface CGXCategoryTitleFactory : NSObject

+ (NSMutableAttributedString *)itemWithTitle:(NSString *)title;

+ (NSMutableAttributedString *)itemWithTitle:(NSString *)title
                                  TitleColor:(UIColor *)titleColor;

+ (NSMutableAttributedString *)itemWithTitle:(NSString *)title
                                  TitleColor:(UIColor *)titleColor
                                   TitleFont:(UIFont *)titleFont;

+ (NSMutableAttributedString *)itemWithTitle:(NSString *)title
                                  TitleColor:(UIColor *)titleColor
                                   TitleFont:(UIFont *)titleFont
                                 LineSpacing:(CGFloat)lineSpacing;
/*
 imageStr :本地图片名称
 width  :图片显示宽度
 height :图片显示高度
 */
+ (NSMutableAttributedString *)itemWithImageStr:(NSString *)imageStr;
+ (NSMutableAttributedString *)itemWithImageStr:(NSString *)imageStr
                                          Width:(CGFloat)width
                                         Height:(CGFloat)height;

+ (NSMutableAttributedString *)itemWithMoreTitle:(NSString *)title
                                        ImageStr:(NSString *)imageStr;

+ (NSMutableAttributedString *)itemWithMoreTitle:(NSString *)title
                                        ImageStr:(NSString *)imageStr
                                        Position:(CGXCategoryTitlePosition)position;

+ (NSMutableAttributedString *)itemWithMoreTitle:(NSString *)title
                                        ImageStr:(NSString *)imageStr
                                      TitleColor:(UIColor *)titleColor
                                        Position:(CGXCategoryTitlePosition)position;

+ (NSMutableAttributedString *)itemWithMoreTitle:(NSString *)title
                                        ImageStr:(NSString *)imageStr
                                      TitleColor:(UIColor *)titleColor
                                       TitleFont:(UIFont *)titleFont
                                        Position:(CGXCategoryTitlePosition)position;

+ (NSMutableAttributedString *)itemWithMoreTitle:(NSString *)title
                                        ImageStr:(NSString *)imageStr
                                      TitleColor:(UIColor *)titleColor
                                       TitleFont:(UIFont *)titleFont
                                     LineSpacing:(CGFloat)lineSpacing
                                        Position:(CGXCategoryTitlePosition)position;
@end

NS_ASSUME_NONNULL_END
