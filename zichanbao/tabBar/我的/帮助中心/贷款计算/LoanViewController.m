//
//  LoanViewController.m
//  zichanbao
//
//  Created by zhixiang on 15/11/10.
//  Copyright © 2015年 zhixiang. All rights reserved.
//

#import "LoanViewController.h"

@interface LoanViewController ()

@end

@implementation LoanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = self.leftItem;
    self.navigationItem.title = @"贷款计算";
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
