//
//  WithdraFinishViewController.m
//  zichanbao
//
//  Created by zhixiang on 15/10/28.
//  Copyright (c) 2015年 zhixiang. All rights reserved.
//

#import "WithdraFinishViewController.h"
#import "WithdraViewController.h"

@interface WithdraFinishViewController ()

@property (nonatomic,strong) UIView *finishWhiteView;
@property (nonatomic,strong) UIView *secondWhiteView;
@property (nonatomic,strong) UILabel *moneyLabel;
@property (nonatomic,strong) UILabel *dateLabel;
@property (nonatomic,strong) UILabel *remindLabel;
@end

@implementation WithdraFinishViewController
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBackgroundColor;
    self.navigationItem.title = @"提现成功";
    self.navigationItem.leftBarButtonItem = self.leftItem;

    [self.view addSubview:self.finishWhiteView];
    [self.view addSubview:self.secondWhiteView];
    [self.view addSubview:self.remindLabel];
}

#pragma mark - 覆盖back
-(void)back
{
    UINavigationController *nav1 = self.navigationController;
    [nav1 popViewControllerAnimated:NO];
    [nav1 popViewControllerAnimated:NO];
}

#pragma mark - init view
-(UIView *)finishWhiteView
{
    if (_finishWhiteView == nil) {
        _finishWhiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 180)];
        _finishWhiteView.backgroundColor = [UIColor whiteColor];
        
        //image
        UIImageView *successImage = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth-60)/2, 50, 60, 60)];
        [successImage setImage:[UIImage imageNamed:@"dui"]];
        [_finishWhiteView addSubview:successImage];
        
        //投资成功
        UILabel *successLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, successImage.bottom+10, kScreenWidth, 20)];
        successLabel1.text = @"提 现 成 功";
        successLabel1.font = [UIFont systemFontOfSize:20];
        successLabel1.textColor = kNavigationColor;
        successLabel1.textAlignment = NSTextAlignmentCenter;
        [_finishWhiteView addSubview:successLabel1];
    }
    return _finishWhiteView;
}

-(UIView *)secondWhiteView
{
    if (_secondWhiteView == nil) {
        
        _secondWhiteView = [[UIView alloc] initWithFrame:CGRectMake(0, self.finishWhiteView.bottom+10, kScreenWidth, 100)];
        _secondWhiteView.backgroundColor = [UIColor whiteColor];
        
        NSArray *aa = [NSArray arrayWithObjects:@"提现金额",@"到帐日期", nil];
        for (int k=0; k<2; k++) {
            UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 10*(2*k+1)+30*k, 100, 30)];
            label1.textAlignment = NSTextAlignmentCenter;
            label1.text = aa[k];
            label1.textColor = [UIColor lightGrayColor];
            [_secondWhiteView addSubview:label1];
            
            if (k == 0) {
                [_secondWhiteView addSubview:self.moneyLabel];
            }else{
                [_secondWhiteView addSubview:self.dateLabel];
            }
        }
        
        //分割线
        UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(0, _secondWhiteView.height/2, kScreenWidth, 1)];
        l.backgroundColor = lineColor11;
        [_secondWhiteView addSubview:l];
    }
    return _secondWhiteView;
}

-(UILabel *)moneyLabel
{
    if (_moneyLabel == nil) {
        _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-20-180,10, 180, 30)];
        _moneyLabel.textColor = [UIColor blackColor];
        _moneyLabel.text = [NSString stringWithFormat:@"%@元",_moneyString];
        _moneyLabel.textAlignment = NSTextAlignmentRight;
    }
    return _moneyLabel;
}

-(UILabel *)dateLabel
{
    if (_dateLabel == nil) {
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.moneyLabel.left,10+50, self.moneyLabel.width, self.moneyLabel.height)];
        _dateLabel.textColor = [UIColor blackColor];
        _dateLabel.text = @"T+2个工作日内到账";
        _dateLabel.textAlignment = NSTextAlignmentRight;
    }
    return _dateLabel;
}

-(UILabel *)remindLabel
{
    if (_remindLabel == nil) {
        _remindLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.secondWhiteView.bottom+10, kScreenWidth, 20)];
        _remindLabel.text = @"实际到帐时间依据账户托管方及提现银行而有所差异";
        _remindLabel.textColor = [UIColor lightGrayColor];
        _remindLabel.font = [UIFont systemFontOfSize:12];
        _remindLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _remindLabel;
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
