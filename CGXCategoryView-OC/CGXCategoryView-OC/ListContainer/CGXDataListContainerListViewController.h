//
//  CGXDataListContainerListViewController.h
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGXDataListContainerListViewController : UIViewController <CGXCategoryListContainerViewDelegate>

@property (nonatomic , strong) NSString *tagStr;
@property (nonatomic, strong) UINavigationController *naviController;
@end

