//
//  CGXWaterCollectionView.h
//  CGXWaterUIcollectionView
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CGXWaterCollectionViewSelectBlock)(NSIndexPath *indexPath);

typedef void(^CGXWaterCollectionViewScrollViewBlock)(UIScrollView *scrollView);

@interface CGXWaterCollectionView : UIView<UICollectionViewDelegate, UICollectionViewDataSource>
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSString *titleStr;

@property (copy, nonatomic) CGXWaterCollectionViewSelectBlock selectBlock;

@property (copy, nonatomic) CGXWaterCollectionViewScrollViewBlock scrollViewBlock;

@end
