//
//  CGXCategoryTitlePinCellModel.h
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategoryTitleCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CGXCategoryTitlePinCellModel : CGXCategoryTitleCellModel

//使用imageURL从远端下载图片进行加载，建议使用SDWebImage等第三方库进行下载。
@property (nonatomic, copy) void(^loadImageCallback)(UIImageView *imageView, NSURL *imageURL);
//普通状态下的imageURLs，通过loadImageCallback回调加载
@property (nonatomic, strong) NSURL *imageURL;
@property (nonatomic, strong) UIImage *pinImage;
@property (nonatomic, assign) CGSize   imageSize;

@property (nonatomic, assign) CGXCategoryCellClickedPosition imagePosition;
//titleLabel和ImageView的间距，默认5
@property (nonatomic, assign) CGFloat titleImageSpacing;
@end

NS_ASSUME_NONNULL_END
