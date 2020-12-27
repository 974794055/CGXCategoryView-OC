//
//  CGXCategoryTitleAttributeView.h
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategoryIndicatorView.h"


@interface CGXCategoryTitleAttributeView : CGXCategoryIndicatorView

@property (nonatomic, strong,readonly) NSMutableArray <NSAttributedString *> *attributeTitles;

@property (nonatomic, strong,readonly) NSMutableArray <NSAttributedString *> *attributeSelectTitles;


/**
 更新富文本
 normalAttary：默认状态
 selectAttary：选中状态
 */
- (void)updateWithAttribute:(NSMutableArray <NSAttributedString *> *)normalAttary SelectAttribute:(NSMutableArray <NSAttributedString *> *)selectAttary;


/**
 更新某个富文本
 */
- (void)updateWithAttributeString:(NSAttributedString *)normalAtttibutrd SelectAttributeString:(NSAttributedString *)selectAtttibutrd AtInter:(NSInteger)inter;

@end
