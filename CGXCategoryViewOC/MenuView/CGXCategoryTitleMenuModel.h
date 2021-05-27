//
//  CGXCategoryTitleMenuModel.h
//  CGXCategoryView-OC
//
//  Created by MacMini-1 on 2021/5/24.
//

#import <Foundation/Foundation.h>
#import "CGXCategoryTitleImageCellModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CGXCategoryTitleMenuModel : NSObject
@property (nonatomic, strong) UIViewController *vcName;
@property (nonatomic, strong) NSString *title;
//默认@[CGXCategoryTitleImageType_LeftImage...]
@property (nonatomic, assign) CGXCategoryTitleImageType imageType;
//使用imageURL从远端下载图片进行加载，建议使用SDWebImage等第三方库进行下载。
@property (nonatomic, copy) void(^loadImageCallback)(UIImageView *imageView, NSURL *imageURL);
//普通状态下的imageNames，通过[UIImage imageNamed:]方法加载
@property (nonatomic, copy) NSString *imageName;
//选中状态下的imageNames，通过[UIImage imageNamed:]方法加载。
@property (nonatomic, copy) NSString *selectedImageName;
//普通状态下的imageURLs，通过loadImageCallback回调加载
@property (nonatomic, strong) NSURL *imageURL;
//选中状态下的selectedImageURLs，通过loadImageCallback回调加载
@property (nonatomic, strong) NSURL *selectedImageURL;

@end

NS_ASSUME_NONNULL_END
