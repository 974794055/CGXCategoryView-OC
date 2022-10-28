//
//  CGXCategoryTitleBadgeModel.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategoryTitleBadgeModel.h"

@implementation CGXCategoryTitleBadgeModel


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.numberLabelFont = [UIFont systemFontOfSize:11];
         self.numberBackgroundColor = [UIColor redColor];
        self.numberTitleColor = [UIColor whiteColor];
        self.numberLabelWidthIncrement = 10;
        self.numberLabelHeight = 14;
        self.numberMax = 99;
        self.isFormatter = YES;
        self.numberLabelWidth = 14;
        self.badgeAdaptive = YES;
         self.numberLabelOffset = CGPointMake(0, 0);
        self.roundedType = CGXCategoryRoundedTypeAll;
        self.borderColor = [UIColor redColor];
        self.borderWidth = 0;
    }
    return self;
}
@end
