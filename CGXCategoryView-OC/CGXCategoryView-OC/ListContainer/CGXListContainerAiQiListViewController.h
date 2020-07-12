//
//  CGXListContainerAiQiListViewController.h
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CGXListContainerAiQiListViewController : UIViewController<CGXCategoryListContainerViewDelegate>

@property (nonatomic , strong) NSString *tagStr;
@property (nonatomic, strong) UINavigationController *naviController;

@end

NS_ASSUME_NONNULL_END
