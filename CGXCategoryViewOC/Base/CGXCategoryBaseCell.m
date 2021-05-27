//
//  CGXCategoryBaseCell.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategoryBaseCell.h"
#import "CGXCategoryFactory.h"
@interface CGXCategoryBaseCell ()
@property (nonatomic, strong) CGXCategoryBaseCellModel *cellModel;
@property (nonatomic, strong) CGXCategoryViewAnimator *animator;
@property (nonatomic, strong) NSMutableArray <CGXCategoryCellSelectedAnimationBlock> *animationBlockArray;
@end

@implementation CGXCategoryBaseCell

- (void)dealloc
{
    [self.animator stop];
}

- (void)prepareForReuse {
    [super prepareForReuse];

    [self.animator stop];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeViews];
    }
    return self;
}

- (void)initializeViews {
    _animationBlockArray = [NSMutableArray array];
    
    [CGXCategoryFactory horizontalFlipViewIfNeeded:self];
    [CGXCategoryFactory horizontalFlipViewIfNeeded:self.contentView];
}

- (void)reloadData:(CGXCategoryBaseCellModel *)cellModel {
    self.cellModel = cellModel;

    if (cellModel.selectedAnimationEnabled) {
        [self.animationBlockArray removeLastObject];
        if ([self checkCanStartSelectedAnimation:cellModel]) {
            _animator = [[CGXCategoryViewAnimator alloc] init];
            self.animator.duration = cellModel.selectedAnimationDuration;
        }else {
            [self.animator stop];
        }
    }
}

- (BOOL)checkCanStartSelectedAnimation:(CGXCategoryBaseCellModel *)cellModel {
    if (cellModel.selectedType == CGXCategoryCellSelectedTypeNode || cellModel.selectedType == CGXCategoryCellSelectedTypeClick) {
        return YES;
    }
    return NO;
}

- (void)addSelectedAnimationBlock:(CGXCategoryCellSelectedAnimationBlock)block {
    [self.animationBlockArray addObject:block];
}

- (void)startSelectedAnimationIfNeeded:(CGXCategoryBaseCellModel *)cellModel {
    if (cellModel.selectedAnimationEnabled && [self checkCanStartSelectedAnimation:cellModel]) {
        //需要更新isTransitionAnimating，用于处理在过滤时，禁止响应点击，避免界面异常。
        cellModel.transitionAnimating = true;
        __weak typeof(self)weakSelf = self;
        self.animator.progressCallback = ^(CGFloat percent) {
            for (CGXCategoryCellSelectedAnimationBlock block in weakSelf.animationBlockArray) {
                block(percent);
            }
        };
        self.animator.completeCallback = ^{
            cellModel.transitionAnimating = NO;
            [weakSelf.animationBlockArray removeAllObjects];
        };
        [self.animator start];
    }
}

@end
