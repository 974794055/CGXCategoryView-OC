//
//  VerticalSectionHeaderView.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXVerticalSectionHeaderView.h"

@implementation CGXVerticalSectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];

        _titleLabel = [[UILabel alloc] init];
        self.titleLabel.textColor = [UIColor lightGrayColor];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    [self.titleLabel sizeToFit];
    self.titleLabel.frame = CGRectMake(16, (self.bounds.size.height - self.titleLabel.bounds.size.height)/2, 200, self.titleLabel.bounds.size.height);
}

@end
