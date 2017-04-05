//
//  CompleteViewController.m
//  zichanbao
//
//  Created by zhixiang on 15/10/16.
//  Copyright (c) 2015年 zhixiang. All rights reserved.
//

#import "CompleteViewController.h"

@interface CompleteViewController ()
@property (nonatomic,strong) UIImageView *completeImageView;
@property (nonatomic,strong) UILabel *completeLabel;
@property (nonatomic,strong) UIView *completeWhiteView;
@property (nonatomic,strong) UIView *completeWhiteLabel;
@end

@implementation CompleteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.title = @"认证完成";
    self.navigationItem.leftBarButtonItem = self.leftItem;
    self.view.backgroundColor  =kBackgroundColor;
    
    [self.view addSubview:self.completeImageView];
    [self.view addSubview:self.completeLabel];
    [self.view addSubview:self.completeWhiteView];
    [self.view addSubview:self.completeWhiteLabel];

}

#pragma mark - init view
-(UIImageView *)completeImageView
{
    if (!_completeImageView) {
        _completeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/3, 10, kScreenWidth/3, kScreenWidth/3)];
        _completeImageView.image = [UIImage imageNamed:@"renzheng_ok"];
    }
    return _completeImageView;
}

-(UILabel *)completeLabel
{
    if (!_completeLabel) {
        _completeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.completeImageView.bottom+10, kScreenWidth, 20)];
        _completeLabel.text = @"已完成身份验证";
        _completeLabel.font = font14;
        _completeLabel.textAlignment = NSTextAlignmentCenter;
        _completeLabel.textColor = [UIColor grayColor];
        _completeLabel.backgroundColor = [UIColor clearColor];
    }
    return _completeLabel;
}

-(UIView *)completeWhiteView
{
    if (!_completeWhiteView) {
        _completeWhiteView = [[UIView alloc] initWithFrame:CGRectMake(40, self.completeLabel.bottom+30, kScreenWidth-40*2, 40*2)];
        _completeWhiteView.backgroundColor = [UIColor whiteColor];
        
        //label
        NSArray *leftArray = @[@"真实姓名",@"身份证号"];

        for (int i = 0; i < leftArray.count; i++) {
            //真实姓名
            UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10+40*i, 70, 20)];
            leftLabel.text = leftArray[i];
            leftLabel.font = font14;
            leftLabel.textColor = [UIColor grayColor];
            [_completeWhiteView addSubview:leftLabel];
            
            //具体真实姓名
            UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftLabel.right, leftLabel.top, _completeWhiteView.width-20-leftLabel.width, leftLabel.height)];
            rightLabel.textColor = [UIColor grayColor];
            rightLabel.font = font14;
            [_completeWhiteView addSubview:rightLabel];
            rightLabel.tag = 100+i;
            
            UILabel *label1 = [_completeWhiteView viewWithTag:100];
            UILabel *label2 = [_completeWhiteView viewWithTag:101];
            label1.text = self.completeModel.real_name;
            label2.text = self.completeModel.card;
            
            //分割线
            UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40*(i+1), _completeWhiteView.width, 1)];
            lineLabel.backgroundColor = kBackgroundColor;
            [_completeWhiteView addSubview:lineLabel];
        }
    }
    return _completeWhiteView;
}

-(UIView *)completeWhiteLabel
{
    if (!_completeWhiteLabel) {
        _completeWhiteLabel = [[UIView alloc] initWithFrame:CGRectMake(self.completeWhiteView.left, self.completeWhiteView.bottom+30,self.completeWhiteView.width, self.completeWhiteView.height/2)];
        _completeWhiteLabel.backgroundColor = [UIColor whiteColor];
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 70, 20)];
        label1.text = @"证件审核";
        label1.font = font14;
        label1.textColor = [UIColor grayColor];
        [_completeWhiteLabel addSubview:label1];
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(label1.right, label1.top, _completeWhiteLabel.width-20-label1.width, label1.height)];
        label2.text = @"已审核";
        label2.textColor = [UIColor lightGrayColor];
        label2.font = font14;
        [_completeWhiteLabel addSubview:label2];
        
     }
    return _completeWhiteLabel;
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
