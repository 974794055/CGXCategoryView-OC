//
//  CGXVerticalListCollectionView.h
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CGXVerticalListCollectionView : UICollectionView

@property (nonatomic, copy) void(^layoutSubviewsCallback)(void);

@end

