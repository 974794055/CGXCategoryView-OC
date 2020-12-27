//
//  CGXCategoryTitleSubtitleCellModel.h
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategoryTitleCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CGXCategoryTitleSubtitleCellModel : CGXCategoryTitleCellModel

@property (nonatomic, copy) NSString *subTitle;

@property (nonatomic, strong) UIColor *subTitleNormalColor;

@property (nonatomic, strong) UIColor *subTitleSelectedColor;

@property (nonatomic, strong) UIFont *subTitleFont;

@property (nonatomic, strong) UIFont *subTitleSelectedFont;

@property (nonatomic, assign) CGFloat subTitleSpace;
@property (nonatomic, assign) CGFloat titleSpace;


@property (nonatomic, assign) BOOL isHiddenSubTitle;

@end

NS_ASSUME_NONNULL_END
