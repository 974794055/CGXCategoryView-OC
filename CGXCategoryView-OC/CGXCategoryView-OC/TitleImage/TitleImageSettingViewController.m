//
//  TitleImageSettingViewController.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "TitleImageSettingViewController.h"

@interface TitleImageSettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) UITableView *tableView;

@property (nonatomic , strong) NSMutableArray *titleArray;

@end

@implementation TitleImageSettingViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titleArray = [NSMutableArray array];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.93 alpha:1];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-kTopHeight-kTabBarHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    [self.view addSubview:self.tableView];
    
    self.titleArray = [NSMutableArray arrayWithObjects:@"顶部",@"左边",@"底部",@"右边",@"只有图片",@"只有文字",@"混合", nil];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.textLabel.text = self.titleArray[indexPath.row];
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGXCategoryTitleImageType imageType = [self converIndexToImageType:indexPath.row];
    if ([self.delegate respondsToSelector:@selector(titleImageSettingVCDidSelectedImageType:)]) {
        [self.delegate titleImageSettingVCDidSelectedImageType:imageType];
    }
    [self.navigationController popViewControllerAnimated:true];
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    NSUInteger selectedIndex = [self converImageTypeToIndex:self.imageType];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:selectedIndex inSection:0]];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
}

- (CGXCategoryTitleImageType)converIndexToImageType:(NSUInteger)index {
    NSArray <NSNumber *> *imageTypes = @[@(CGXCategoryTitleImageType_TopImage),
                            @(CGXCategoryTitleImageType_LeftImage),
                            @(CGXCategoryTitleImageType_BottomImage),
                            @(CGXCategoryTitleImageType_RightImage),
                                         @(CGXCategoryTitleImageType_OnlyImage),
                                         @(CGXCategoryTitleImageType_OnlyTitle),
                                         @(100)

                                         ];
    return [imageTypes[index] integerValue];
}

- (NSInteger)converImageTypeToIndex:(CGXCategoryTitleImageType)imageType {
    NSArray <NSNumber *> *imageTypes = @[@(CGXCategoryTitleImageType_TopImage),
                                         @(CGXCategoryTitleImageType_LeftImage),
                                         @(CGXCategoryTitleImageType_BottomImage),
                                         @(CGXCategoryTitleImageType_RightImage),
                                         @(CGXCategoryTitleImageType_OnlyImage),
                                         @(CGXCategoryTitleImageType_OnlyTitle),
                                         @(100),];
    return [imageTypes indexOfObject:@(imageType)];
}
@end
