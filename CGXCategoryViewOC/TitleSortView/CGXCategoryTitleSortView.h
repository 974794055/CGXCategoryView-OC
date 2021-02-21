//
//  CGXCategoryTitleSortView.h
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategoryTitleView.h"
#import "CGXCategoryTitleSortCell.h"
#import "CGXCategoryTitleSortCellModel.h"

NS_ASSUME_NONNULL_BEGIN


@interface CGXCategoryTitleSortView : CGXCategoryTitleView
/*
 key:  index
 value: @(CGXCategoryTitleSortUIType)
 */
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, NSNumber *> *sortUITypeDic;
/*
 key:  index
 value: @(CGXCategoryTitleSortArrowDirection)
 */
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, NSNumber *> *arrowDirections;
/*
 key:  index
 value: UIImage
 */
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, UIImage *> *singleImages;

/*
key:  index  是否显示某个分割线
value: BooL
*/
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, NSNumber *> *separatorLineDic;
/*
上箭头图片
*/
@property (nonatomic, strong) UIImage *arrowTopImage;
/*
下箭头图片
*/
@property (nonatomic, strong) UIImage *arrowBottomImage;

/*
单张图片
*/
@property (nonatomic, strong) UIImage *singleImageImage;






@end

NS_ASSUME_NONNULL_END
