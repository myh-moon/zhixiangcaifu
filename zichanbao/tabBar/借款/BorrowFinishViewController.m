//
//  BorrowFinishViewController.m
//  zichanbao
//
//  Created by zhixiang on 15/10/15.
//  Copyright (c) 2015年 zhixiang. All rights reserved.
//

#import "BorrowFinishViewController.h"
#import "MarqueeView.h"

@interface BorrowFinishViewController ()

@property (nonatomic,strong) UIImageView *imageView1;
@property (nonatomic,strong) UILabel *label1;
@property (nonatomic,strong) UILabel *label2;

@end

@implementation BorrowFinishViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = self.leftItem;
    self.view.backgroundColor = kBackgroundColor;
    self.navigationItem.title = @"借款";
    
    [self.view addSubview:self.imageView1];
    [self.view addSubview:self.label1];
    [self.view addSubview:self.label2];
}

-(UIImageView *)imageView1
{
    if (!_imageView1 ) {
        
        _imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth-50)/2, 50, 50, 50)];
        _imageView1.image = [UIImage imageNamed:@"elephant"];
    }
    return _imageView1;
}

-(UILabel *)label1
{
    if (!_label1) {
        _label1 = [[UILabel alloc] initWithFrame:CGRectMake(50, self.imageView1.bottom+30, (kScreenWidth-50*2), 30)];
        _label1.text = @"申 请 成 功";
        _label1.textColor = kNavigationColor;
        _label1.font = [UIFont systemFontOfSize:26];
        _label1.textAlignment = NSTextAlignmentCenter;
    }
    return _label1;
}

-(UILabel *)label2
{
    if (!_label2) {
        _label2 = [[UILabel alloc] initWithFrame:CGRectMake(20, self.label1.bottom+5, (kScreenWidth-20*2), 20)];
        _label2.textColor = [UIColor grayColor];
        _label2.text = @"我 们 的 工 作 人 员 会 尽 快 与 您 取 得 联 系";
        _label2.font = [UIFont systemFontOfSize:12];
        _label2.textAlignment = NSTextAlignmentCenter;
    }
    return _label2;
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
