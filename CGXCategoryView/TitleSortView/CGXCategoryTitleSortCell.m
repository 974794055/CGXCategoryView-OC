//
//  CGXCategoryTitleSortCell.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategoryTitleSortCell.h"

#import "CGXCategoryTitleSortCellModel.h"

@interface CGXCategoryTitleSortCell ()
@property (nonatomic, strong) UIImageView *upImageView;
@property (nonatomic, strong) UIImageView *downImageView;
@property (nonatomic, strong) UIImageView *singleImageView;

@property (nonatomic, strong) UIImageView *olnyImageView;

@property (nonatomic, strong) NSLayoutConstraint *upCenterYCons;
@property (nonatomic, strong) NSLayoutConstraint *downCenterYCons;
@end

@implementation CGXCategoryTitleSortCell
- (void)initializeViews {
    [super initializeViews];
    
    self.upImageView = [[UIImageView alloc] init];
    self.upImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.upImageView.hidden = YES;
    [self.contentView addSubview:self.upImageView];
    
    self.downImageView = [[UIImageView alloc] init];
    self.downImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.downImageView.hidden = YES;
    [self.contentView addSubview:self.downImageView];
    
    self.singleImageView = [[UIImageView alloc] init];
    self.singleImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.singleImageView.hidden = YES;
    [self.contentView addSubview:self.singleImageView];
    
    
    self.olnyImageView = [[UIImageView alloc] init];
    self.olnyImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.olnyImageView.hidden = YES;
    [self.contentView addSubview:self.olnyImageView];
    
    self.upImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.upImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:15].active = YES;
    [NSLayoutConstraint constraintWithItem:self.upImageView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.titleLabel attribute:NSLayoutAttributeTrailing multiplier:1 constant:0].active = YES;
    self.upCenterYCons = [NSLayoutConstraint constraintWithItem:self.upImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    self.upCenterYCons.active = YES;
    
    
    self.downImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.downImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:15].active = YES;
    [NSLayoutConstraint constraintWithItem:self.downImageView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.upImageView attribute:NSLayoutAttributeLeading multiplier:1 constant:0].active = YES;
    self.downCenterYCons = [NSLayoutConstraint constraintWithItem:self.downImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    self.downCenterYCons.active = YES;
    
    
    self.singleImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.singleImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:20].active = YES;
    [NSLayoutConstraint constraintWithItem:self.singleImageView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.titleLabel attribute:NSLayoutAttributeTrailing multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.singleImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0].active = YES;
    
    
    self.olnyImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint constraintWithItem:self.olnyImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0].active = YES;
    
    [NSLayoutConstraint constraintWithItem:self.olnyImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0].active = YES;
    
    
}

- (void)reloadData:(CGXCategoryBaseCellModel *)cellModel {
    [super reloadData:cellModel];
    
    CGXCategoryTitleSortCellModel *myCellModel = (CGXCategoryTitleSortCellModel *)cellModel;
    self.downImageView.image = myCellModel.arrowBottomImage;
    self.upImageView.image = myCellModel.arrowTopImage;
    self.singleImageView.image = myCellModel.singleImage;
    self.olnyImageView.image = myCellModel.singleImage;
    
    self.upImageView.hidden = YES;
    self.downImageView.hidden = YES;
    self.singleImageView.hidden = YES;
    self.titleLabel.hidden = NO;
    self.olnyImageView.hidden = YES;
    
    if (myCellModel.sortUIType == CGXCategoryTitleSortUIType_ArrowBoth) {
        if (myCellModel.arrowDirection == CGXCategoryTitleSortArrowDirection_Both) {
            self.upImageView.hidden = NO;
            self.downImageView.hidden = NO;
            self.upCenterYCons.constant = -3;
            self.downCenterYCons.constant = 3;
        }else if (myCellModel.arrowDirection == CGXCategoryTitleSortArrowDirection_Up) {
            self.upImageView.hidden = NO;
            self.upCenterYCons.constant = 0;
        }else {
            self.downImageView.hidden = NO;
            self.downCenterYCons.constant = 0;
        }
    }else if (myCellModel.sortUIType == CGXCategoryTitleSortUIType_ArrowUpDown) {
        if (myCellModel.arrowDirection == CGXCategoryTitleSortArrowDirection_Down || myCellModel.arrowDirection == CGXCategoryTitleSortArrowDirection_Both){
            self.downImageView.hidden = NO;
            self.downCenterYCons.constant = 0;
        } else{
            self.upImageView.hidden = NO;
            self.upCenterYCons.constant = 0;
        }
    }else if (myCellModel.sortUIType == CGXCategoryTitleSortUIType_SingleImage) {
        self.singleImageView.hidden = NO;
    }else if (myCellModel.sortUIType == CGXCategoryTitleSortUIType_OnlyImage) {
        self.olnyImageView.hidden = NO;
        self.titleLabel.hidden = YES;
    }
}

@end
