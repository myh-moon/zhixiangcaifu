//
//  MessageViewController.m
//  zichanbao
//
//  Created by zhixiang on 15/10/27.
//  Copyright (c) 2015年 zhixiang. All rights reserved.
//

#import "MessageViewController.h"
#import "FundCell.h"
#import "DetailMessageViewController.h"  //详细消息

@interface MessageViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *messageTableView;

@end

@implementation MessageViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"消息管理";
    self.navigationItem.leftBarButtonItem = self.leftItem;
    [self.view addSubview:self.messageTableView];
}

#pragma mark - init tableView
-(UITableView *)messageTableView
{
    if (_messageTableView == nil) {
        _messageTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        _messageTableView.dataSource = self;
        _messageTableView.delegate = self;
    }
    return _messageTableView;
}

#pragma mark - tableView delegate and dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FundCell *cell = [FundCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.text = @"充值";
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    cell.detailTextLabel.text = @"使用红包专职投资100元";
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *messageHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    
    NSArray *a = [NSArray arrayWithObjects:@"2015年10月",@"2015年11月",@"2015年12月", nil];
    
    UILabel *dateLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 30)];
    [messageHeaderView addSubview:dateLabel1];
    dateLabel1.text = a[section];
    dateLabel1.textColor = [UIColor grayColor];
    dateLabel1.font = font14;
    
    UILabel *dateLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-110, 0, 100, 30)];
    [messageHeaderView addSubview:dateLabel2];
    dateLabel2.textColor = [UIColor grayColor];
    dateLabel2.text= @"金额（元）";
    dateLabel2.textAlignment = NSTextAlignmentRight;
    dateLabel2.font = font14;
    
    return messageHeaderView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailMessageViewController *detailMessageVC = [[DetailMessageViewController alloc] init];
    [self.navigationController pushViewController:detailMessageVC animated:YES];
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
