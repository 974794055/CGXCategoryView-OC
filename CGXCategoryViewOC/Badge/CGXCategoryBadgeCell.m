//
//  CGXCategoryBadgeCell.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2020/05/20.
//

#import "CGXCategoryBadgeCell.h"
@interface CGXCategoryBadgeCell ()


@end

@implementation CGXCategoryBadgeCell

- (void)initializeViews
{
    [super initializeViews];
    
    self.numberLabel = ({
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.layer.masksToBounds = YES;
        label;
    });
    [self.contentView addSubview:self.numberLabel];
}
- (void)layoutSubviews {
    [super layoutSubviews];

}

- (void)reloadData:(CGXCategoryBaseCellModel *)cellModel {
    [super reloadData:cellModel];
    
    CGXCategoryBadgeCellModel *myCellModel = (CGXCategoryBadgeCellModel *)cellModel;
    
    self.numberLabel.hidden = myCellModel.badgeModel.count == 0;
    self.numberLabel.backgroundColor = myCellModel.badgeModel.numberBackgroundColor;
    self.numberLabel.font = myCellModel.badgeModel.numberLabelFont;
    self.numberLabel.textColor = myCellModel.badgeModel.numberTitleColor;
    self.numberLabel.text = myCellModel.badgeModel.numberString;
    if (myCellModel.badgeModel.isFormatter) {
        if (myCellModel.badgeModel.count>myCellModel.badgeModel.numberMax) {
            self.numberLabel.text =  [NSString stringWithFormat:@"%ld",(long)myCellModel.badgeModel.numberMax];
        }
    }
    [self.numberLabel sizeToFit];
    CGFloat width = self.numberLabel.bounds.size.width;
    CGFloat x = CGRectGetMaxX(self.titleLabel.frame);
    CGFloat y = CGRectGetMinY(self.titleLabel.frame);
    if (myCellModel.imageType==CGXCategoryTitleImageType_TopImage) {
        x = CGRectGetMaxX(self.imageView.frame);
        y = CGRectGetMinY(self.imageView.frame);
    } else if (myCellModel.imageType==CGXCategoryTitleImageType_BottomImage){
        x = CGRectGetMaxX(self.titleLabel.frame);
        y = CGRectGetMinY(self.titleLabel.frame);
    } else if (myCellModel.imageType==CGXCategoryTitleImageType_LeftImage){
        x = CGRectGetMaxX(self.titleLabel.frame);
        y = CGRectGetMinY(self.titleLabel.frame);
    } else if (myCellModel.imageType==CGXCategoryTitleImageType_RightImage){
        x = CGRectGetMaxX(self.imageView.frame);
        y = CGRectGetMinY(self.imageView.frame);
    } else if (myCellModel.imageType==CGXCategoryTitleImageType_OnlyImage){
        x = CGRectGetMaxX(self.imageView.frame);
        y = CGRectGetMinY(self.imageView.frame);
    } else{
        x = CGRectGetMaxX(self.titleLabel.frame);
        y = CGRectGetMinY(self.titleLabel.frame);
    }
    
    if (myCellModel.badgeModel.badgeAdaptive) {
        self.numberLabel.bounds = CGRectMake(0, 0, width + myCellModel.badgeModel.numberLabelWidthIncrement, myCellModel.badgeModel.numberLabelHeight);
    } else{
        self.numberLabel.bounds = CGRectMake(0, 0,myCellModel.badgeModel.numberLabelWidth, myCellModel.badgeModel.numberLabelHeight);
    }
    self.numberLabel.center = CGPointMake(x+myCellModel.badgeModel.numberLabelOffset.x, y+myCellModel.badgeModel.numberLabelOffset.y);
    
    CGRect numFrame = CGRectMake(0, 0, CGRectGetWidth(self.numberLabel.frame), CGRectGetHeight(self.numberLabel.frame));
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = numFrame;
    
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.frame = numFrame;
    borderLayer.lineWidth = myCellModel.badgeModel.borderWidth;
    borderLayer.strokeColor = myCellModel.badgeModel.borderColor.CGColor;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.numberLabel.bounds byRoundingCorners:(UIRectCorner)myCellModel.badgeModel.roundedType cornerRadii:CGSizeMake(myCellModel.badgeModel.numberLabelHeight/2.0, myCellModel.badgeModel.numberLabelHeight/2.0)];;
    maskLayer.path = bezierPath.CGPath;
    borderLayer.path = bezierPath.CGPath;
    
    [self.numberLabel.layer insertSublayer:borderLayer atIndex:0];
    [self.numberLabel.layer setMask:maskLayer];

    [self setNeedsLayout];
}



@end
