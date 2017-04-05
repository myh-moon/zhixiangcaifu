//
//  BaseViewController.m
//  zcb
//
//  Created by zhixiang on 15/10/8.
//  Copyright (c) 2015年 zhixiang. All rights reserved.
//

#import "BaseViewController.h"
#import "UIImage+Color.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航条的字体和文字颜色
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:17],NSFontAttributeName, nil]];
    
    // 去除系统效果
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:kNavigationColor] forBarMetrics:UIBarMetricsDefault];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.extendedLayoutIncludesOpaqueBars = NO;
}

#pragma mark - leftItem
- (UIBarButtonItem *)leftItem
{
    if (!_leftItem) {
        //返回按钮
        UIButton *backButton = [UIButton buttonWithType:0];
        backButton.frame=CGRectMake(0, 0, 50, 25);
        //    [releaseButton setImage:[UIImage imageNamed:@"qixian"] forState:0];
        [backButton setTitle:@"< 返回" forState:0];
        [backButton setTitleColor:UIColorFromRGB(0xe0e0e0, 1) forState:0];
        backButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        _leftItem = backButtonItem;
    }
    return _leftItem;
}

#pragma mark - rightItem
- (UIButton *)rightButton
{
    if (!_rightButton) {
        _rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
        [_rightButton setTitleColor:UIColorFromRGB(0xe0e0e0, 1) forState:0];
        _rightButton.titleLabel.font = font16;
        [_rightButton setContentHorizontalAlignment:2];
        [_rightButton addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

- (void)rightAction
{
}

#pragma mark - back
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - my account
-(AccountModel *)checkMyAccount
{
    NSString *accountString = [NSString stringWithFormat:@"%@%@?token=%@",ZXCF,ZXCFmyAccount,TOKEN];
    NSURL *accountUrl = [NSURL URLWithString:accountString];
    NSURLRequest *accountRequest = [[NSURLRequest alloc] initWithURL:accountUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSData *receicvedData = [NSURLConnection sendSynchronousRequest:accountRequest returningResponse:nil error:nil];
    
    AccountModel *model = [AccountModel objectWithKeyValues:receicvedData];
    return model;
}

- (RemindNoButton *)remindButton
{
    if (!_remindButton) {
        _remindButton = [RemindNoButton newAutoLayoutView];
        [_remindButton setTitleColor:kNavigationColor forState:0];
    }
    return _remindButton;
}
- (void)showRemindButton
{
    if ( [self.view.subviews containsObject:self.remindButton]) {
        [self.remindButton setHidden:NO];
    }else{
        [self.view addSubview:self.remindButton];
    }
    [self.view bringSubviewToFront:self.remindButton];
}

- (void)hiddenRemindButton
{
    [self.remindButton setHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
