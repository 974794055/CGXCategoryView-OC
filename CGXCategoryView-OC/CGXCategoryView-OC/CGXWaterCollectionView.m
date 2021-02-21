//
//  CGXWaterCollectionView.m
//  CGXWaterUIcollectionView
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXWaterCollectionView.h"

@interface CGXWaterCollectionViewCell : UICollectionViewCell

@property (nonatomic , strong) UILabel *titleLabel;
@end


@implementation CGXWaterCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
       self.titleLabel = [[UILabel alloc] initWithFrame:self.contentView.frame];
       [self.contentView addSubview:self.titleLabel];
       self.titleLabel.backgroundColor = [UIColor clearColor];
       self.titleLabel.textAlignment = NSTextAlignmentCenter;
       self.titleLabel.numberOfLines = 0;
       if (@available(iOS 13.0, *)) {
           self.titleLabel.textColor = [UIColor labelColor];
       } else {
           // Fallback on earlier versions
       }
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.frame = self.contentView.frame;
}

@end

@interface CGXWaterCollectionView ()
{
    NSInteger inter;
}
@end


@implementation CGXWaterCollectionView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadWater];
    }
    return self;
}

- (void)loadWater
{
     self.titleStr = @"";
   
    inter = arc4random() % 3+1;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection =  UICollectionViewScrollDirectionVertical;
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self addSubview:self.collectionView];
    if (@available(iOS 11.0, *)) {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self viewController:self].automaticallyAdjustsScrollViewInsets = NO;
    self.collectionView.showsVerticalScrollIndicator = YES;
    self.collectionView.showsHorizontalScrollIndicator=YES;
    [self.collectionView registerClass:[CGXWaterCollectionViewCell class] forCellWithReuseIdentifier:@"CGXWaterCollectionViewCell"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"simpleHead"];
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"simpleFoot"];
    [self.collectionView reloadData];

}
- (UIViewController *)viewController:(UIView *)view
{
    //获取当前view的superView对应的控制器
    UIResponder *next = [view nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.collectionView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    [self.collectionView reloadData];
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(8_0)
{
    cell.contentView.alpha = 0;
    cell.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(0, 0), 0);
    [UIView animateKeyframesWithDuration:.3 delay:0.0 options:0 animations:^{
        /**
         *  分步动画   第一个参数是该动画开始的百分比时间  第二个参数是该动画持续的百分比时间
         */
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.8 animations:^{
            cell.contentView.alpha = .5;
            cell.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(1.2, 1.2), 0);
            
        }];
        [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.2 animations:^{
            cell.contentView.alpha = 1;
            cell.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(1, 1), 0);
            
        }];
        
    } completion:^(BOOL finished) {
        
    }];
}
//设置head foot视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *head = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"simpleHead" forIndexPath:indexPath];
        head.backgroundColor = [UIColor orangeColor];
        return head;
    }else if([kind isEqualToString:UICollectionElementKindSectionFooter]){
        UICollectionReusableView *foot = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"simpleFoot" forIndexPath:indexPath];
        foot.backgroundColor = [UIColor colorWithWhite:0.93 alpha:1];
        return foot;
    }
    return nil;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return arc4random() % 3 + 3;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return arc4random() % 20 + 10;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
   return CGSizeMake(collectionView.bounds.size.width, 10);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
   return CGSizeMake(collectionView.bounds.size.width, 30);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = (collectionView.frame.size.width-10*(inter+1))/inter;
    return CGSizeMake(floor(width),100);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGXWaterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CGXWaterCollectionViewCell" forIndexPath:indexPath];
    cell.contentView.backgroundColor = randomColor;
    cell.titleLabel.text = [NSString stringWithFormat:@"%@",self.titleStr];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld---%ld" ,(long)indexPath.section,(long)indexPath.row);
    if (self.selectBlock) {
        self.selectBlock(indexPath);
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.scrollViewBlock) {
        self.scrollViewBlock(scrollView);
    }
}

// CollectionView分区标题即将展示
- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    view.layer.zPosition = 0.0;
}
// CollectionView分区标题展示结束
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(nonnull UICollectionReusableView *)view forElementOfKind:(nonnull NSString *)elementKind atIndexPath:(nonnull NSIndexPath *)indexPath
{

}
- (void)setTitleStr:(NSString *)titleStr
{
    _titleStr = titleStr;
    inter = arc4random() % 3+1;
    [self.collectionView reloadData];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
