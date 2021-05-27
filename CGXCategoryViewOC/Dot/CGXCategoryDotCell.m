//
//  CGXCategoryDotCell.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategoryDotCell.h"
#import "CGXCategoryDotCellModel.h"

@interface CGXCategoryDotCell ()
@property (nonatomic, strong) CALayer *dotLayer;
@end

@implementation CGXCategoryDotCell

- (void)initializeViews {
    [super initializeViews];

    _dotLayer = [CALayer layer];
    [self.contentView.layer addSublayer:self.dotLayer];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateUI:self.cellModel];
}

- (void)reloadData:(CGXCategoryBaseCellModel *)cellModel {
    [super reloadData:cellModel];

    CGXCategoryDotCellModel *myCellModel = (CGXCategoryDotCellModel *)cellModel;
    [self updateUI:myCellModel];
}
- (void)updateUI:(CGXCategoryBaseCellModel *)cellModel
{
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    CGXCategoryDotCellModel *myCellModel = (CGXCategoryDotCellModel *)cellModel;
    self.dotLayer.hidden = !myCellModel.dotHidden;
    self.dotLayer.bounds = CGRectMake(0, 0, myCellModel.dotSize.width, myCellModel.dotSize.height);
    self.dotLayer.cornerRadius = myCellModel.dotCornerRadius;
    self.dotLayer.borderColor = [myCellModel.dotborderColor CGColor];
    self.dotLayer.borderWidth = myCellModel.dotborderWidth;
    if (myCellModel.dotStyle == JXCategoryDotStyle_Hollow) {
        self.dotLayer.backgroundColor = [[UIColor clearColor] CGColor];
    }else{
        self.dotLayer.backgroundColor = [myCellModel.dotColor CGColor];
    }

    switch (myCellModel.relativePosition) {
        case CGXCategoryDotRelativePosition_TopLeft:
        {
            BOOL dot = NO;
            if (myCellModel.imageType==CGXCategoryTitleImageType_TopImage) {
                dot = YES;
            } else if (myCellModel.imageType==CGXCategoryTitleImageType_BottomImage){
                dot = NO;
            } else if (myCellModel.imageType==CGXCategoryTitleImageType_LeftImage){
                dot = YES;
            } else if (myCellModel.imageType==CGXCategoryTitleImageType_RightImage){
                dot = NO;
            } else if (myCellModel.imageType==CGXCategoryTitleImageType_OnlyImage){
                dot = YES;
            } else{
                dot = NO;
            }
            if (dot) {
                self.dotLayer.position = CGPointMake(CGRectGetMinX(self.imageView.frame)-myCellModel.dotOffset.x, CGRectGetMinY(self.imageView.frame)+myCellModel.dotOffset.y);
            } else{
                self.dotLayer.position = CGPointMake(CGRectGetMinX(self.titleLabel.frame)-myCellModel.dotOffset.x, CGRectGetMinY(self.titleLabel.frame)+myCellModel.dotOffset.y);
            }
        }
            break;
        case CGXCategoryDotRelativePosition_TopRight:
        {
            BOOL dot = NO;
            if (myCellModel.imageType==CGXCategoryTitleImageType_TopImage) {
                dot = YES;
            } else if (myCellModel.imageType==CGXCategoryTitleImageType_BottomImage){
                dot = NO;
            } else if (myCellModel.imageType==CGXCategoryTitleImageType_LeftImage){
                dot = NO;
            } else if (myCellModel.imageType==CGXCategoryTitleImageType_RightImage){
                dot = YES;
            } else if (myCellModel.imageType==CGXCategoryTitleImageType_OnlyImage){
                dot = YES;
            } else{
                dot = NO;
            }
            if (dot) {
                self.dotLayer.position = CGPointMake(CGRectGetMaxX(self.imageView.frame)+myCellModel.dotOffset.x, CGRectGetMinY(self.imageView.frame)+myCellModel.dotOffset.y);
            } else{
                self.dotLayer.position = CGPointMake(CGRectGetMaxX(self.titleLabel.frame)+myCellModel.dotOffset.x, CGRectGetMinY(self.titleLabel.frame)+myCellModel.dotOffset.y);
            }
        }
            break;
        case CGXCategoryDotRelativePosition_BottomLeft:
        {
            
            BOOL dot = NO;
            if (myCellModel.imageType==CGXCategoryTitleImageType_TopImage) {
                dot = NO;
            } else if (myCellModel.imageType==CGXCategoryTitleImageType_BottomImage){
                dot = YES;
            } else if (myCellModel.imageType==CGXCategoryTitleImageType_LeftImage){
                dot = YES;
            } else if (myCellModel.imageType==CGXCategoryTitleImageType_RightImage){
                dot = NO;
            } else if (myCellModel.imageType==CGXCategoryTitleImageType_OnlyImage){
                dot = YES;
            } else{
                dot = NO;
            }
            if (dot) {
                self.dotLayer.position = CGPointMake(CGRectGetMinX(self.imageView.frame)-myCellModel.dotOffset.x, CGRectGetMaxY(self.imageView.frame)+myCellModel.dotOffset.y);
            } else{
                self.dotLayer.position = CGPointMake(CGRectGetMinX(self.titleLabel.frame)-myCellModel.dotOffset.x, CGRectGetMaxY(self.titleLabel.frame)+myCellModel.dotOffset.y);
            }
        }
            break;
        case CGXCategoryDotRelativePosition_BottomRight:
        {
            BOOL dot = NO;
            if (myCellModel.imageType==CGXCategoryTitleImageType_TopImage) {
                dot = NO;
            } else if (myCellModel.imageType==CGXCategoryTitleImageType_BottomImage){
                dot = YES;
            } else if (myCellModel.imageType==CGXCategoryTitleImageType_LeftImage){
                dot = NO;
            } else if (myCellModel.imageType==CGXCategoryTitleImageType_RightImage){
                dot = YES;
            } else if (myCellModel.imageType==CGXCategoryTitleImageType_OnlyImage){
                dot = YES;
            } else{
                dot = NO;
            }
            if (dot) {
                self.dotLayer.position = CGPointMake(CGRectGetMaxX(self.imageView.frame)+myCellModel.dotOffset.x, CGRectGetMaxY(self.imageView.frame)+myCellModel.dotOffset.y);
            } else{
                self.dotLayer.position = CGPointMake(CGRectGetMaxX(self.titleLabel.frame)+myCellModel.dotOffset.x, CGRectGetMaxY(self.titleLabel.frame)+myCellModel.dotOffset.y);
            }
        }
            break;

        default:
            break;
    }
    [CATransaction commit];
}


@end
