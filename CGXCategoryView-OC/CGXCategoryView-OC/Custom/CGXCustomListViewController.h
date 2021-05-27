//
//  CGXCustomListViewController.h
//  CGXCategoryView-OC
//
//  Created by CGX on 2021/5/23.
//  Copyright © 2021 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^CGXCustomListViewControllerSelectBlock)(NSIndexPath *indexPath);

typedef void(^CGXCustomListViewControllerScrollViewBlock)(UIScrollView *scrollView);
@interface CGXCustomListViewController : UIViewController<CGXCategoryListContainerViewDelegate>
@property (strong, nonatomic) NSAttributedString *titleStr;

@property (copy, nonatomic) CGXCustomListViewControllerSelectBlock selectBlock;

@property (copy, nonatomic) CGXCustomListViewControllerScrollViewBlock scrollViewBlock;

@end

NS_ASSUME_NONNULL_END
