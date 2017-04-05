//
//  NewsProViewController.m
//  zichanbao
//
//  Created by zhixiang on 15/12/7.
//  Copyright © 2015年 zhixiang. All rights reserved.
//

#import "NewsProViewController.h"

@interface NewsProViewController ()

@property (nonatomic,assign) BOOL didSetupConstraints;
@property (nonatomic,strong) UIWebView *newsWebView;

@end

@implementation NewsProViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = self.leftItem;
    self.navigationItem.title = self.titleString;
    
    [self.view addSubview:self.newsWebView];
    
    [self.view setNeedsUpdateConstraints];
}

- (void)updateViewConstraints
{
    if (!self.didSetupConstraints) {
        
        [self.newsWebView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
        
        self.didSetupConstraints = YES;
    }
    [super updateViewConstraints];
}

-(UIWebView *)newsWebView
{
    if (!_newsWebView) {
        _newsWebView = [UIWebView newAutoLayoutView];
        _newsWebView.scalesPageToFit = YES;
        _newsWebView.mediaPlaybackAllowsAirPlay = YES;
        NSURL *url = [[NSURL alloc]initWithString:self.newsString];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        [_newsWebView loadRequest:request];
    }
    return _newsWebView;
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
