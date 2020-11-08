//
//  CGXCategoryImageCell.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategoryTitleImageCell.h"
#import "CGXCategoryTitleImageCellModel.h"


@interface CGXCategoryTitleImageCell()
@property (nonatomic, strong) NSString *currentImageName;
@property (nonatomic, strong) NSURL *currentImageURL;
@end

@implementation CGXCategoryTitleImageCell

- (void)prepareForReuse {
    [super prepareForReuse];

    self.currentImageName = nil;
    self.currentImageURL = nil;
}

- (void)initializeViews {
    [super initializeViews];

    _imageView = [[UIImageView alloc] init];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_imageView];
}

- (void)layoutSubviews {
    [super layoutSubviews];


}
- (void)refreshTitleLabelCenter:(CGPoint)center {
    CGXCategoryTitleImageCellModel *myCellModel = (CGXCategoryTitleImageCellModel *)self.cellModel;
    if (myCellModel.titleLabelAnchorPointStyle == CGXCategoryTitleLabelAnchorPointStyleBottom) {
        center.y += (self.titleLabel.bounds.size.height/2 + myCellModel.titleLabelVerticalOffset);
    }else if (myCellModel.titleLabelAnchorPointStyle == CGXCategoryTitleLabelAnchorPointStyleTop) {
        center.y -= (self.titleLabel.bounds.size.height/2 + myCellModel.titleLabelVerticalOffset);
    }
    self.titleLabelCenterX.constant = center.x - self.contentView.bounds.size.width/2;
    self.titleLabelCenterY.constant = center.y - self.contentView.bounds.size.height/2;
}
- (void)reloadData:(CGXCategoryBaseCellModel *)cellModel {
    [super reloadData:cellModel];
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];

    CGXCategoryTitleImageCellModel *myCellModel = (CGXCategoryTitleImageCellModel *)cellModel;
    self.titleLabel.hidden = NO;
    self.imageView.hidden = NO;
    CGSize imageSize = myCellModel.imageSize;
    self.imageView.bounds = CGRectMake(0, 0, imageSize.width, imageSize.height);
    
    
    CGFloat titleheight = self.titleLabel.bounds.size.height;
    CGFloat titleWidth = self.titleLabel.bounds.size.width;

    switch (myCellModel.imageType) {
        case CGXCategoryTitleImageType_TopImage:
        {
            CGFloat contentHeight = imageSize.height + myCellModel.titleImageSpacing + titleheight;
            self.imageView.center = CGPointMake(self.contentView.center.x, (self.contentView.bounds.size.height - contentHeight)/2 + imageSize.height/2);
             [self refreshTitleLabelCenter:CGPointMake(self.contentView.center.x, CGRectGetMaxY(self.imageView.frame) + myCellModel.titleImageSpacing + titleheight/2)];
        }
            break;

        case CGXCategoryTitleImageType_LeftImage:
        {
            CGFloat contentWidth = imageSize.width + myCellModel.titleImageSpacing + titleWidth;
            self.imageView.center = CGPointMake((self.contentView.bounds.size.width - contentWidth)/2 + imageSize.width/2, self.contentView.center.y);
             [self refreshTitleLabelCenter:CGPointMake(CGRectGetMaxX(self.imageView.frame) + myCellModel.titleImageSpacing + titleWidth/2, self.contentView.center.y)];
        }
            break;

        case CGXCategoryTitleImageType_BottomImage:
        {
            CGFloat contentHeight = imageSize.height + myCellModel.titleImageSpacing + titleheight;
             [self refreshTitleLabelCenter:CGPointMake(self.contentView.center.x, (self.contentView.bounds.size.height - contentHeight)/2 + titleheight/2)];
            self.imageView.center = CGPointMake(self.contentView.center.x, CGRectGetMaxY(self.titleLabel.frame) + myCellModel.titleImageSpacing + imageSize.height/2);
        }
            break;

        case CGXCategoryTitleImageType_RightImage:
        {
            CGFloat contentWidth = imageSize.width + myCellModel.titleImageSpacing + titleWidth;
             [self refreshTitleLabelCenter:CGPointMake((self.contentView.bounds.size.width - contentWidth)/2 + titleWidth/2, self.contentView.center.y)];
            self.imageView.center = CGPointMake(CGRectGetMaxX(self.titleLabel.frame) + myCellModel.titleImageSpacing + imageSize.width/2, self.contentView.center.y);
        }
            break;

        case CGXCategoryTitleImageType_OnlyImage:
        {
            self.titleLabel.hidden = YES;
            self.imageView.center = self.contentView.center;
        }
            break;

        case CGXCategoryTitleImageType_OnlyTitle:
        {
            self.imageView.hidden = YES;
            self.titleLabel.center = self.contentView.center;
        }
            break;

        default:
            break;
    }
    //因为`- (void)reloadData:(CGXCategoryBaseCellModel *)cellModel`方法会回调多次，尤其是左右滚动的时候会调用无数次，如果每次都触发图片加载，会非常消耗性能。所以只会在图片发生了变化的时候，才进行图片加载。
    NSString *currentImageName = nil;
    NSURL *currentImageURL = nil;
    if (myCellModel.imageName != nil) {
        currentImageName = myCellModel.imageName;
    }else if (myCellModel.imageURL != nil) {
        currentImageURL = myCellModel.imageURL;
    }
    if (myCellModel.isSelected) {
        if (myCellModel.selectedImageName != nil) {
            currentImageName = myCellModel.selectedImageName;
        }else if (myCellModel.selectedImageURL != nil) {
            currentImageURL = myCellModel.selectedImageURL;
        }
    }
    if (currentImageName != nil && ![currentImageName isEqualToString:self.currentImageName]) {
        self.currentImageName = currentImageName;
        self.imageView.image = [UIImage imageNamed:currentImageName];
    }else if (currentImageURL != nil && ![currentImageURL.absoluteString isEqualToString:self.currentImageURL.absoluteString]) {
        self.currentImageURL = currentImageURL;
        if (myCellModel.loadImageCallback != nil) {
            myCellModel.loadImageCallback(self.imageView, currentImageURL);
        }
    }

    if (myCellModel.imageZoomEnabled) {
        if (myCellModel.isSelected) {
             self.imageView.transform = CGAffineTransformMakeScale(myCellModel.imageZoomScale, myCellModel.selectImageZoomScale);
        } else{
             self.imageView.transform = CGAffineTransformMakeScale(myCellModel.imageZoomScale, myCellModel.imageZoomScale);
        }

    }else {
        self.imageView.transform = CGAffineTransformIdentity;
    }

//    [self setNeedsLayout];
}


@end
