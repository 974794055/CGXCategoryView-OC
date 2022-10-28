//
//  CGXListContainerAiQiMoreViewController.h
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CGXListContainerAiQiMoreViewController : BaseViewController<CGXCategoryListContainerViewDelegate>

@property (nonatomic , strong) NSString *tagStr;
@property (nonatomic, strong) UINavigationController *naviController;
@property (nonatomic, strong) NSMutableArray <NSString *> *titlesArr;
@end

NS_ASSUME_NONNULL_END
