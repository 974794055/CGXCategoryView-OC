//
//  CGXCategoryTitlePinCell.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategoryTitlePinCell.h"
#import "CGXCategoryTitlePinCellModel.h"
@interface CGXCategoryTitlePinCell()
@property (nonatomic, strong) UIImageView *pinImgView;
@property (nonatomic, strong) UIImage *currentImageName;
@property (nonatomic, strong) NSURL *currentImageURL;

@property (nonatomic, strong) NSLayoutConstraint *pinTop;
@property (nonatomic, strong) NSLayoutConstraint *pinBottom;
@property (nonatomic, strong) NSLayoutConstraint *pinLeft;
@property (nonatomic, strong) NSLayoutConstraint *pinRight;
@end
@implementation CGXCategoryTitlePinCell
- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.currentImageName = nil;
    self.currentImageURL = nil;
}
- (void)initializeViews {
    [super initializeViews];
    
    self.pinImgView = [[UIImageView alloc] init];
    self.pinImgView.contentMode = UIViewContentModeScaleAspectFit;
    self.pinImgView.layer.masksToBounds =  YES;
    self.pinImgView.clipsToBounds = YES;
    [self.contentView addSubview:self.pinImgView];
    self.pinImgView.translatesAutoresizingMaskIntoConstraints = NO;
    self.pinTop = [NSLayoutConstraint constraintWithItem:self.pinImgView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    [NSLayoutConstraint activateConstraints:@[self.pinTop]];
    
    self.pinBottom = [NSLayoutConstraint constraintWithItem:self.pinImgView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    [NSLayoutConstraint activateConstraints:@[self.pinBottom]];
    
    self.pinLeft = [NSLayoutConstraint constraintWithItem:self.pinImgView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    [NSLayoutConstraint activateConstraints:@[self.pinLeft]];
    
    self.pinRight = [NSLayoutConstraint constraintWithItem:self.pinImgView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    [NSLayoutConstraint activateConstraints:@[self.pinRight]];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    
    CGXCategoryTitlePinCellModel *myCellModel = (CGXCategoryTitlePinCellModel *)self.cellModel;
    [self updateUIModel:myCellModel];
}
- (void)reloadData:(CGXCategoryBaseCellModel *)cellModel {
    [super reloadData:cellModel];
    CGXCategoryTitlePinCellModel *myCellModel = (CGXCategoryTitlePinCellModel *)cellModel;
    UIImage *currentImageName = nil;
    NSURL *currentImageURL = nil;
    if (myCellModel.pinImage != nil) {
        currentImageName = myCellModel.pinImage;
    }else if (myCellModel.imageURL != nil) {
        currentImageURL = myCellModel.imageURL;
    }
    if (currentImageName != nil && currentImageName != self.currentImageName) {
        self.currentImageName = currentImageName;
        self.pinImgView.image = currentImageName;
    }else if (currentImageURL != nil && ![currentImageURL.absoluteString isEqualToString:self.currentImageURL.absoluteString]) {
        self.currentImageURL = currentImageURL;
        if (myCellModel.loadImageCallback != nil) {
            myCellModel.loadImageCallback(self.pinImgView, currentImageURL);
        }
    }
    self.pinImgView.hidden = !cellModel.selected;

    [self updateUIModel:myCellModel];
}
- (void)updateUIModel:(CGXCategoryTitlePinCellModel *)myCellModel
{
    
    if (!myCellModel.selected) {
        [self refreshTitleLabelCenter:CGPointMake(self.contentView.center.x, self.contentView.center.y)];
    } else{
        CGSize imageSize = myCellModel.imageSize;
        CGFloat titleWidth = self.titleLabel.bounds.size.width;
        CGFloat contentWidth = imageSize.width + myCellModel.titleImageSpacing + titleWidth;
        CGFloat space = (self.contentView.bounds.size.width - contentWidth)/2;
        self.pinTop.constant = (CGRectGetHeight(self.contentView.frame)-imageSize.height)/2.0;
        self.pinBottom.constant =-(CGRectGetHeight(self.contentView.frame)-imageSize.height)/2.0;
        
        switch (myCellModel.imagePosition) {
                
            case CGXCategoryCellClickedPosition_Left:
            {
                self.pinLeft.constant = space;
                self.pinRight.constant = -(self.contentView.bounds.size.width - space-imageSize.width);
                [self refreshTitleLabelCenter:CGPointMake(CGRectGetMaxX(self.pinImgView.frame) + myCellModel.titleImageSpacing + titleWidth/2, self.contentView.center.y)];
            }
                break;
            case CGXCategoryCellClickedPosition_Right:
            {
                CGFloat contentWidth = imageSize.width + myCellModel.titleImageSpacing + titleWidth;
                [self refreshTitleLabelCenter:CGPointMake((self.contentView.bounds.size.width - contentWidth)/2 + titleWidth/2, self.contentView.center.y)];
                self.pinLeft.constant = self.contentView.bounds.size.width - space-imageSize.width;
                self.pinRight.constant = -space;
            }
                break;
            default:
                break;
        }
    }
}
- (void)refreshTitleLabelCenter:(CGPoint)center {
    CGXCategoryTitlePinCellModel *myCellModel = (CGXCategoryTitlePinCellModel *)self.cellModel;
    if (myCellModel.titleLabelAnchorPointStyle == CGXCategoryTitleLabelAnchorPointStyleBottom) {
        center.y += (myCellModel.titleHeight/2 + myCellModel.titleLabelVerticalOffset);
    }else if (myCellModel.titleLabelAnchorPointStyle == CGXCategoryTitleLabelAnchorPointStyleTop) {
        center.y -= (myCellModel.titleHeight/2 + myCellModel.titleLabelVerticalOffset);
    }
    self.titleLabelCenterX.constant = center.x - self.contentView.bounds.size.width/2;
    self.titleLabelCenterY.constant = center.y - self.contentView.bounds.size.height/2;
}
@end
