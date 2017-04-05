//
//  CLLockNavVC.m
//  CoreLock
//
//  Created by 成林 on 15/4/28.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "CLLockNavVC.h"
#import "UIImage+Color.h"

@interface CLLockNavVC ()

@end

@implementation CLLockNavVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:17]}];
    
    
//    self.navigationController.navigationBar.translucent = NO;
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:kNavigationColor] forBarMetrics:UIBarMetricsDefault];
    
    //以前代码
//    [self.navigationBar setBackgroundImage:[[UIImage imageNamed:@"nav_bg"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.clipsToBounds = YES;

    //tintColor
    self.navigationBar.tintColor = [UIColor whiteColor];

}


-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


@end
