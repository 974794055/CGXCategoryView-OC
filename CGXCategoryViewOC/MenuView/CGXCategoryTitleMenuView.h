//
//  CGXCategoryTitleMenuView.h
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXCategoryViewDefines.h"
#import "CGXCategoryTitleMenuVCDelegate.h"
#import "CGXCategoryIndicatorLineView.h"
#import "CGXCategoryListContainerView.h"
#import "CGXCategoryTitleMenuModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CGXCategoryTitleMenuView : UIView

@property (nonatomic, strong) NSArray <UIView<CGXCategoryIndicatorProtocol> *> *indicators;

@property (nonatomic , strong,readonly) NSMutableArray<CGXCategoryTitleMenuModel *> *dataArray;
//当前选中下表 默认0
@property (nonatomic , assign,readonly) NSInteger currentInteger;
// 嵌套在view时使用
@property(nonatomic,weak) id <CGXCategoryTitleMenuVCDelegate>delegate;

// 标签的高度 默认View高度
@property (nonatomic , assign) CGFloat categoryViewHeight;
@property (nonatomic , assign) CGFloat topLineHeight;//上划线高度
@property (nonatomic , strong) UIColor *topLineColor;//上划线颜色
@property (nonatomic , assign) CGFloat topLineSpace;//上划线左右距离

@property (nonatomic , assign) CGFloat bottomLineHeight;//下划线高度
@property (nonatomic , strong) UIColor *bottomLineColor;//下划线颜色
@property (nonatomic , assign) CGFloat bottomLineSpace;//下划线左右距离

@property (nonatomic, assign) BOOL contentScrollAnimated; // //手势滚动中，是否有滚动动画。默认为YES
@property (nonatomic, assign) CGFloat contentEdgeInsetLeft;     //整体内容的左边距，默认CGXCategoryViewAutomaticDimension（等于cellSpacing）
@property (nonatomic, assign) CGFloat contentEdgeInsetRight;    //整体内容的右边距，默认CGXCategoryViewAutomaticDimension（等于cellSpacing）
@property (nonatomic, assign) CGFloat cellWidth;    //默认CGXCategoryViewAutomaticDimension
@property (nonatomic, assign) CGFloat cellWidthIncrement;    //cell宽度补偿。默认：0
@property (nonatomic, assign) CGFloat cellSpacing;    //cell之间的间距，默认20
@property (nonatomic, strong) UIColor *cellBackgroundNormalColor;
@property (nonatomic, strong) UIColor *cellBackgroundSelectedColor;
@property (nonatomic, strong) UIColor *titleNormalColor;//默认：[UIColor blackColor]
@property (nonatomic, strong) UIColor *titleSelectedColor; //默认：[UIColor redColor]
@property (nonatomic, strong) UIFont *titleFont;  //默认：[UIFont systemFontOfSize:14]
@property (nonatomic, strong) UIFont *titleSelectedFont;  //默认：[UIFont systemFontOfSize:14]

@property (nonatomic, assign) CGFloat titleLabelZoomScale; //是对字号的缩放，比如titleFont的pointSize为10，放大之后字号就是10*1.2=12。
@property (nonatomic, assign) BOOL averageCellSpacingEnabled;     //当collectionView.contentSize.width小于CGXCategoryBaseView的宽度，是否将cellWidth均分。默认为YES。
//cell较少时是否剧中显示状态  averageCellSpacingEnabled     为YES有效
@property (nonatomic, assign) BOOL cellWidthZenter;     //默认剧左

//图片尺寸。默认CGSizeMake(20, 20)
@property (nonatomic, assign) CGSize imageSize;
//titleLabel和ImageView的间距，默认5
@property (nonatomic, assign) CGFloat titleImageSpacing;
//图片缩放的scale。默认1.0，
@property (nonatomic, assign) CGFloat imageZoomScale;

//使用imageURL从远端下载图片进行加载，建议使用SDWebImage等第三方库进行下载。
@property (nonatomic, copy) void(^loadImageCallback)(UIImageView *imageView, NSURL *imageURL);

/**
 滚动切换的时候，滚动距离超过一页的多少百分比，就认为切换了页面。默认0.5（即滚动超过了半屏，就认为翻页了）。范围0~1，开区间不包括0和1
 */
@property (nonatomic, assign) CGFloat didAppearPercent;

- (void)updateWithDataArray:(NSMutableArray<CGXCategoryTitleMenuModel *> *)dataArray;

//当前选中下表 默认0
- (void)selectItemAtIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
