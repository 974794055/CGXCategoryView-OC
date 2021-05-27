//
//  CGXCategoryListContainerCell.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2021/5/20.
//

#import "CGXCategoryListContainerCell.h"
#import "CGXCategoryFactory.h"
@implementation CGXCategoryListContainerCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        [CGXCategoryFactory horizontalFlipViewIfNeeded:self];
        [CGXCategoryFactory horizontalFlipViewIfNeeded:self.contentView];
    }
    return self;
}
@end
