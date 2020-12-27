//
//  CGXCategoryTitleCellModel.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategoryTitleCellModel.h"

@implementation CGXCategoryTitleCellModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"";
    }
    return self;
}
- (void)setTitle:(NSString *)title {
    _title = title;

    [self updateNumberSizeWidthIfNeeded];
}

- (void)setTitleFont:(UIFont *)titleFont {
    _titleFont = titleFont;

    [self updateNumberSizeWidthIfNeeded];
}
- (void)updateNumberSizeWidthIfNeeded {
    if (self.titleFont) {
        _titleHeight = [self.title boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.titleFont} context:nil].size.height;
    }
}
@end
