//
//  LoadDataListScrollZoomViewController.h
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGXScrollZoomListViewController : UIViewController<CGXCategoryListContainerViewDelegate>
@property (nonatomic, copy) void(^didScrollCallback)(UIScrollView *scrollView);
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic , strong) NSString *tagStr;

@end

