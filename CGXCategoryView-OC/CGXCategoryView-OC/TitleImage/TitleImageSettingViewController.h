//
//  TitleImageSettingViewController.h
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "BaseViewController.h"

@protocol TitleTitleImageSettingViewControllerDelegate <NSObject>

- (void)titleImageSettingVCDidSelectedImageType:(CGXCategoryTitleImageType)imageType;

@end

@interface TitleImageSettingViewController : BaseViewController

@property (nonatomic, weak) id<TitleTitleImageSettingViewControllerDelegate> delegate;

@property (nonatomic, assign) CGXCategoryTitleImageType imageType;

@end
