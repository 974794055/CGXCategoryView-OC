//
//  CGXCategoryImageCellModel.h
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategoryIndicatorCellModel.h"

@interface CGXCategoryImageCellModel : CGXCategoryIndicatorCellModel

@property (nonatomic, copy) void(^loadImageCallback)(UIImageView *imageView, NSURL *imageURL);

@property (nonatomic, copy) NSString *imageName;    //加载bundle内的图片

@property (nonatomic, strong) NSURL *imageURL;      //图片URL

@property (nonatomic, copy) NSString *selectedImageName;

@property (nonatomic, strong) NSURL *selectedImageURL;

@property (nonatomic, assign) CGSize imageSize;

@property (nonatomic, assign) CGFloat imageCornerRadius;

@property (nonatomic, assign) BOOL imageZoomEnabled;    

@property (nonatomic, assign) CGFloat imageZoomScale;

@end
