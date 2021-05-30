//
//  CGXCustomListViewCell.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2021/5/30.
//  Copyright © 2021 CGX. All rights reserved.
//

#import "CGXCustomListViewCell.h"

@implementation CGXCustomListViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:self.contentView.frame];
        [self.contentView addSubview:titleLabel];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.numberOfLines = 0;
        titleLabel.textColor = [UIColor blackColor];
        self.titleLabel = titleLabel;
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.frame = self.contentView.bounds;
    
}
@end
