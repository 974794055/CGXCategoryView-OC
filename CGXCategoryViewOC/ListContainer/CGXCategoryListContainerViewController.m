//
//  CGXCategoryListContainerViewController.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2021/5/30.
//

#import "CGXCategoryListContainerViewController.h"

@interface CGXCategoryListContainerViewController ()

@end

@implementation CGXCategoryListContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)dealloc
{
    self.viewWillAppearBlock = nil;
    self.viewDidAppearBlock = nil;
    self.viewWillDisappearBlock = nil;
    self.viewDidDisappearBlock = nil;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.viewWillAppearBlock();
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.viewDidAppearBlock();
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.viewWillDisappearBlock();
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.viewDidDisappearBlock();
}
- (BOOL)shouldAutomaticallyForwardAppearanceMethods {
    return NO;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
