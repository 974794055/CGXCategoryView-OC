//
//  CustomScrollerView.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2021/5/20.
//  Copyright © 2021 CGX. All rights reserved.
//

#import "CustomScrollerView.h"

@implementation CustomScrollerView

- (instancetype)init
{
    self = [super init];
    if (self) {
        if (@available(iOS 9.0, *)) {
            if ([UIView userInterfaceLayoutDirectionForSemanticContentAttribute:UIView.appearance.semanticContentAttribute] == UIUserInterfaceLayoutDirectionRightToLeft) {
                self.transform = CGAffineTransformMakeScale(-1, 1);
            }
        }
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (@available(iOS 9.0, *)) {
            if ([UIView userInterfaceLayoutDirectionForSemanticContentAttribute:UIView.appearance.semanticContentAttribute] == UIUserInterfaceLayoutDirectionRightToLeft) {
                self.transform = CGAffineTransformMakeScale(-1, 1);
            }
        }
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        if (@available(iOS 9.0, *)) {
            if ([UIView userInterfaceLayoutDirectionForSemanticContentAttribute:UIView.appearance.semanticContentAttribute] == UIUserInterfaceLayoutDirectionRightToLeft) {
                self.transform = CGAffineTransformMakeScale(-1, 1);
            }
        }
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
