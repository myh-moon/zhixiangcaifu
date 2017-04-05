//
//  MyShareRulesViewController.m
//  zichanbao
//
//  Created by zhixiang on 15/11/11.
//  Copyright © 2015年 zhixiang. All rights reserved.
//

#import "MyShareRulesViewController.h"

@interface MyShareRulesViewController ()

@property (nonatomic,strong) UIWebView *rWebView;

@end

@implementation MyShareRulesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = self.leftItem;
    self.navigationItem.title = @"详细规则";
    
    [self.view addSubview:self.rWebView];
}

-(UIWebView *)rWebView
{
    if (!_rWebView) {
        _rWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)];
        [_rWebView loadHTMLString:self.info baseURL:nil];
    }
    return _rWebView;
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
