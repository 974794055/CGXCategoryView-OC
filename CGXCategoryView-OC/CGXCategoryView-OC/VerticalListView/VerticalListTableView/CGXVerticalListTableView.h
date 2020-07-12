//
//  CGXVerticalListTableView.h
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CGXVerticalListTableView : UITableView
@property (nonatomic, copy) void(^layoutSubviewsCallback)(void);
@end

NS_ASSUME_NONNULL_END
