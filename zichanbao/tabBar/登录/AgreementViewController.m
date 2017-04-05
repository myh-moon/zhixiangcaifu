//
//  AgreementViewController.m
//  zichanbao
//
//  Created by zhixiang on 15/12/17.
//  Copyright © 2015年 zhixiang. All rights reserved.
//

#import "AgreementViewController.h"

@interface AgreementViewController ()

@property (nonatomic,strong) UIWebView *registerWebView;

@end

@implementation AgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"直向理财用户协议";
    self.navigationItem.leftBarButtonItem = self.leftItem;
    
    [self.view addSubview:self.registerWebView];
}

-(UIWebView *)registerWebView
{
    if (!_registerWebView) {
        _registerWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)];
        
        NSString *agreeString = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFregisterAgree];
        NSURL *registerUrl = [[NSURL alloc] initWithString:agreeString];
        NSURLRequest *registerRequest = [[NSURLRequest alloc] initWithURL:registerUrl];
        [_registerWebView loadRequest:registerRequest];
        
        
//        [_registerWebView loadHTMLString:ZXCFregisteragree baseURL:[NSURL URLWithString:ZXCF]];
        
    }
    return _registerWebView;
}

#pragma mark - request
-(void)requestDataOfAgreement
{

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
