//
//  MyInvestViewController.m
//  zichanbao
//
//  Created by zhixiang on 15/10/14.
//  Copyright (c) 2015年 zhixiang. All rights reserved.
//

#import "MyInvestViewController.h"
#import "InvestCell.h"  //自定义单元格
//model
#import "MyInvestListModel.h"
#import "MyInvestModel.h"

#import "MyInvestDetailViewController.h"  //详细投资

@interface MyInvestViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,assign) BOOL didSetupConstraints;
@property (nonatomic,strong) UIView *headerViewd;
@property (nonatomic,strong) UITableView *investTableView;
@property (nonatomic,strong) UILabel *orangeLabel;
@property (nonatomic,strong) NSLayoutConstraint *leftOrangeLabelConstraints;

@property (nonatomic,assign) NSInteger tagOpen;  //分类标记

//json解析数组
@property (nonatomic,copy)NSMutableArray *allArray;

//请求的参数
@property (nonatomic,strong) NSString *statusString;

@end

@implementation MyInvestViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的投资";
    self.view.backgroundColor = kBackgroundColor;
    self.navigationItem.leftBarButtonItem = self.leftItem;
    
    _tagOpen = 0;
    self.statusString = @"";
    
    [self.view addSubview:self.headerViewd];
    [self.view addSubview:self.orangeLabel];
    [self.view addSubview:self.investTableView];
    [self.view addSubview:self.remindButton];
    [self.remindButton.noTextButton setTitle:@"亲，您暂时没有！" forState:0];
    [self.remindButton setHidden:YES];
    
    self.leftOrangeLabelConstraints = [self.orangeLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    
    [self.view setNeedsUpdateConstraints];
    
    [self requestAllInvestDatasWithPage:@"1"];
}

- (void)updateViewConstraints
{
    if (!self.didSetupConstraints) {
        
        [self.headerViewd autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
        [self.headerViewd autoSetDimension:ALDimensionHeight toSize:30];
        
        [self.orangeLabel autoSetDimension:ALDimensionHeight toSize:2];
        [self.orangeLabel autoSetDimension:ALDimensionWidth toSize:kScreenWidth/4];
        [self.orangeLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.headerViewd];
        
        [self.investTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
        [self.investTableView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.headerViewd];
        
        [self.remindButton autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [self.remindButton autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        self.didSetupConstraints = YES;
    }
    [super updateViewConstraints];
}

#pragma mark - init view
- (UIView *)headerViewd
{
    if (!_headerViewd) {
        _headerViewd = [UIView newAutoLayoutView];
        NSArray*nameArray=@[@"全部",@"投资中",@"还款中",@"已还清"];
        for (int i=0; i<nameArray.count; i++) {
            UIButton*btn=[UIButton buttonWithType:0];
            btn.tag=i;
            btn.frame=CGRectMake((kScreenWidth/4)*i,0,kScreenWidth/4,30);
            btn.backgroundColor = [UIColor whiteColor];
            btn.titleLabel.font=[UIFont systemFontOfSize:14];
            [btn setTitle:nameArray[i] forState:0];
            [btn setTitleColor:[UIColor blackColor] forState:0];
            [btn addTarget:self action:@selector(btnClick22:) forControlEvents:UIControlEventTouchUpInside];
            [_headerViewd addSubview:btn];
        }
    }
    return _headerViewd;
}

- (UILabel *)orangeLabel
{
    if (!_orangeLabel) {
        _orangeLabel = [UILabel newAutoLayoutView];
        _orangeLabel.backgroundColor=[UIColor orangeColor];
    }
    return _orangeLabel;
}

-(UITableView *)investTableView
{
    if (!_investTableView) {
        _investTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, kScreenWidth, kScreenHeight-20-Navigationheight-30) style:UITableViewStylePlain];
        _investTableView.dataSource = self;
        _investTableView.delegate = self;
        _investTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        [_investTableView addFooterWithTarget:self action:@selector(allFooterRefresh)];
        [_investTableView addHeaderWithTarget:self action:@selector(allHeaderRefresh)];
    }
    return _investTableView;
}

-(NSMutableArray *)allArray
{
    if (!_allArray) {
        _allArray = [NSMutableArray array];
    }
    return _allArray;
}

#pragma mark - tableView delegate and dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.allArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, 10)];
    footerLabel.backgroundColor = kBackgroundColor;
    return footerLabel;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"invest";
    InvestCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[InvestCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.nameLabel.frame = CGRectMake(cell.typeBtn1.right+5, cell.typeBtn1.top, 200, 20);

    MyInvestModel *investModel = self.allArray[indexPath.row];
    
    [cell.typeBtn1 setTitle:investModel.borrow_type forState:0];
    cell.nameLabel.text = investModel.borrow_name;
    [cell.typeBtn2 setTitle:investModel.type forState:0];
    cell.moneyLabel.text = [NSString stringWithFormat:@"投资金额：%@元",investModel.capital];
    cell.dateLabel.text = [NSString stringWithFormat:@"投资期限：%@",investModel.borrow_duration];
    cell.ProfitLabel.text = [NSString stringWithFormat:@"预期收益：%@元",investModel.interest];
    cell.wayLabel.text = [NSString stringWithFormat:@"还款方式：%@",investModel.repayment_type];
    cell.rateLabel1.text = @"年化率";
    cell.rateLabel2.text = [NSString stringWithFormat:@"%@",investModel.borrow_interest_rate];
    
    if ([investModel.type isEqualToString:@"投资中"]) {
        [cell.typeBtn2 setBackgroundColor:kNavigationColor];
    }else if ([investModel.type isEqualToString:@"还款中"]){
        [cell.typeBtn2 setBackgroundColor:[UIColor orangeColor]];
    }else if ([investModel.type isEqualToString:@"已还清"]){
        [cell.typeBtn2 setBackgroundColor:[UIColor grayColor]];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MyInvestModel *investModel = self.allArray[indexPath.row];
    
    MyInvestDetailViewController *investDetailVC = [[MyInvestDetailViewController alloc] init];
    investDetailVC.index=_tagOpen;
    investDetailVC.idString = investModel.ID;
    investDetailVC.borrowID = investModel.borrow_id;
    investDetailVC.statusType = investModel.type;
    investDetailVC.borrowType = investModel.borrow_type;
    [self.navigationController pushViewController:investDetailVC animated:YES];
}

#pragma mark - data request
//全部
-(void)requestAllInvestDatasWithPage:(NSString *)page
{
    NSString *allInvestString = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFmyInvest];
    NSDictionary *param = @{
                            @"token" : TOKEN,
                            @"p" : page,
                            @"status" : self.statusString
                            };
    
    ZXWeakSelf;
    [self requestDataGetWithUrlString:allInvestString paramter:param SucceccBlock:^(id responseObject){
        
        MyInvestListModel *listModel = [MyInvestListModel objectWithKeyValues:responseObject];
        
        for (MyInvestModel *myInvestModel in listModel.list) {
            [weakself.allArray addObject:myInvestModel];
        }
        
        if (listModel.list.count <= 0) {
            current_page--;
        }
        
        if (weakself.allArray.count <= 0) {
            [weakself.remindButton setHidden:NO];
        }else{
            [weakself.remindButton setHidden:YES];
        }
        
        [weakself.investTableView reloadData];
        
    } andFailedBlock:^{
    }];
}

//header refresh
-(void)allHeaderRefresh
{
    if (_tagOpen == 0) {//全部
        self.statusString = @"";
    }else if (_tagOpen == 1){//投资中
        self.statusString = @"1";
    }else if (_tagOpen == 2){//还款中
        self.statusString = @"2";
    }else if (_tagOpen == 3){//已结清
        self.statusString = @"3";
    }
    current_page = 1;
    [self.allArray removeAllObjects];
    [self requestAllInvestDatasWithPage:@"1"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.investTableView headerEndRefreshing];
    });
}
//footer refresh
//页面刚出来刷新第一页,再次上拉加载就会请求第二页数据,此处先设置为1
int current_page = 1;
-(void)allFooterRefresh
{
    current_page += 1;
    NSString *currentPAGE = [NSString stringWithFormat:@"%d",current_page];
    [self requestAllInvestDatasWithPage:currentPAGE];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.investTableView footerEndRefreshing];
    });
}

#pragma mark - target 全部，投资中，还款中，已还清
-(void)btnClick22:(UIButton *)button
{
    _tagOpen = button.tag;
    [self allHeaderRefresh];
    
    ZXWeakSelf;
    [UIView animateWithDuration:0.3 animations:^{
        weakself.leftOrangeLabelConstraints.constant = kScreenWidth/4*_tagOpen;
    }];
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
