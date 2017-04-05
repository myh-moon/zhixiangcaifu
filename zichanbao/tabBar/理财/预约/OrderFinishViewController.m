//
//  OrderFinishViewController.m
//  zichanbao
//
//  Created by zhixiang on 15/11/17.
//  Copyright © 2015年 zhixiang. All rights reserved.
//

#import "OrderFinishViewController.h"

@interface OrderFinishViewController ()
@property (nonatomic,strong) UIView *myOrderFinishWhiteView;

@end

@implementation OrderFinishViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBackgroundColor;
    self.navigationItem.title = @"预约成功";
    self.navigationItem.leftBarButtonItem = self.leftItem;
    
    [self.view addSubview:self.myOrderFinishWhiteView];
}

-(UIView *)myOrderFinishWhiteView
{
    if (!_myOrderFinishWhiteView) {
        _myOrderFinishWhiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 250)];
        _myOrderFinishWhiteView.backgroundColor = [UIColor whiteColor];
        
        //image
        UIImageView *successImage = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth-60)/2, 50, 60, 60)];
        [successImage setImage:[UIImage imageNamed:@"dui"]];
        [_myOrderFinishWhiteView addSubview:successImage];
        
        //预约成功
        UILabel *successLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, successImage.bottom+10, kScreenWidth, 20)];
        successLabel1.text = self.remindString;
        successLabel1.font = font16;
        successLabel1.textColor = [UIColor blackColor];
        successLabel1.textAlignment = NSTextAlignmentCenter;
        [_myOrderFinishWhiteView addSubview:successLabel1];
        
        //预计手机号
        UILabel *successLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, successLabel1.bottom, kScreenWidth, 60)];
        successLabel2.text = [NSString stringWithFormat:@"预约手机号为：%@\n\n我们的理财经理将尽快与您联系",self.phoneString];
        successLabel2.numberOfLines = 0;
        successLabel2.font = font16;
        successLabel2.textColor = [UIColor blackColor];
        successLabel2.textAlignment = NSTextAlignmentCenter;
        [_myOrderFinishWhiteView addSubview:successLabel2];
    }
    return _myOrderFinishWhiteView;
}

- (void)back
{
    UINavigationController *navs  = self.navigationController;
    [navs popViewControllerAnimated:NO];
    [navs popViewControllerAnimated:NO];
    [navs popViewControllerAnimated:NO];
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
