//
//  CGXCategoryCollectionView.h
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXCategoryIndicatorProtocol.h"

@class CGXCategoryCollectionView;

@protocol CGXCategoryCollectionViewGestureDelegate <NSObject>
@optional
- (BOOL)categoryCollectionView:(CGXCategoryCollectionView *)collectionView gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer;
- (BOOL)categoryCollectionView:(CGXCategoryCollectionView *)collectionView gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer;
@end

@interface CGXCategoryCollectionView : UICollectionView

@property (nonatomic, strong) NSArray <UIView<CGXCategoryIndicatorProtocol> *> *indicators;

@property (nonatomic, weak) id<CGXCategoryCollectionViewGestureDelegate> gestureDelegate;

@end
