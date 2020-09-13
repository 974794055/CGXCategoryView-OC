//
//  MyListViewController.h
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXCategoryTitleMenuVCDelegate.h"
#import "CGXMenuViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CGXMenuListViewController : UIViewController<CGXCategoryTitleMenuVCDelegate>


@property (nonatomic , strong) NSString *tagStr;
@end

NS_ASSUME_NONNULL_END
