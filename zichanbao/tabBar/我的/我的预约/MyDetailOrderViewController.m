//
//  MyDetailOrderViewController.m
//  zichanbao
//
//  Created by zhixiang on 15/10/28.
//  Copyright (c) 2015年 zhixiang. All rights reserved.
//

#import "MyDetailOrderViewController.h"
#import "DetailsView.h"
#import "DetailsCell.h"  //自定义单元格
#import "NSDate+FormatterTime.h"

//详细信息
#import "InvestDetailModel.h"
//还款方案
#import "InvestDetailRepayList.h"
//投资记录
#import "InvestDetailRecordHomeList.h"
#import "InvestDetailRecordHomeModel.h"

@interface MyDetailOrderViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (nonatomic,strong) DetailsView *topView;
@property (nonatomic,strong) UIView *switchView;   //项目详情，预约记录，还款方案
@property (nonatomic,strong) UIWebView *webView;
@property (nonatomic,strong) UITableView *myOrderTableView;
@property (nonatomic,strong) UILabel *orangeLabel;
@property (nonatomic,assign) NSInteger tagOpen; //标记


//json解析字典
@property (nonatomic,strong) NSMutableArray *detailOrderMessageArray;
@property (nonatomic,copy)NSMutableDictionary *detailDictionary;
@property (nonatomic,copy) NSMutableArray *recordArray;
@property (nonatomic,copy) NSMutableArray *wayArray;

@end

@implementation MyDetailOrderViewController
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBackgroundColor;
    self.navigationItem.title = @"预约详情";
    self.navigationItem.leftBarButtonItem = self.leftItem;

    [self.view addSubview:self.topView];
    [self.view addSubview:self.switchView];
    [self.view addSubview:self.myOrderTableView];
    [self.view addSubview:self.webView];
    
    [self requestOrderDetailData];
}

#pragma mark - request data
-(void)requestOrderDetailData
{
    NSString *myOrderDetailString = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFinvestDetails];
    NSDictionary *params = @{
                             @"id" : self.borrowID
                             };
    
    ZXWeakSelf;
    [self requestDataGetWithUrlString:myOrderDetailString paramter:params SucceccBlock:^(id responseObject){
        
        InvestDetailModel *myDetailOrderModel = [InvestDetailModel objectWithKeyValues:responseObject];
        
        //详细信息
        [weakself.topView.typeBtn1 setTitle:myDetailOrderModel.borrow_type forState:0];
        weakself.topView.nameLabel.text = myDetailOrderModel.borrow_name;
        weakself.topView.rateLabel1.text = @"年化率";
        weakself.topView.rateLabel2.text = myDetailOrderModel.borrow_interest_rate;
        weakself.topView.timeLabel1.text = @"借款时间";
        weakself.topView.timeLabel2.text = myDetailOrderModel.borrow_duration;
        weakself.topView.progressView.progress = [myDetailOrderModel.progress floatValue]*0.01;
        
        
        NSMutableAttributedString *leftAttri = [NSString getStringFromFirstString:@"已预约" andFirstColor:kBlackColor andFirstFont:font12 ToSecondString:myDetailOrderModel.progress andSecondColor:kNavigationColor andSecondFont:font12];
        [weakself.topView.leftLabel setAttributedText:leftAttri];
        
        NSString *rightStri = [NSString stringWithFormat:@"%@元",myDetailOrderModel.sy_money];
        NSMutableAttributedString *rightAttri = [NSString getStringFromFirstString:@"剩余总额" andFirstColor:kBlackColor andFirstFont:font12 ToSecondString:rightStri andSecondColor:kNavigationColor andSecondFont:font12];
        [weakself.topView.rightLabel setAttributedText:rightAttri];
        
        
        NSString *startMoneyStri = [NSString stringWithFormat:@"%@元",myDetailOrderModel.borrow_min];
        NSMutableAttributedString *startAttri = [NSString getStringFromFirstString:@"起投金额" andFirstColor:kBlackColor andFirstFont:font12 ToSecondString:startMoneyStri andSecondColor:kNavigationColor andSecondFont:font12];
        [weakself.topView.startMomeyLabel setAttributedText:startAttri];
        
        weakself.topView.wayLabel.text = myDetailOrderModel.repayment_type;
        
        //项目详情
        [weakself.webView loadHTMLString:myDetailOrderModel.borrow_info baseURL:nil];
        
        //还款方案
        for (InvestDetailRepayList *repayList in myDetailOrderModel.repay_list) {
            [weakself.wayArray addObject:repayList];
        }
        
    } andFailedBlock:^{

    }];
}

-(void)requestDataOfRecord
{
    NSString *recordString = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCForderRecords];
    NSDictionary *param = @{
                            @"id" : self.borrowID
                            };
    
    ZXWeakSelf;
    [self requestDataGetWithUrlString:recordString paramter:param SucceccBlock:^(id responseObject){
        
        InvestDetailRecordHomeList *recordHomeList = [InvestDetailRecordHomeList objectWithKeyValues:responseObject];
        
        for (InvestDetailRecordHomeModel *recordModel in recordHomeList.yuyue) {
            [weakself.recordArray addObject:recordModel];
        }
        [weakself.myOrderTableView reloadData];
    } andFailedBlock:^{

    }];
}

#pragma mark - init
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
        
        NSArray *titleArray = [NSArray arrayWithObjects:@"项目详情",@"预约记录",@"还款方案", nil];
        for (int i=0; i<3; i++) {
            UIButton *butt = [UIButton buttonWithType:0];
            butt.frame = CGRectMake(kScreenWidth/3*i, 0, kScreenWidth/3, 40);
            [butt setTitle:titleArray[i] forState:0];
            [butt setTitleColor:[UIColor blackColor] forState:0];
            butt.titleLabel.font = font14;
            [_switchView addSubview:butt];
            butt.tag = i;
            
            ZXWeakSelf;
            [butt addAction:^(UIButton *btn) {
                _tagOpen = (int)btn.tag;
                //0-项目详情；1-预约记录；2-还款方案
                switch (btn.tag) {
                    case 0:{
                        [self.view bringSubviewToFront:self.webView];
                    }
                        break;
                    case 1:{
                        [self.view bringSubviewToFront:self.myOrderTableView];
                        if (weakself.recordArray.count == 0) {
                            [weakself requestDataOfRecord];
                        }else{
                            [weakself.myOrderTableView reloadData];
                        }
                    }
                        break;
                    case 2:{
                        [self.view bringSubviewToFront:self.myOrderTableView];
                        [self.myOrderTableView reloadData];
                    }
                        break;
                        
                    default:
                        break;
                }
                
                [UIView animateWithDuration:0.3 animations:^{
                    _orangeLabel.frame=CGRectMake(btn.frame.origin.x+30,btn.bottom-2, btn.frame.size.width-30*2, 2);
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
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, self.switchView.bottom+1, kScreenWidth, self.view.height-(self.topView.height+10+self.switchView.height+1))];
    }
    return _webView;
}

-(UITableView *)myOrderTableView
{
    if (!_myOrderTableView) {
        _myOrderTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.switchView.bottom+1, kScreenWidth, self.view.height-(self.topView.height+10+self.switchView.height+1)) style:UITableViewStylePlain];
        _myOrderTableView.delegate = self;
        _myOrderTableView.dataSource = self;
        _myOrderTableView.tableFooterView = [[UIView alloc] init];
    }
    return _myOrderTableView;
}

#pragma mark - init array and dic
-(NSMutableArray *)detailOrderMessageArray
{
    if (!_detailOrderMessageArray) {
        _detailOrderMessageArray = [NSMutableArray array];
    }
    return _detailOrderMessageArray;
}
-(NSMutableArray *)recordArray
{
    if (_recordArray == nil) {
        _recordArray = [NSMutableArray array];
    }
    return _recordArray;
}

-(NSMutableArray *)wayArray
{
    if (_wayArray == nil) {
        _wayArray = [NSMutableArray array];
    }
    return _wayArray;
}
-(NSMutableDictionary *)detailDictionary
{
    if (_detailDictionary == nil) {
        _detailDictionary = [NSMutableDictionary dictionary];
    }
    return _detailDictionary;
}

#pragma mark - tableView delegate and dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_tagOpen == 1) {//预约记录
        return self.recordArray.count + 1;
    }else if (_tagOpen == 2){//还款方案
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
    
    NSArray *a1 = [NSArray arrayWithObjects:@"预约人",@"预约金额",@"预约时间", nil];
    NSArray *a2 = [NSArray arrayWithObjects:@"期数",@"还款时间",@"本期应还总额", nil];
    
    if (indexPath.row == 0) {
        cell.backgroundColor = RGBCOLOR1(182, 182, 182);
        cell.topLabel1.textColor=[UIColor whiteColor];
        cell.topLabel2.textColor=[UIColor whiteColor];
        [cell.topButton3 setTitleColor:kWhiteColor forState:0];
        
        NSArray *titleArray = nil;
        if (_tagOpen == 1) {//预约记录
            titleArray = a1;
        }else if (_tagOpen == 2){//还款方案
            titleArray = a2;
        }
        cell.topLabel1.text = titleArray[0];
        cell.topLabel2.text = titleArray[1];
        [cell.topButton3 setTitle:titleArray[2] forState:0];
        
    }else{
        cell.backgroundColor = [UIColor whiteColor];
        cell.topLabel1.textColor=[UIColor blackColor];
        cell.topLabel2.textColor=[UIColor blackColor];
        [cell.topButton3 setTitleColor:kBlackColor forState:0];
        
        if (_tagOpen == 1) {//预约记录
            InvestDetailRecordHomeModel *recordModel = self.recordArray[indexPath.row-1];
            cell.topLabel1.text = recordModel.phone;
            cell.topLabel2.text = [NSString stringWithFormat:@"¥%@",recordModel.money];
            if ([recordModel.time intValue]) {
                [cell.topButton3 setTitle:[NSDate getYMDFormatterTime:recordModel.time] forState:0];
            }else{
                [cell.topButton3 setTitle:recordModel.time forState:0];
            }
            
        }else if (_tagOpen == 2){//还款方案
            
            InvestDetailRepayList *wayModel = self.wayArray[indexPath.row-1];
            
            cell.topLabel1.text = [NSString stringWithFormat:@"%ld",indexPath.row];
            if ([wayModel.repayment_time intValue]) {
                cell.topLabel2.text = [NSDate getYMDFormatterTime:wayModel.repayment_time];
            }else{
                cell.topLabel2.text = wayModel.repayment_time;
            }
            [cell.topButton3 setTitle:[NSString stringWithFormat:@"¥%@",wayModel.repayment_money] forState:0];
        }
    }
    
    return cell;
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
