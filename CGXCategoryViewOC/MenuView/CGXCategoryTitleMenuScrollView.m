//
//  CGXCategoryTitleMenuScrollView.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2021/2/22.
//

#import "CGXCategoryTitleMenuScrollView.h"

@implementation CGXCategoryTitleMenuScrollView

/**
 如果列表是VC，就返回VC.view
 如果列表是View，就返回View自己
 
 @return 返回列表视图
 */
- (UIView *)listView
{
    return self;
}
/**
 可选实现，列表将要显示的时候调用
 */
- (void)listWillAppearAtIndex:(NSInteger)index
{
    
}
/**
 可选实现，列表显示的时候调用
 */
- (void)listDidAppearAtIndex:(NSInteger)index
{
    
}
/**
 可选实现，列表将要消失的时候调用
 */
- (void)listWillDisappearAtIndex:(NSInteger)index
{
    
}
/**
 可选实现，列表消失的时候调用
 */
- (void)listDidDisappearAtIndex:(NSInteger)index
{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
