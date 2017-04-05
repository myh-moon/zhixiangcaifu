//
//  MyInvestDetailViewController.m
//  zichanbao
//
//  Created by zhixiang on 15/11/17.
//  Copyright © 2015年 zhixiang. All rights reserved.
//

#import "MyInvestDetailViewController.h"
#import "NSDate+FormatterTime.h"
#import "IntermAgreementsViewController.h"
#import "TransAgreementsViewController.h"
#import "WindRepotViewController.h" //风控报告

#import "DetailsView.h"
#import "DetailsCell.h"
#import "RePayDetailCell.h"
//详细信息
#import "MyInvestDetailModel.h"

//还款方案
#import "MyInvestDetailWaysModel.h"

//投资记录
#import "MyInvestDetailRecordModel.h"

@interface MyInvestDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) DetailsView *topView;
@property (nonatomic,strong) UIView *protocolView;
@property (nonatomic,strong) UIButton *proButton;
@property (nonatomic,strong) UIView *switchView;   //项目详情，投资记录，还款方案
@property (nonatomic,strong) UIWebView *webView;

@property (nonatomic,strong) UITableView *myDetailTableView;
@property (nonatomic,strong) UILabel *orangeLabel;
@property (nonatomic,assign) NSInteger tagOpen; //标记

//json解析
@property (nonatomic,strong)NSMutableDictionary *detailDictionary;
@property (nonatomic,strong) NSMutableArray *recordArray;
@property (nonatomic,strong) NSMutableArray *wayArray;


@end

@implementation MyInvestDetailViewController

#pragma mark - method
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBackgroundColor;
    self.navigationItem.leftBarButtonItem = self.leftItem;
    self.navigationItem.title = @"投资详情";
    
    [self.view addSubview:self.topView];
    [self.view addSubview:self.protocolView];
    [self.view addSubview:self.switchView];
    [self.view addSubview:self.myDetailTableView];
    [self.view addSubview:self.webView];
    
    [self requestDataOfInvestDetailMessage];
}

#pragma mark - data request
-(void)requestDataOfInvestDetailMessage
{
    NSString *myInvestDetailString = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFmyDetailInvest];
    NSDictionary *params = @{
                             @"token" : TOKEN,
                             @"id" : self.idString
                             };
    
    ZXWeakSelf;
    [self requestDataGetWithUrlString:myInvestDetailString paramter:params SucceccBlock:^(id responseObject){
        
        MyInvestDetailModel *detailInvestModel = [MyInvestDetailModel objectWithKeyValues:responseObject];
        
        [weakself.proButton setTitle:detailInvestModel.name forState:0];
        
        //头部详细信息
        [weakself.topView.typeBtn1 setTitle:detailInvestModel.borrow_type forState:0];
        weakself.topView.nameLabel.text = detailInvestModel.borrow_name;
        weakself.topView.rateLabel1.text = @"年化率";
        weakself.topView.rateLabel2.text = detailInvestModel.borrow_interest_rate;
        weakself.topView.timeLabel1.text = @"借款时间";
        weakself.topView.timeLabel2.text = detailInvestModel.borrow_duration;
        weakself.topView.progressView.progress = [detailInvestModel.progress floatValue]*0.01;
        
        //风控报告
        if ([weakself.borrowType isEqualToString:@"房抵贷"]) {//房抵贷
            [weakself.topView.windReportButton setTitle:@"风控报告" forState:0];
            [weakself.topView.windReportButton addAction:^(UIButton *btn) {
                WindRepotViewController *windReportVC = [[WindRepotViewController alloc] init];
                windReportVC.windTitle = @"风控报告";
                windReportVC.borrowID = detailInvestModel.ID;
                [weakself.navigationController pushViewController:windReportVC animated:YES];
            }];
        }
        
        NSString *leftStri = [NSString stringWithFormat:@"%@元",detailInvestModel.capital];
        NSMutableAttributedString *leftAttri = [NSString getStringFromFirstString:@"投资金额" andFirstColor:kBlackColor andFirstFont:font12 ToSecondString:leftStri andSecondColor:kNavigationColor andSecondFont:font12];
        [weakself.topView.leftLabel setAttributedText:leftAttri];
        
        
        NSMutableAttributedString *rightAttri = [NSString getStringFromFirstString:@"计息日" andFirstColor:kBlackColor andFirstFont:font12 ToSecondString:[NSDate getYMDFormatterTime:detailInvestModel.add_time] andSecondColor:kNavigationColor andSecondFont:font12];
        [weakself.topView.rightLabel setAttributedText:rightAttri];
        
        NSString *startMoneyStri = [NSString stringWithFormat:@"%@元",detailInvestModel.interest];
        NSMutableAttributedString *startAttri = [NSString getStringFromFirstString:@"预计收益" andFirstColor:kBlackColor andFirstFont:font12 ToSecondString:startMoneyStri andSecondColor:kNavigationColor andSecondFont:font12];
        [weakself.topView.startMomeyLabel setAttributedText:startAttri];
        
        weakself.topView.wayLabel.text = detailInvestModel.repayment_type;
        
        //项目详情
        [weakself.webView loadHTMLString:detailInvestModel.borrow_info baseURL:nil];
            
        //投资记录
        [weakself.recordArray addObject:detailInvestModel];
        
        if (weakself.wayArray.count == 0) {
            [weakself requestDataOfInvestDetailways];
        }
        
    } andFailedBlock:^{

    }];
}
//还款方案
-(void)requestDataOfInvestDetailways
{
    NSString *detailRecordString = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFmyDetailInvestways];
    NSDictionary *params = @{
                             @"token" : TOKEN,
                             @"id" : self.borrowID
                             };
    
    ZXWeakSelf;
    [self requestDataGetWithUrlString:detailRecordString paramter:params SucceccBlock:^(id responseObject){
        
        NSArray *array = [MyInvestDetailWaysModel objectArrayWithKeyValuesArray:responseObject];
        
        for (MyInvestDetailWaysModel *detailwaysModel in array) {
            [weakself.wayArray addObject:detailwaysModel];
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
    static NSString *identifier;
    if (_tagOpen ==1) {
        identifier = @"detail1";
        DetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[DetailsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0) {
            cell.backgroundColor = RGBCOLOR1(182, 182, 182);
            cell.topLabel1.textColor=[UIColor whiteColor];
            cell.topLabel2.textColor=[UIColor whiteColor];
//            cell.topLabel3.textColor=[UIColor whiteColor];
            [cell.topButton3 setTitleColor:kWhiteColor forState:0];
            
            NSArray *arr = @[@"投标人",@"投标金额",@"投标时间"];
            cell.topLabel1.text = arr[0];
            cell.topLabel2.text = arr[1];
            [cell.topButton3 setTitle:arr[2] forState:0];
            
        }else{
            cell.backgroundColor = [UIColor whiteColor];
            cell.topLabel1.textColor=[UIColor blackColor];
            cell.topLabel2.textColor=[UIColor blackColor];
            [cell.topButton3 setTitleColor:kBlackColor forState:0];
            
            MyInvestDetailRecordModel *recordModel = self.recordArray[indexPath.row-1];
            cell.topLabel1.text = recordModel.phone;
            cell.topLabel2.text = recordModel.capital;
            [cell.topButton3 setTitle: [NSDate getYMDFormatterTime:recordModel.time] forState:0];
        }
        return cell;
    }else if (_tagOpen == 2){
        identifier = @"detail2";
        RePayDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[RePayDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.row == 0) {
            cell.backgroundColor = RGBCOLOR1(182, 182, 182);
            cell.rePayLabel1.textColor=[UIColor whiteColor];
            cell.rePayLabel2.textColor=[UIColor whiteColor];
            cell.rePayLabel3.textColor=[UIColor whiteColor];
            cell.rePayLabel4.textColor=[UIColor whiteColor];

            NSArray *arr = @[@"期数",@"还款时间",@"本期应还",@"本期实还"];
            cell.rePayLabel1.text = arr[0];
            cell.rePayLabel2.text = arr[1];
            cell.rePayLabel3.text = arr[2];
            cell.rePayLabel4.text = arr[3];
        }else{
            cell.backgroundColor = [UIColor whiteColor];
            cell.rePayLabel1.textColor=[UIColor blackColor];
            cell.rePayLabel2.textColor=[UIColor blackColor];
            cell.rePayLabel3.textColor=[UIColor blackColor];
            cell.rePayLabel4.textColor=[UIColor blackColor];
            
            MyInvestDetailWaysModel *wayModel = self.wayArray[indexPath.row-1];
            cell.rePayLabel1.text = [NSString stringWithFormat:@"%li",(long)indexPath.row];
            
            NSString *timeStr = wayModel.deadline;
            if ([timeStr integerValue]) {
                cell.rePayLabel2.text = [NSDate getYMDFormatterTime:timeStr];
            }else{
                cell.rePayLabel2.text = @"放款后出日期";
            }
            cell.rePayLabel3.text =  [NSString stringWithFormat:@"¥%@",wayModel.capital];
            cell.rePayLabel4.text =  [NSString stringWithFormat:@"¥%@",wayModel.recapital];
        }
        
        return cell;
    }
    return nil;
}

#pragma mark - init view
-(DetailsView *)topView
{
    if (!_topView) {
        _topView = [[DetailsView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, 170)];
    }
    return _topView;
}

-(UIView *)protocolView
{
    if (!_protocolView) {
        _protocolView = [[UIView alloc] initWithFrame:CGRectMake(0, self.topView.bottom+10, kScreenWidth, 50)];
        _protocolView.backgroundColor = [UIColor whiteColor];
        
        [_protocolView addSubview:self.proButton];
        
        
        UILabel *proLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-40, 15, 20, 20)];
        [proLabel setText:@">"];
        [proLabel setTextColor:[UIColor grayColor]];
        [_protocolView addSubview:proLabel];

    }
    return _protocolView;
}

- (UIButton *)proButton
{
    if (!_proButton) {
        _proButton = [UIButton buttonWithType:0];
        _proButton.frame = CGRectMake(0,0, kScreenWidth, 50);
        [_proButton setTitleColor:[UIColor blackColor] forState:0];
        _proButton.titleLabel.font = font14;
        [_proButton setContentEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
        [_proButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        
        ZXWeakSelf;
        [_proButton addAction:^(UIButton *btn) {
            //协议
            TransAgreementsViewController *transAgreementsVC = [[TransAgreementsViewController alloc] init];
            transAgreementsVC.borrowID = weakself.idString;
            transAgreementsVC.tranTitle = btn.titleLabel.text;
            [weakself.navigationController pushViewController:transAgreementsVC animated:YES];
        }];
    }
    return _proButton;
}


-(UIView *)switchView
{
    if (!_switchView) {
        _switchView = [[UIView alloc] initWithFrame:CGRectMake(0, self.protocolView.bottom+10, kScreenWidth, 50)];
        _switchView.backgroundColor = [UIColor whiteColor];
        
        NSArray *titleArray = [NSArray arrayWithObjects:@"项目详情",@"投资记录",@"还款方案", nil];
        for (int i=0; i<3; i++) {
            UIButton *butt = [UIButton buttonWithType:0];
            butt.frame = CGRectMake(kScreenWidth/3*i, 0, kScreenWidth/3, 40);
            [butt setTitle:titleArray[i] forState:0];
            [butt setTitleColor:[UIColor blackColor] forState:0];
            butt.titleLabel.font = font14;
            [_switchView addSubview:butt];
            butt.tag = i;

        [butt addAction:^(UIButton *button) {
            _tagOpen=(int)button.tag;
            switch (button.tag) {
                case 0:
                    [self.view bringSubviewToFront:self.webView];
                    break;
                case 1:
                    [self.view bringSubviewToFront:self.myDetailTableView];
                    [self.myDetailTableView reloadData];
                    break;
                case 2:
                    [self.view bringSubviewToFront:self.myDetailTableView];
                    [self.myDetailTableView reloadData];
                    
                    break;
                    
                default:
                    break;
            }
            [UIView animateWithDuration:0.3 animations:^{
                _orangeLabel.frame=CGRectMake(button.frame.origin.x+30,button.bottom-2, button.frame.size.width-30*2, 2);
            }];
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
        _webView = [[UIWebView alloc] initWithFrame:self.myDetailTableView.frame];
    }
    return _webView;
}

-(UITableView *)myDetailTableView
{
    if (_myDetailTableView == nil) {
        _myDetailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.switchView.bottom, kScreenWidth,kScreenHeight-64-(self.topView.height+10+self.protocolView.height+10+self.switchView.height))];
        _myDetailTableView.delegate = self;
        _myDetailTableView.dataSource = self;
        _myDetailTableView.showsVerticalScrollIndicator = NO;
        _myDetailTableView.tableFooterView = [[UIView alloc] init];
    }
    return _myDetailTableView;
}

#pragma mark - init dictionary or array
-(NSMutableDictionary *)detailDictionary
{
    if (_detailDictionary == nil) {
        _detailDictionary = [NSMutableDictionary dictionary];
    }
    return _detailDictionary;
}
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
