//
//  DetailMessageViewController.m
//  zichanbao
//
//  Created by zhixiang on 15/11/24.
//  Copyright © 2015年 zhixiang. All rights reserved.
//

#import "DetailMessageViewController.h"

@interface DetailMessageViewController ()

@end

@implementation DetailMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"详细消息";
    self.view.backgroundColor = kBackgroundColor;
    self.navigationItem.leftBarButtonItem = self.leftItem;
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
