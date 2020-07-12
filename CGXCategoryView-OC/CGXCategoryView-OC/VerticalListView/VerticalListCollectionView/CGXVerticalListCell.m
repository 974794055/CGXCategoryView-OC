//
//  CGXVerticalListCell.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXVerticalListCell.h"

@implementation CGXVerticalListCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.contentView.layer.cornerRadius = 10;

        _titleLabel = [[UILabel alloc] init];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.titleLabel];

        _itemImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.itemImageView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.itemImageView.bounds = CGRectMake(0, 0, 50, 50);
    self.itemImageView.center = CGPointMake(self.bounds.size.width/2, 30);

    self.titleLabel.frame = CGRectMake(0, CGRectGetMaxY(self.itemImageView.frame) + 5, self.bounds.size.width, 30);
}

@end
