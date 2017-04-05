//
//  RechargeFinishViewController.m
//  zichanbao
//
//  Created by zhixiang on 15/10/16.
//  Copyright (c) 2015年 zhixiang. All rights reserved.
//

#import "RechargeFinishViewController.h"
#import "HomeCell.h"

@interface RechargeFinishViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *finishTableView;

@end

@implementation RechargeFinishViewController


-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = self.leftItem;
    self.navigationItem.title = @"充值完成";
    
    [self.view addSubview:self.finishTableView];
}

-(void)back
{
    UINavigationController *nav = self.navigationController;
    [nav popViewControllerAnimated:NO];
    [nav popViewControllerAnimated:NO];
}

#pragma mark - init tableView
-(UITableView *)finishTableView
{
    if (!_finishTableView) {
        _finishTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
        _finishTableView.delegate = self;
        _finishTableView.dataSource = self;
        _finishTableView.tableFooterView = [[UIView alloc] init];
        _finishTableView.showsVerticalScrollIndicator = NO;
        _finishTableView.scrollEnabled = NO;
    }
    return _finishTableView;
}

#pragma mark - tableView dataSource and delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"recharges";
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[HomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 160;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *finishView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 160)];
    finishView.backgroundColor = [UIColor whiteColor];
    
    //图片
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth-60)/2, 10, 60, 60)];
    imageView1.image = [UIImage imageNamed:@"elephant"];
    [finishView addSubview:imageView1];
    
   //充值成功
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, imageView1.bottom+15, kScreenWidth, 30)];
    label1.text = @"充 值 成 功";
    label1.textColor = [UIColor blackColor];
    label1.font = font14;
    label1.textAlignment = NSTextAlignmentCenter;
    [finishView addSubview:label1];
    
   //充值金额
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, label1.bottom, kScreenWidth, 20)];
    label2.text = [NSString stringWithFormat:@"金额：%@元",self.moneyString];
    label2.textColor = [UIColor blackColor];
    label2.font = [UIFont systemFontOfSize:12];
    label2.textAlignment = NSTextAlignmentCenter;
    [finishView addSubview:label2];
    
    //分割线
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, kScreenWidth, 10)];
    label3.backgroundColor = kBackgroundColor;
    [finishView addSubview:label3];
    
    return finishView;
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
