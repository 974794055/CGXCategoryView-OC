//
//  UIImage+LOveScanColor.h
//  CGXCategoryView-OC
//
//  Created by CGX on 2022/1/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (LOveScanColor)
/**
 *  生成图片
 */
+ (UIImage*)imageWithColor:(UIColor*)color Size:(CGSize)size;
//改变图片颜色
- (UIImage *)updateimageWithColor:(UIColor *)color;
   
/** 圆角图片 */
- (UIImage *)imageWithCornerRadius:(CGFloat)radius;
//高效添加圆角图片
- (UIImage*)imageWithCornerRadius:(CGFloat)radius andSize:(CGSize)size;


/*
 1.先对画布进行裁切
 2.填充背景颜色
 3.执行绘制logo
 4.添加并绘制白色边框
 5.白色边框的基础上进行绘制黑色分割线
 */
+ (UIImage *)clipCornerRadius:(UIImage *)image withSize:(CGSize)size Radius:(CGFloat)radius FillColor:(UIColor *)fillColor;
@end

NS_ASSUME_NONNULL_END
