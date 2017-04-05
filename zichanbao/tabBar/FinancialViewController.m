//
//  FinancialViewController.m
//  zichanbao
//
//  Created by zhixiang on 15/10/9.
//  Copyright (c) 2015年 zhixiang. All rights reserved.
//

#import "FinancialViewController.h"
#import "LoginViewController.h"
#import "ExhibiteViewController.h"

#import "ResponseModel.h"
#import "NormalModel.h"
#import "InvestModel.h"
#import "UIImageView+WebCache.h"

#import "FinanceHeaderView.h"  //产品类型／期限／收益
#import "HomeCell.h"  //自定义单元格
#import "InvestDetailsViewController.h"  //投资详细
#import "InvestViewController.h"         //投资

#import "OrderFinishViewController.h"  //预约
#import "OrderViewController.h"        //预约详细

#import "InvestDetailCommitOrderModel.h"  //json解析
#import "InvestDetailCommitModel.h"     //json解析

@interface FinancialViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,assign) BOOL didSetupConstraints;
@property (nonatomic,strong) NSLayoutConstraint *topDownViewConstraints;
@property (nonatomic,strong) FinanceHeaderView *financeHeaderView;

@property (nonatomic,strong) UIView *collectionView;

@property (nonatomic,strong) UIButton *downButton;
@property (nonatomic,strong) UITableView *searchTableView;

@property (nonatomic,strong) UIButton *selectedBtn1; //产品类型选中按钮
@property (nonatomic,strong) UIButton *selectedBtn2; //期限选中按钮
@property (nonatomic,strong) UIButton *selectedBtn3; //收益选中按钮

//params
@property (nonatomic,strong) NSMutableDictionary *financeDataDic;
//下拉选择框
@property (nonatomic,strong) NSArray *collectionArray;
//json解析
@property (nonatomic,strong) NSMutableArray *financialArray;

@end

@implementation FinancialViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNotofication:) name:@"直e贷" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNotofication:) name:@"房抵贷" object:nil];
    
    [self financialHeaderRefresh];
}

- (void)getNotofication:(NSNotification *)notification
{
    self.downButton.selected = YES;
    self.topDownViewConstraints.constant = 120;
    
    if ([notification.name isEqualToString:@"直e贷"]) {
        [self.financeDataDic setObject:@"4" forKey:@"borrow_type"];
        
        UIButton *btn = (UIButton *)[self.view viewWithTag:6];
        _selectedBtn1.selected = NO;
        btn.selected = YES;
        _selectedBtn1 = btn;
    }else if ([notification.name isEqualToString:@"房抵贷"]){
        [self.financeDataDic setObject:@"1" forKey:@"borrow_type"];
        
        UIButton *btn = (UIButton *)[self.view viewWithTag:3];
        _selectedBtn1.selected = NO;
        btn.selected = YES;
        _selectedBtn1 = btn;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kBackgroundColor;
    self.navigationItem.title = @"理财";
    
    [self.view addSubview:self.financeHeaderView];//类型
    [self.view addSubview:self.collectionView]; //九宫格
    [self.view addSubview:self.downButton];       //下拉框
    [self.view addSubview:self.searchTableView];  //tableView
    
    self.topDownViewConstraints = [self.downButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.financeHeaderView withOffset:0];
    
    [self.view setNeedsUpdateConstraints];
}

- (void)updateViewConstraints
{
    if (!self.didSetupConstraints) {
        
        [self.financeHeaderView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
        [self.financeHeaderView autoSetDimension:ALDimensionHeight toSize:30];
        
        [self.collectionView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [self.collectionView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [self.collectionView autoSetDimension:ALDimensionHeight toSize:120];
        [self.collectionView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.financeHeaderView];
        
        [self.downButton autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [self.downButton autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [self.downButton autoSetDimension:ALDimensionHeight toSize:30];
        
        [self.searchTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
        [self.searchTableView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.downButton];
        
        self.didSetupConstraints = YES;
    }
    [super updateViewConstraints];
}

#pragma mark - init view
-(FinanceHeaderView *)financeHeaderView
{
    if (!_financeHeaderView) {
        _financeHeaderView = [FinanceHeaderView newAutoLayoutView];
        _financeHeaderView.backgroundColor = kNavigationColor;
    }
    return _financeHeaderView;
}
-(UIView *)collectionView
{
    if (!_collectionView) {
        _collectionView = [UIView newAutoLayoutView];
        _collectionView.backgroundColor = kNavigationColor;
        
        //添加9个选项
        for (int k=0; k<self.collectionArray.count; k++) {
            UIButton *collectionButton = [UIButton buttonWithType:0];

            collectionButton.frame = CGRectMake(kScreenWidth/3*(k%3)+(kScreenWidth/3-80)/2,30*(k/3), 80,30);
            [collectionButton setTitle:self.collectionArray[k] forState:0];
            [collectionButton setTitleColor:[UIColor whiteColor] forState:0];
            collectionButton.titleLabel.font = [UIFont systemFontOfSize:14];
            [collectionButton setBackgroundImage:[UIImage imageNamed:@"pu"] forState:UIControlStateSelected];
            [_collectionView addSubview:collectionButton];
            
            collectionButton.tag = k+3;
            
            ZXWeakSelf;
            [collectionButton addAction:^(UIButton *btn) {
                
                NSInteger number = btn.tag%3;

                if (number == 0) {//产品类型
                    
                    //1.取消以前选择的
                    _selectedBtn1.selected = NO;
                    
                    //2.选择当前选择的
                    btn.selected = YES;
                    
                    //3.标记当前选择的
                    _selectedBtn1 = btn;
                    
                    if ([_selectedBtn1.titleLabel.text isEqualToString:@"房抵贷"]){
                        [weakself.financeDataDic setValue:@"1" forKey:@"borrow_type"];
                    }else if ([_selectedBtn1.titleLabel.text isEqualToString:@"直e贷"]){
                        [weakself.financeDataDic setValue:@"4" forKey:@"borrow_type"];
                    }else if ([_selectedBtn1.titleLabel.text isEqualToString:@"直享贷"]){
                        [weakself.financeDataDic setValue:@"2" forKey:@"borrow_type"];
                    }
                    
                }else if (number == 1){//期限
                    
                    //1.取消以前选择的
                    _selectedBtn2.selected = NO;
                    
                    //2.选择当前选择的
                    btn.selected = YES;
                    
                    //3.标记当前选择的
                    _selectedBtn2 = btn;
                    
                    if (_selectedBtn2.tag == 4) {
                        [weakself.financeDataDic setValue:@"1" forKey:@"borrow_duration"];
                    }else if (_selectedBtn2.tag == 7){
                        [weakself.financeDataDic setValue:@"2" forKey:@"borrow_duration"];
                    }else if (_selectedBtn2.tag == 10){
                        [weakself.financeDataDic setValue:@"3" forKey:@"borrow_duration"];
                    }

                }else{//收益
                    
                    //1.取消以前选择的
                    _selectedBtn3.selected = NO;
                    
                    //2.选择当前选择的
                    btn.selected = YES;
                    
                    //3.标记当前选择的
                    _selectedBtn3 = btn;
                    
                    if (_selectedBtn3.tag == 5) {
                        [weakself.financeDataDic setValue:@"1" forKey:@"borrow_interest_rate"];
                    }else if (_selectedBtn3.tag == 8){
                        [weakself.financeDataDic setValue:@"2" forKey:@"borrow_interest_rate"];
                    }else if (_selectedBtn3.tag == 11){
                        [weakself.financeDataDic setValue:@"3" forKey:@"borrow_interest_rate"];
                    }
                    
                }
                
                
                [self financialHeaderRefresh];
            }];
        }
    }
    return _collectionView;
}

-(UIButton *)downButton
{
    if (!_downButton) {
        _downButton = [UIButton newAutoLayoutView];
        _downButton.backgroundColor = kNavigationColor;
        
        [_downButton setImage:[UIImage imageNamed:@"arrow"] forState:0];
        [_downButton setImage:[UIImage imageNamed:@"arrowtop"] forState:UIControlStateSelected];
        
        ZXWeakSelf;
        [_downButton addAction:^(UIButton *btn) {
            btn.selected = !btn.selected;
            
            if (btn.selected) {
                weakself.topDownViewConstraints.constant = 120;
            }else{
                weakself.topDownViewConstraints.constant = 0;
            }
        }];
    }
    return _downButton;
}

-(UITableView *)searchTableView
{
    if (!_searchTableView) {
        _searchTableView = [UITableView newAutoLayoutView];
//        [[UITableView alloc] initWithFrame:CGRectMake(0,self.downButton.bottom, kScreenWidth, kScreenHeight-64-48-self.financeHeaderView.height-self.downButton.height) style:UITableViewStylePlain];
        _searchTableView.delegate = self;
        _searchTableView.dataSource = self;
        _searchTableView.showsVerticalScrollIndicator = NO;
        _searchTableView.tableFooterView = [[UIView alloc] init];
        [_searchTableView addHeaderWithTarget:self action:@selector(financialHeaderRefresh)];
        [_searchTableView addFooterWithTarget:self action:@selector(financialFooterRefrresh)];
       }
    return _searchTableView;
}

- (NSMutableDictionary *)financeDataDic
{
    if (!_financeDataDic) {
        _financeDataDic = [NSMutableDictionary dictionary];
    }
    return _financeDataDic;
}

-(NSArray *)collectionArray
{
    if (!_collectionArray) {
        _collectionArray = @[@"房抵贷",@"3个月",@"5%～10%",
                             @"直e贷",@"6个月",@"10%～15%",
                             @"直享贷",@"1年",@"15%～18%",
                             @"不限",@"不限",@"不限"
                             ];
    }
    return _collectionArray;
}

-(NSMutableArray *)financialArray
{
    if (!_financialArray) {
        _financialArray = [NSMutableArray array];
    }
    return _financialArray;
}

#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.financialArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"financial";
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[HomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    InvestModel *model = self.financialArray[indexPath.row];
    
    //进度
    cell.progressView.progress = [model.progress floatValue] * 0.01;
    cell.innnerLabel.text = [NSString stringWithFormat:@"进度\n%@",model.progress];
    
    //标名
    cell.borrowName.text = [NSString stringWithFormat:@"%@%@",model.borrow_type,model.borrow_name];
    
    //标状态 --－－－投资／售罄／预约
    [cell.signBtn setTitle:model.type forState:0];
    if ([model.type isEqualToString:@"售罄"]) {
        [cell.signBtn setBackgroundColor:[UIColor grayColor]];
        cell.signBtn.userInteractionEnabled = NO;
    }else {
        [cell.signBtn setBackgroundColor:kNavigationColor];
        cell.signBtn.userInteractionEnabled = YES;
        ZXWeakSelf;
        [cell.signBtn addAction:^(UIButton *btn) {
            [weakself requestDataOfCommitMessageWithModel:model];
        }];
    }
    //利率
    cell.rateLabel.text = model.borrow_interest_rate;
    
    //借款期限
    cell.dateLabel.text = model.borrow_duration;
    
    //利润
    cell.moneyLabel.text = model.borrow_money;
    
        return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    InvestModel *model = self.financialArray[indexPath.row];
    
    InvestDetailsViewController *investDetailVC = [[InvestDetailsViewController alloc] init];
    investDetailVC.hidesBottomBarWhenPushed = YES;
    investDetailVC.borrowID = model.ID;
    investDetailVC.borrowType = model.borrow_type;
    investDetailVC.type = model.type;
    investDetailVC.index = 0;
    [self.navigationController pushViewController:investDetailVC animated:YES];
}

#pragma mark - request
-(void)requestFinancialWithPage:(NSString *)page
{
    NSString *financialBidString = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFfinancialBid];
    
    [self.financeDataDic setValue:page forKey:@"p"];
    
    NSDictionary *params = self.financeDataDic;
    
    ZXWeakSelf;
    [self requestDataGetWithUrlString:financialBidString paramter:params SucceccBlock:^(id responseObject) {
        if ([page integerValue] == 1) {
            [weakself.financialArray removeAllObjects];
        }
        
        ResponseModel *responseModel = [ResponseModel objectWithKeyValues:responseObject];
        NormalModel *financialModel = responseModel.list;
        
        for (InvestModel *model in financialModel.product) {
            [weakself.financialArray addObject:model];
        }
        
        if (financialModel.product.count <= 0) {
            financialPage--;
            [weakself showHint:@"没有更多了"];
        }
        
        [weakself.searchTableView reloadData];
    } andFailedBlock:^{
        financialPage--;
    }];
    
    /*
     AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
     manager.responseSerializer = [AFHTTPResponseSerializer serializer];
     manager.requestSerializer = [AFHTTPRequestSerializer serializer];
     
     NSMutableDictionary *params = [NSMutableDictionary dictionary];
     
     params[@"p"] = page;
     
     //_selectedBtn1
     if ([_selectedBtn1.titleLabel.text isEqualToString:@"房抵贷"]) {
     params[@"borrow_type"] = @"1";
     }else if ([_selectedBtn1.titleLabel.text isEqualToString:@"直e贷"]){
     params[@"borrow_type"] = @"4";
     }else if ([_selectedBtn1.titleLabel.text isEqualToString:@"直享贷"]){
     params[@"borrow_type"] = @"2";
     }
     
     //_selectedBtn2
     if (_selectedBtn2.tag == 1) {
     params[@"borrow_duration"] = @"1";
     }else if (_selectedBtn2.tag == 4){
     params[@"borrow_duration"] = @"2";
     }else if (_selectedBtn2.tag == 7){
     params[@"borrow_duration"] = @"3";
     }
     
     //_selectedBtn3
     if (_selectedBtn3.tag == 2) {
     params[@"borrow_interest_rate"] = @"1";
     }else if (_selectedBtn3.tag == 5){
     params[@"borrow_interest_rate"] = @"2";
     }else if (_selectedBtn3.tag == 8){
     params[@"borrow_interest_rate"] = @"3";
     }
     
     NSString *financialBidString = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFfinancialBid];
     
     ZXWeakSelf;
     [manager GET:financialBidString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
     
     if ([page integerValue] == 1) {
     [weakself.financialArray removeAllObjects];
     }
     
     ResponseModel *responseModel = [ResponseModel objectWithKeyValues:responseObject];
     NormalModel *financialModel = responseModel.list;
     
     for (InvestModel *model in financialModel.product) {
     [weakself.financialArray addObject:model];
     }
     
     if (financialModel.product.count <= 0) {
     financialPage--;
     [weakself showRefreshText];
     }
     
     [weakself.searchTableView reloadData];
     
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
     financialPage--;
     }];
     
     */
}

-(void)financialHeaderRefresh
{
    financialPage = 1;
    [self requestFinancialWithPage:@"1"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.searchTableView headerEndRefreshing];
    });
}
int financialPage = 1;
-(void)financialFooterRefrresh
{
    financialPage += 1;
    NSString *page = [NSString stringWithFormat:@"%d",financialPage];
    
    [self requestFinancialWithPage:page];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.searchTableView footerEndRefreshing];
    });
}

-(void)requestDataOfCommitMessageWithModel:(InvestModel *)model
{
    NSString *investCommitString = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFinvestCommit];
    NSString *wowow  = TOKEN;
    if (wowow == nil || [wowow isKindOfClass:[NSNull class]]) {
        wowow = @"";
    }
    NSDictionary *params = @{
                             @"token" : wowow,
                             @"id"    : model.ID
                             };
    
    ZXWeakSelf;
    [self requestDataGetWithUrlString:investCommitString paramter:params SucceccBlock:^(id responseObject){
        
        BaseModel *baseModel = [BaseModel objectWithKeyValues:responseObject];
        
        if (!baseModel.status || [baseModel.status integerValue] == 1) {
            if ([model.type isEqualToString:@"预约"]) {//预约
                InvestDetailCommitOrderModel *commitOrderModel = [InvestDetailCommitOrderModel objectWithKeyValues:responseObject];
                OrderViewController *orderVC = [[OrderViewController alloc] init];
                orderVC.borrowID = model.ID;
                orderVC.orderModel = commitOrderModel;
                orderVC.borrowType = model.borrow_type;
                orderVC.hidesBottomBarWhenPushed = YES;
                [weakself.navigationController pushViewController:orderVC animated:YES];
            }else if ([model.type isEqualToString:@"投资"]){//投资
                InvestDetailCommitModel *commitInvestModel = [InvestDetailCommitModel objectWithKeyValues:responseObject];
                InvestViewController *investVC = [[InvestViewController alloc] init];
                investVC.borrowID = model.ID;
                investVC.investModel = commitInvestModel;
                investVC.borrowType = model.borrow_type;
                investVC.hidesBottomBarWhenPushed = YES;
                [weakself.navigationController pushViewController:investVC animated:YES];
            }
        }else{
            LoginViewController *loginVC = [[LoginViewController alloc] init];
            loginVC.hidesBottomBarWhenPushed = YES;
            UINavigationController *aiaii = [[UINavigationController alloc] initWithRootViewController:loginVC];
            [weakself presentViewController:aiaii animated:YES completion:nil];
        }
    } andFailedBlock:^{
        
    }];
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
