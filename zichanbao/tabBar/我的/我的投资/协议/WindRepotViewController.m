//
//  WindRepotViewController.m
//  zichanbao
//
//  Created by zhixiang on 16/11/8.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import "WindRepotViewController.h"

@interface WindRepotViewController ()
@property (nonatomic,strong) UIWebView *webView;
@property (nonatomic,strong) NSString *windStr;

@end

@implementation WindRepotViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = self.leftItem;
    self.navigationItem.title = self.windTitle;
    
    [self getWindReport];
}

-(UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.windStr]];
        [_webView loadRequest:request];
    }
    return _webView;
}

- (void)getWindReport
{
    NSString *windString = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFMyInvestDetailsOfWindReport];
    NSDictionary *params = @{@"token" : TOKEN,
                             @"id" : self.borrowID
                             };
    
    ZXWeakSelf;
    [self requestDataGetWithUrlString:windString paramter:params SucceccBlock:^(id responseObject){
        
        NSDictionary *sosoos = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        weakself.windStr = sosoos[@"url"];
        [weakself.view addSubview:weakself.webView];
        
    } andFailedBlock:^{
        
    }];
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
