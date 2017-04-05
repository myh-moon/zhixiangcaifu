//
//  MyOrderViewController.m
//  zichanbao
//
//  Created by zhixiang on 15/10/26.
//  Copyright (c) 2015年 zhixiang. All rights reserved.
//

#import "MyOrderViewController.h"
#import "InvestCell.h"
#import "MyDetailOrderViewController.h"  //预约详情

#import "MyOrderModel.h"

@interface MyOrderViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,assign) BOOL didSetupConstraints;
@property (nonatomic,strong) UITableView *myOrderTableView;

//json
@property (nonatomic,strong) NSMutableArray *myOrderArray;

@end

@implementation MyOrderViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的预约";
    self.navigationItem.leftBarButtonItem = self.leftItem;
    
    [self.view addSubview:self.myOrderTableView];
    [self.view addSubview:self.remindButton];
    [self.remindButton.noTextButton setTitle:@"亲，您暂时没有预约" forState:0];
    [self.remindButton setHidden:YES];
    
    [self.view setNeedsUpdateConstraints];
    
    [self requestDataOfMyOrderWithpage:@"1"];
}

- (void)updateViewConstraints
{
    if (!self.didSetupConstraints) {
        
        [self.myOrderTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
        
        [self.remindButton autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [self.remindButton autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        self.didSetupConstraints = YES;
    }
    [super updateViewConstraints];
}

#pragma mark - init myOrderTableView
-(UITableView *)myOrderTableView
{
    if (!_myOrderTableView) {
        _myOrderTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
        _myOrderTableView.delegate = self;
        _myOrderTableView.dataSource = self;
        _myOrderTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _myOrderTableView.showsVerticalScrollIndicator = NO;
        _myOrderTableView.tableFooterView = [[UIView alloc] init];
        _myOrderTableView.backgroundColor = kBackgroundColor;
        [_myOrderTableView addFooterWithTarget:self action:@selector(footerRefresh)];
    }
    return _myOrderTableView;
}

#pragma mark - init array
-(NSMutableArray *)myOrderArray
{
    if (!_myOrderArray) {
        _myOrderArray = [NSMutableArray array];
    }
    return _myOrderArray;
}

#pragma mark - tableView delegate and dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.myOrderArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"invest";
    InvestCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[InvestCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.typeBtn2 setHidden:YES];
    
    MyOrderModel *model = self.myOrderArray[indexPath.row];
    [cell.typeBtn1 setTitle:model.btype forState:0];
    cell.nameLabel.text = model.bname;
    cell.moneyLabel.text = [NSString stringWithFormat:@"预约金额：%@元",model.money];
    cell.dateLabel.text = [NSString stringWithFormat:@"项目金额：%@",model.borrow_money];
    cell.ProfitLabel.text = [NSString stringWithFormat:@"项目期限：%@",model.duration];
    cell.wayLabel.text = [NSString stringWithFormat:@"还款方式：%@",model.type];
    cell.rateLabel1.text = @"年化率";
    cell.rateLabel2.text = model.rate;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MyOrderModel *model = self.myOrderArray[indexPath.row];
    
    MyDetailOrderViewController *myDetailOrderVC = [[MyDetailOrderViewController alloc] init];
    myDetailOrderVC.borrowID = model.bid;
    [self.navigationController pushViewController:myDetailOrderVC animated:YES];
}

#pragma mark - request data
-(void)requestDataOfMyOrderWithpage:(NSString *)page
{
    NSString *myOrderString = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFmyOrder];
    NSDictionary *params = @{
                             @"token"  : TOKEN,
                             @"p"      : page
                             };
    ZXWeakSelf;
    [self requestDataGetWithUrlString:myOrderString paramter:params SucceccBlock:^(id responseObject){
        
        NSArray *array = [MyOrderModel objectArrayWithKeyValuesArray:responseObject];
        
        for (MyOrderModel *myOrderModel in array) {
            [weakself.myOrderArray addObject:myOrderModel];
        }
        
        if (array.count <= 0) {
            numPage--;
        }
        
        if (weakself.myOrderArray.count == 0) {
            [weakself.remindButton setHidden:NO];
        }else{
            [weakself.remindButton setHidden:YES];
        }
        
        [weakself.myOrderTableView reloadData];
        
    } andFailedBlock:^{
        
    }];
}
-(void)headerRefresh
{
    [self.myOrderArray removeAllObjects];
    numPage = 1;
    [self requestDataOfMyOrderWithpage:@"1"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.myOrderTableView headerEndRefreshing];
    });
}

int numPage = 1;
-(void)footerRefresh
{
    numPage += 1;
    NSString *page = [NSString stringWithFormat:@"%d",numPage];
    [self requestDataOfMyOrderWithpage:page];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.myOrderTableView footerEndRefreshing];
    });
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
