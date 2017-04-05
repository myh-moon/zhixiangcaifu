//
//  InvestDetailsViewController.m
//  zichanbao
//
//  Created by zhixiang on 15/11/17.
//  Copyright © 2015年 zhixiang. All rights reserved.
//

#import "InvestDetailsViewController.h"
#import "DetailsView.h"
#import "DetailsCell.h"
#import "NSDate+FormatterTime.h"

#import "InvestViewController.h"  //投资
#import "OrderViewController.h"  //预约
#import "LoginViewController.h"

//投资信息model
#import "InvestDetailModel.h"
#import "InvestDetailRepayList.h"

//投资记录
#import "InvestDetailRecordList.h"
#import "InvestDetailRecordModel.h"

//房抵贷投资记录
#import "InvestDetailRecordHomeList.h"
#import "InvestDetailRecordHomeModel.h"

//投资确认
#import "InvestDetailCommitModel.h"

//预约确认
#import "InvestDetailCommitOrderModel.h"

@interface InvestDetailsViewController ()<UITableViewDataSource,UITableViewDelegate>
/******   5块 *********/
@property (nonatomic,strong) DetailsView *topView;
@property (nonatomic,strong) UIView *switchView;   //项目详情，投资记录，还款方案
@property (nonatomic,strong) UIWebView *webView;
@property (nonatomic,strong) UIView *bottomView;  //底部投资视图
@property (nonatomic,strong) UITableView *detailTableView;
@property (nonatomic,strong) UILabel *orangeLabel;

@property (nonatomic,assign) NSInteger tagOpen; //标记orangeLabel

//switchView上面显示的文字
@property (nonatomic,copy) NSArray *titleArray1;

//json解析
@property (nonatomic,copy) NSMutableArray *recordArray;
@property (nonatomic,copy) NSMutableArray *wayArray;
@property (nonatomic,copy) AccountModel *accountModel;

@end

@implementation InvestDetailsViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBackgroundColor;
    self.navigationItem.leftBarButtonItem = self.leftItem;
    if ([self.borrowType isEqualToString:@"房抵贷"]) {
        self.navigationItem.title = @"预约详情";
        self.titleArray1 = @[@"项目详情",@"预约记录",@"还款方案"];
    }else{
        self.navigationItem.title = @"投资详情";
        self.titleArray1 = @[@"项目详情",@"投资记录",@"还款方案"];
    }
    
    [self.view addSubview:self.topView];
    [self.view addSubview:self.switchView];
    [self.view addSubview:self.detailTableView];
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.webView];
    
    [self requestInvestDetailDatas];
}

#pragma mark - request data
//request message and way
-(void)requestInvestDetailDatas
{
    NSString *detailInvestString = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFinvestDetails];
    NSDictionary *param = @{
                            @"id" : self.borrowID
                            };
    
    ZXWeakSelf;
    [self requestDataGetWithUrlString:detailInvestString paramter:param SucceccBlock:^(id responseObject){
               
        InvestDetailModel *investDetailMessageModel = [InvestDetailModel objectWithKeyValues:responseObject];
        
        [weakself.topView.typeBtn1 setTitle:investDetailMessageModel.borrow_type forState:0];
        weakself.topView.nameLabel.text = investDetailMessageModel.borrow_name;
        weakself.topView.rateLabel1.text = @"年化率";
        weakself.topView.rateLabel2.text = investDetailMessageModel.borrow_interest_rate;
        weakself.topView.timeLabel1.text = @"借款时间";
        weakself.topView.timeLabel2.text = investDetailMessageModel.borrow_duration;
        weakself.topView.progressView.progress = [investDetailMessageModel.progress floatValue]*0.01;
        
        //type不同，导致显示信息不同
        NSMutableAttributedString *leftAttribute;
        if ([investDetailMessageModel.borrow_type isEqualToString:@"房抵贷"]) {
            leftAttribute = [NSString getStringFromFirstString:@"已预约" andFirstColor:kBlackColor andFirstFont:font12 ToSecondString:investDetailMessageModel.progress andSecondColor:kNavigationColor andSecondFont:font12];
        }else{
            leftAttribute = [NSString getStringFromFirstString:@"已售" andFirstColor:kBlackColor andFirstFont:font12 ToSecondString:investDetailMessageModel.progress andSecondColor:kNavigationColor andSecondFont:font12];
        }
        [weakself.topView.leftLabel setAttributedText:leftAttribute];
        
        NSString *syMoney = [NSString stringWithFormat:@"%@元",investDetailMessageModel.sy_money];
        NSMutableAttributedString *rightAttribute = [NSString getStringFromFirstString:@"剩余总额" andFirstColor:kBlackColor andFirstFont:font12 ToSecondString:syMoney andSecondColor:kNavigationColor andSecondFont:font12];
        [weakself.topView.rightLabel setAttributedText:rightAttribute];
        
        NSString *borrowMin = [NSString stringWithFormat:@"%@元",investDetailMessageModel.borrow_min];
        NSMutableAttributedString *startAttribute = [NSString getStringFromFirstString:@"起投金额" andFirstColor:kBlackColor andFirstFont:font12 ToSecondString:borrowMin andSecondColor:kNavigationColor andSecondFont:font12];
        [weakself.topView.startMomeyLabel setAttributedText:startAttribute];
        
        weakself.topView.wayLabel.text = investDetailMessageModel.repayment_type;
        
        //项目介绍
        [weakself.webView loadHTMLString:investDetailMessageModel.borrow_info baseURL:nil];
        
        //还款方案
        for (InvestDetailRepayList *repayList in investDetailMessageModel.repay_list) {
            [weakself.wayArray addObject:repayList];
        }
        
        //记录
        [weakself requestDataOfRecords];
        
    } andFailedBlock:^{

    }];
}
//投资记录／预约记录
-(void)requestDataOfRecords
{
    NSString *investRecordString = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFinvestRecords];
    NSDictionary *param = @{
                            @"id" : self.borrowID
                            };
    
    ZXWeakSelf;
    [self requestDataGetWithUrlString:investRecordString paramter:param SucceccBlock:^(id responseObject){
        
        if ([weakself.borrowType isEqualToString:@"房抵贷"]) {//房抵贷是yuyue
            InvestDetailRecordHomeList *recordHomeList = [InvestDetailRecordHomeList objectWithKeyValues:responseObject];
            for(InvestDetailRecordHomeModel *recordHomeModel in recordHomeList.yuyue) {
                [weakself.recordArray addObject:recordHomeModel];
            }
        }else{//其他是touzi
            InvestDetailRecordList *recordList = [InvestDetailRecordList objectWithKeyValues:responseObject];
            for (InvestDetailRecordModel *recordModel in recordList.touzi) {
                [weakself.recordArray addObject:recordModel];
            }
        }
    } andFailedBlock:^{

    }];
}
//确认投资
-(void)requestDataOfInvestCommit
{
    NSString *investCommitString = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFinvestCommit];
    NSDictionary *params = @{
                             @"token" : TOKEN,
                             @"id"    : self.borrowID
                             };
    
    ZXWeakSelf;
    [self requestDataGetWithUrlString:investCommitString paramter:params SucceccBlock:^(id responseObject){
        if ([weakself.borrowType isEqualToString:@"房抵贷"]) {
            InvestDetailCommitOrderModel *commitOrderModel = [InvestDetailCommitOrderModel objectWithKeyValues:responseObject];
            OrderViewController *orderVC = [[OrderViewController alloc] init];
            orderVC.borrowID = weakself.borrowID;
            orderVC.orderModel = commitOrderModel;
            orderVC.borrowType = weakself.borrowType;
            [weakself.navigationController pushViewController:orderVC animated:YES];
        }else{
            InvestDetailCommitModel *investCommitModel = [InvestDetailCommitModel objectWithKeyValues:responseObject];
            InvestViewController *investVC = [[InvestViewController alloc] init];
            investVC.investModel = investCommitModel;
            investVC.borrowType = weakself.borrowType;
            investVC.borrowID = weakself.borrowID;
            [weakself.navigationController pushViewController:investVC animated:YES];
        }
        
    } andFailedBlock:^{

    }];
}

#pragma mark - tableView delegate and dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_tagOpen == 1) {
        return self.recordArray.count+1;
    }else if (_tagOpen == 2){
        return self.wayArray.count + 1;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"detail";
    DetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[DetailsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSArray *a1 = [NSArray arrayWithObjects:@"投标人",@"投标金额",@"投标时间", nil];
    NSArray *a2 = [NSArray arrayWithObjects:@"期数",@"还款时间",@"本期应还总额", nil];
    NSArray *a3 = [NSArray arrayWithObjects:@"预约人",@"预约金额",@"预约时间", nil];
    
    if (_tagOpen == 1) {//投资记录
        if (indexPath.row == 0) {
            cell.backgroundColor = RGBCOLOR1(182, 182, 182);
            cell.topLabel1.textColor=[UIColor whiteColor];
            cell.topLabel2.textColor=[UIColor whiteColor];
//            cell.topLabel3.textColor=[UIColor whiteColor];
            [cell.topButton3 setTitleColor:kWhiteColor forState:0];
            
            if ([self.borrowType isEqualToString:@"房抵贷"]) {
                cell.topLabel1.text = a3[0];
                cell.topLabel2.text = a3[1];
                [cell.topButton3 setTitle:a3[2] forState:0];
            }else{
                cell.topLabel1.text = a1[0];
                cell.topLabel2.text = a1[1];
                [cell.topButton3 setTitle:a1[2] forState:0];
            }
        }else {
            cell.backgroundColor = [UIColor whiteColor];
            cell.topLabel1.textColor=[UIColor blackColor];
            cell.topLabel2.textColor=[UIColor blackColor];
            [cell.topButton3 setTitleColor:kBlackColor forState:0];
            
            if ([self.borrowType isEqualToString:@"房抵贷"]) {
                InvestDetailRecordHomeModel *recordHomeModel = self.recordArray[indexPath.row-1];
                //预约人
                cell.topLabel1.text = recordHomeModel.phone;
                cell.topLabel2.text = [NSString stringWithFormat:@"¥%@",recordHomeModel.money];
                [cell.topButton3 setTitle:[NSDate getYMDFormatterTime:recordHomeModel.time] forState:0];
            }else{
                InvestDetailRecordModel *recordModel = self.recordArray[indexPath.row-1];
                //投标人
                cell.topLabel1.text = recordModel.investor_uid;
                //投标金额
                cell.topLabel2.text =  [NSString stringWithFormat:@"¥%@",recordModel.investor_capital];
                //投标时间
                [cell.topButton3 setTitle: [NSDate getYMDFormatterTime:recordModel.add_time] forState:0];
            }
            
        }
    }else if (_tagOpen == 2){//还款方案
        if (indexPath.row==0) {
            cell.backgroundColor=RGBCOLOR1(182, 182, 182);
            
            cell.topLabel1.textColor=[UIColor whiteColor];
            cell.topLabel2.textColor=[UIColor whiteColor];
            [cell.topButton3 setTitleColor:kWhiteColor forState:0];
            
            cell.topLabel1.text = a2[0];
            cell.topLabel2.text = a2[1];
            [cell.topButton3 setTitle:a2[2] forState:0];
            
        }else
        {
            cell.backgroundColor = [UIColor whiteColor];
            cell.topLabel1.textColor=[UIColor blackColor];
            cell.topLabel2.textColor=[UIColor blackColor];
            [cell.topButton3 setTitleColor:kBlackColor forState:0];
            
            InvestDetailRepayList *repayList = self.wayArray[indexPath.row-1];
            
            //期数
            cell.topLabel1.text = [NSString stringWithFormat:@"%li",(long)indexPath.row];
            
            //还款时间
            NSString *timeStr = repayList.repayment_time;
            if ([timeStr integerValue]) {
                cell.topLabel2.text = [NSDate getYMDFormatterTime:repayList.repayment_time];
            }else{
                cell.topLabel2.text = @"放款后出日期";
            }
            
            //本期应还总额
            [cell.topButton3 setTitle:[NSString stringWithFormat:@"¥%@",repayList.repayment_money] forState:0];
        }
    }
    
    return cell;
}

#pragma mark - button click
-(void)switchBtn:(UIButton *)button
{
    _tagOpen=(int)button.tag;
    switch (button.tag) {
        case 0:
            [self.view bringSubviewToFront:self.webView];
            break;
        case 1:
            [self.view bringSubviewToFront:self.detailTableView];
            [self.detailTableView reloadData];
            break;
        case 2:
            [self.view bringSubviewToFront:self.detailTableView];
            [self.detailTableView reloadData];
            
            break;
            
        default:
            break;
    }
    [UIView animateWithDuration:0.3 animations:^{
        _orangeLabel.frame=CGRectMake(button.frame.origin.x+30,button.bottom-2, button.frame.size.width-30*2, 2);
    }];
}

#pragma mark - init view
-(DetailsView *)topView
{
    if (!_topView) {
        _topView = [[DetailsView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, 170)];
    }
    return _topView;
}

-(UIView *)switchView
{
    if (!_switchView) {
        _switchView = [[UIView alloc] initWithFrame:CGRectMake(0, self.topView.bottom+10, kScreenWidth, 50)];
        _switchView.backgroundColor = [UIColor whiteColor];
        for (int i=0; i<3; i++) {
            UIButton *butt = [UIButton buttonWithType:0];
            butt.frame = CGRectMake(kScreenWidth/3*i, 0, kScreenWidth/3, 40);
            [butt setTitle:self.titleArray1[i] forState:0];
            [butt setTitleColor:[UIColor blackColor] forState:0];
            butt.titleLabel.font = font14;
            [_switchView addSubview:butt];
            butt.tag = i;
            
            ZXWeakSelf;
            [butt addAction:^(UIButton *btn) {
                [weakself switchBtn:btn];
            }];
        }
        //滑动分隔线
        _orangeLabel = [[UILabel alloc] initWithFrame:CGRectMake(30,38,kScreenWidth/3-30*2, 2)];
        _orangeLabel.backgroundColor = kNavigationColor;
        [_switchView addSubview:_orangeLabel];
    }
    return _switchView;
}

-(UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.detailTableView.frame];
    }
    return _webView;
}

-(UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.detailTableView.bottom, kScreenWidth, 50)];
        _bottomView.backgroundColor = RGBCOLOR(0.9294, 0.9333, 0.9373);
        //投资按钮
        UIButton *investBtn = [UIButton buttonWithType:0];
        investBtn.frame = CGRectMake(kScreenWidth/3, 10, kScreenWidth/3, 30);
        [investBtn setTitleColor:[UIColor whiteColor] forState:0];
        investBtn.layer.cornerRadius = 15;
        investBtn.titleLabel.font = font14;
        [investBtn setTitle:self.type forState:0];
        [_bottomView addSubview:investBtn];
        
        ZXWeakSelf;
        [investBtn addAction:^(UIButton *btn) {
           AccountModel *accountModel = [self checkMyAccount];
            if (!accountModel.status) {//登录正常
                [weakself requestDataOfInvestCommit];
            }else{//登录过期
                [weakself showHint:accountModel.info];
            }
        }];
        
        if ([self.type isEqualToString:@"售罄"]){
            [investBtn setBackgroundColor:[UIColor grayColor]];
            investBtn.userInteractionEnabled = NO;
        }else{
            [investBtn setBackgroundColor:kNavigationColor];
            [investBtn addAction:^(UIButton *btn) {
               AccountModel *accountModel = [self checkMyAccount];
                if (!accountModel.status) {//登录正常
                    [weakself requestDataOfInvestCommit];
                }else{//登录过期
                    [weakself showHint:accountModel.info];
                    LoginViewController *loginVC = [[LoginViewController alloc] init];
                    UINavigationController *jajja = [[UINavigationController alloc] initWithRootViewController:loginVC];
                    [weakself presentViewController:jajja animated:YES completion:nil];
                }
            }];
        }
    }
    return _bottomView;
}

-(UITableView *)detailTableView
{
    if (!_detailTableView) {
        _detailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.switchView.bottom+1, kScreenWidth, kScreenHeight-64-self.topView.height-10-self.switchView.height-50)];
        _detailTableView.delegate = self;
        _detailTableView.dataSource = self;
        _detailTableView.showsVerticalScrollIndicator = NO;
        _detailTableView.tableFooterView = [[UIView alloc] init];
        _detailTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return _detailTableView;
}


#pragma mark - init array
-(NSMutableArray *)recordArray
{
    if (!_recordArray) {
        _recordArray = [NSMutableArray array];
    }
    return _recordArray;
}

-(NSMutableArray *)wayArray
{
    if (!_wayArray) {
        _wayArray = [NSMutableArray array];
    }
    return _wayArray;
}

-(NSArray *)titleArray1
{
    if (!_titleArray1) {
        _titleArray1 = [NSArray array];
    }
    return _titleArray1;
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
