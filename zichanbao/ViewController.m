//
//  ViewController.m
//  zichanbao
//
//  Created by zhixiang on 15/10/8.
//  Copyright (c) 2015年 zhixiang. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Color.h"
#import "BaseViewController.h"
#import "AccountModel.h"
#import "LoginViewController.h"


#import "MineViewController.h"
#import "FinancialViewController.h"
#import "BorrowViewController.h"
#import "MainViewController.h"

@interface ViewController ()

@property (nonatomic,assign) NSUInteger beforeIndex;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MainViewController *mainVC = [MainViewController new];
    FinancialViewController *financialVC = [FinancialViewController new];
    BorrowViewController *borrowVC = [BorrowViewController new];
    MineViewController *mineVC = [MineViewController new];
    
    self.viewControllers = @[[self viewControllerWithTab:mainVC
                              title:@"首页"imageName:@"homegray" selectedImage:@"homepup"],
                             [self viewControllerWithTab:financialVC title:@"理财" imageName:@"liciag" selectedImage:@"licaipi"],
                             [self viewControllerWithTab:borrowVC title:@"借款" imageName:@"jiekuangr" selectedImage:@"jiekuanp"],
                             [self viewControllerWithTab:mineVC title:@"我的" imageName:@"mygr" selectedImage:@"myp"]
                             ];
    
    self.selectedIndex = 0;
    
    ZXWeakSelf;
    [self setDidSelectedTabBar:^(NSUInteger selectedTabBar) {
        if (selectedTabBar == 2 || selectedTabBar == 3) {
            NSString *accountString = [NSString stringWithFormat:@"%@%@?token=%@",ZXCF,ZXCFmyAccount,TOKEN];
            NSURL *accountUrl = [NSURL URLWithString:accountString];
            NSURLRequest *accountRequest = [[NSURLRequest alloc] initWithURL:accountUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
            NSData *receicvedData = [NSURLConnection sendSynchronousRequest:accountRequest returningResponse:nil error:nil];
            
            AccountModel *model = [AccountModel objectWithKeyValues:receicvedData];
            
            if (TOKEN == nil ||model.status||[TOKEN isKindOfClass:[NSNull class]]) {//未登录
                LoginViewController *loginVC = [[LoginViewController alloc] init];
                loginVC.hidesBottomBarWhenPushed = YES;
                loginVC.backString = @"1";
                UINavigationController *nasd = [[UINavigationController alloc] initWithRootViewController:loginVC];
                [weakself presentViewController:nasd animated:YES completion:nil];
                weakself.selectedIndex = 0;
            }
        }
    }];
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
