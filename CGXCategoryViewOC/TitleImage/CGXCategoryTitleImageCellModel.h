//
//  CGXCategoryTitleImageCellModel.h
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategoryTitleCellModel.h"

typedef NS_ENUM(NSUInteger, CGXCategoryTitleImageType) {
    CGXCategoryTitleImageType_TopImage = 0,
    CGXCategoryTitleImageType_LeftImage,
    CGXCategoryTitleImageType_BottomImage,
    CGXCategoryTitleImageType_RightImage,
    CGXCategoryTitleImageType_OnlyImage,
    CGXCategoryTitleImageType_OnlyTitle,
};

@interface CGXCategoryTitleImageCellModel : CGXCategoryTitleCellModel

//默认@[CGXCategoryTitleImageType_LeftImage...]
@property (nonatomic, assign) CGXCategoryTitleImageType imageType;
//使用imageURL从远端下载图片进行加载，建议使用SDWebImage等第三方库进行下载。
@property (nonatomic, copy) void(^loadImageCallback)(UIImageView *imageView, NSURL *imageURL);

//普通状态下的imageNames，通过[UIImage imageNamed:]方法加载
@property (nonatomic, copy) NSString *imageName;    
//选中状态下的imageNames，通过[UIImage imageNamed:]方法加载。可选
@property (nonatomic, copy) NSString *selectedImageName;
//普通状态下的imageURLs，通过loadImageCallback回调加载
@property (nonatomic, strong) NSURL *imageURL;
//选中状态下的selectedImageURLs，通过loadImageCallback回调加载
@property (nonatomic, strong) NSURL *selectedImageURL;
//图片尺寸。默认CGSizeMake(20, 20)
@property (nonatomic, assign) CGSize imageSize;    
//titleLabel和ImageView的间距，默认5
@property (nonatomic, assign) CGFloat titleImageSpacing;   
//图片是否缩放。默认为NO
@property (nonatomic, assign) BOOL imageZoomEnabled;
//图片缩放的最大scale。默认1.2，imageZoomEnabled为YES才生效
@property (nonatomic, assign) CGFloat imageZoomScale;
//选中图片缩放的最大scale。默认1.2，imageZoomEnabled为YES才生效
@property (nonatomic, assign) CGFloat selectImageZoomScale;

@end
