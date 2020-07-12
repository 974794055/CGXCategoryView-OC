//
//  CGXVerticalTableSectionHeaderView.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXVerticalTableSectionHeaderView.h"

@implementation CGXVerticalTableSectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];

        self.textLabel.textColor = [UIColor lightGrayColor];
        self.textLabel.font = [UIFont systemFontOfSize:15];
    }
    return self;
}

@end
