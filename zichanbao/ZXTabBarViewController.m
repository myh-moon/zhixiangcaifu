//
//  ZXTabBarViewController.m
//  zichanbao
//
//  Created by zhixiang on 15/10/20.
//  Copyright (c) 2015年 zhixiang. All rights reserved.
//

#import "ZXTabBarViewController.h"

@interface ZXTabBarViewController ()

@end

@implementation ZXTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
}

-(UINavigationController *)viewControllerWithTab:(UIViewController *)viewController title:(NSString *)title imageName:(NSString *)imageName selectedImage:(NSString *)selectedImageName
{
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
    nav.tabBarItem = [self createTabBarItemWithTitle:title imageName:imageName selectedImageName:selectedImageName];
    return nav;
}

-(UITabBarItem *)createTabBarItemWithTitle:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    UITabBarItem *tabbarItem = nil;
    UIImage *image = [UIImage imageNamed:imageName];
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    tabbarItem = [[UITabBarItem alloc] initWithTitle:title image:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    return tabbarItem;
}

#pragma mark - delegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if (self.didSelectedTabBar) {
        self.didSelectedTabBar(tabBarController.selectedIndex);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
