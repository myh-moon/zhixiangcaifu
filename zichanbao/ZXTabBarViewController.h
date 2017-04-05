//
//  ZXTabBarViewController.h
//  zichanbao
//
//  Created by zhixiang on 15/10/20.
//  Copyright (c) 2015年 zhixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXTabBarViewController : UITabBarController<UITabBarControllerDelegate>

@property (nonatomic,strong) void (^didSelectedTabBar)(NSUInteger);

-(UINavigationController *)viewControllerWithTab:(UIViewController *)viewController title:(NSString *)title imageName:(NSString *)imageName selectedImage:(NSString *)selectedImageName;

@end
