//
//  CGXVerticalListSectionModel.h
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CGXVerticalListCellModel.h"

@interface CGXVerticalListSectionModel : NSObject

@property (nonatomic, copy) NSString *sectionTitle;

@property (nonatomic, strong) NSArray <CGXVerticalListCellModel *> *cellModels;

@end
