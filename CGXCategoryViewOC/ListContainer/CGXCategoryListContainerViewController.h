//
//  CGXCategoryListContainerViewController.h
//  CGXCategoryView-OC
//
//  Created by CGX on 2021/5/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CGXCategoryListContainerViewController : UIViewController
@property (copy) void(^__nullable viewWillAppearBlock)(void);
@property (copy) void(^__nullable viewDidAppearBlock)(void);
@property (copy) void(^__nullable viewWillDisappearBlock)(void);
@property (copy) void(^__nullable viewDidDisappearBlock)(void);
@end

NS_ASSUME_NONNULL_END
