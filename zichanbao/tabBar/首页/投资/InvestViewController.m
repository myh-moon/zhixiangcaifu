//
//  InvestViewController.m
//  zichanbao
//
//  Created by zhixiang on 15/10/22.
//  Copyright (c) 2015年 zhixiang. All rights reserved.
//

#import "InvestViewController.h"
#import "RechargeViewController.h"   //充值
#import "FinishInvestViewController.h"  //投资成功
#import "IntermAgreementViewController.h"  //协议

#import "DetailsView.h"   //投资信息（topInvestView）
#import "InvestSecondSubView.h"  //投资金额（secondView）
#import "InvestssCell.h"
#import "InvestsCell.h"


#import "FinishInvestModel.h"


@interface InvestViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIAlertViewDelegate>

@property (nonatomic,strong) UITableView *tableView1;
@property (nonatomic,strong) DetailsView *topInvestView;//详细投资信息
@property (nonatomic,strong) InvestSecondSubView *secondView;//投资金额，投资券
@property (nonatomic,strong) UIView *thirdView;//分享码
@property (nonatomic,strong) UIView *fourView;//总投资金额

@property (nonatomic,strong) UITextField *codeTextField;//具体分享码
@property (nonatomic,strong) UITextField *allMoneyTextField;//总投资金额

//@property (nonatomic,strong) UITapGestureRecognizer *tapGesture;

//传参
@property (nonatomic,strong) NSString *isTicket;
@property (nonatomic,strong) NSString *isPacket;

//json
@property (nonatomic,strong) NSMutableDictionary *investDataDic;

@end

@implementation InvestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"投资";
    self.view.backgroundColor = kBackgroundColor;
    self.navigationItem.leftBarButtonItem = self.leftItem;
    
    [self.view addSubview:self.tableView1];
    
    if (self.investModel.pid == nil) {
        self.isPacket = @"";
    }else{
        self.isPacket = self.investModel.pid;
    }
    
    self.isTicket = @"1";
}

#pragma mark - init view
-(UITableView *)tableView1
{
    if (!_tableView1) {
        _tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
        _tableView1.delegate = self;
        _tableView1.dataSource = self;
        _tableView1.showsVerticalScrollIndicator = NO;
    }
    return _tableView1;
}
-(DetailsView *)topInvestView
{
    if (!_topInvestView) {
        _topInvestView = [[DetailsView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 170)];
        [_topInvestView.typeBtn1 setTitle:self.investModel.borrow_type forState:0];
        _topInvestView.nameLabel.text = self.investModel.borrow_name;
        _topInvestView.rateLabel1.text = @"年化率";
        _topInvestView.rateLabel2.text = self.investModel.borrow_interest_rate;
        _topInvestView.timeLabel1.text = @"借款时间";
        _topInvestView.timeLabel2.text = self.investModel.borrow_duration;
        _topInvestView.progressView.progress = [self.investModel.progress floatValue]*0.01;
        
        NSMutableAttributedString *leftAtt = [NSString getStringFromFirstString:@"已售" andFirstColor:kBlackColor andFirstFont:font12 ToSecondString:self.investModel.progress andSecondColor:kNavigationColor andSecondFont:font12];
        [_topInvestView.leftLabel setAttributedText:leftAtt];
        
        
        NSString *syMoneyStr = [NSString stringWithFormat:@"%@元",self.investModel.sy_money];
        NSMutableAttributedString *rightAtt = [NSString getStringFromFirstString:@"剩余总额" andFirstColor:kBlackColor andFirstFont:font12 ToSecondString:syMoneyStr andSecondColor:kNavigationColor andSecondFont:font12];
        [_topInvestView.rightLabel setAttributedText:rightAtt];
        
        NSString *borrowMinStr = [NSString stringWithFormat:@"%@元",self.investModel.borrow_min];
        NSMutableAttributedString *startAtt = [NSString getStringFromFirstString:@"起投金额" andFirstColor:kBlackColor andFirstFont:font12 ToSecondString:borrowMinStr andSecondColor:kNavigationColor andSecondFont:font12];
        [_topInvestView.startMomeyLabel setAttributedText:startAtt];
        
        _topInvestView.wayLabel.text = self.investModel.repayment_type;
    }
    return _topInvestView;
}

- (NSMutableDictionary *)investDataDic
{
    if (!_investDataDic) {
        _investDataDic = [NSMutableDictionary dictionary];
    }
    return _investDataDic;
}

#pragma mark - tableView delegate and dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 170;
    }
    
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier;
//    = @"all";
    if (indexPath.section == 0) {
        identifier = @"all0";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell addSubview:self.topInvestView];
        return cell;
    }else if (indexPath.section == 1){
        identifier = @"all1";
        InvestssCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[InvestssCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell.leftButton setTitle:@"投资金额" forState:0];
        cell.inTextField.placeholder = @"请输入投资金额(元)";
        [cell.inRightButton1 setTitle:@"充值" forState:0];
        [cell.inRightButton2 setTitle:@"全投" forState:0];
        
        ZXWeakSelf;
        [cell setDidEndEditting:^(NSString *text) {
            [weakself.investDataDic setValue:text forKey:@"money"];
        }];
        [cell.inRightButton1 addAction:^(UIButton *btn) {
            RechargeViewController *rechargeVC = [[RechargeViewController alloc] init];
            [weakself.navigationController pushViewController:rechargeVC animated:YES];
        }];
        
        [cell.inRightButton2 addAction:^(UIButton *btn) {
            if (weakself.investModel.all == nil) {
                weakself.secondView.moneyTextField.text = @"0.00";
            }else{
                weakself.secondView.moneyTextField.text = weakself.investModel.all;
            }
        }];
        
        return cell;
    }else if (indexPath.section == 2){
        identifier = @"all2";
        InvestsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[InvestsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell.coButton setTitle:@"居间协议" forState:0];
        [cell.coActButton setImage:[UIImage imageNamed:@"list_more"] forState:0];
        
        return cell;
    }
    
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.1;
    }
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 2) {
        return 100;
    }
    return 0.1;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 2) {
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, kScreenWidth, 100)];
        
        //同意上述协议
        UIButton *b1 = [UIButton newAutoLayoutView];
        [b1 setImage:[UIImage imageNamed:@"kuang"] forState:0];
        [b1 setImage:[UIImage imageNamed:@"yougou"] forState:UIControlStateSelected];
        [b1 setTitle:@"  同意上述协议" forState:0];
        [b1 setTitleColor:[UIColor lightGrayColor] forState:0];
        b1.titleLabel.font = [UIFont systemFontOfSize:12];
        [bottomView addSubview:b1];
        [b1 addAction:^(UIButton *btn) {
            btn.selected = !btn.selected;
        }];
        
        //投资
        UIButton *b2 = [UIButton newAutoLayoutView];
        [b2 setBackgroundColor:kNavigationColor];
        [b2 setTitleColor:[UIColor whiteColor] forState:0];
        b2.layer.cornerRadius = 2;
        [b2 setTitle:@"投资" forState:0];
        [bottomView addSubview:b2];
        ZXWeakSelf;
        [b2 addAction:^(UIButton *btn) {
            if (b1.selected) {
                [weakself requestDataOfInvestFinish];
            }else{
                [self showHint:@"需同意协议"];
            }
        }];
        
        [b1 autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [b1 autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:bottomView withOffset:10];
        
        [b2 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:b1 withOffset:10];
        [b2 autoAlignAxis:ALAxisVertical toSameAxisOfView:b1];
        [b2 autoSetDimensionsToSize:CGSizeMake(100, 40)];
        
        return bottomView;
    }
    
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {//居间协议
        IntermAgreementViewController *intermAgreementsVC = [[IntermAgreementViewController alloc] init];
        intermAgreementsVC.urlString = [NSString stringWithFormat:@"%@%@",ZXCF,self.investModel.url];
        intermAgreementsVC.titleString = @"居间协议";
        [self.navigationController pushViewController:intermAgreementsVC animated:YES];
    }
}

/*
#pragma mark - textField delegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.secondView.moneyTextField) {
        
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890."] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basic = [string isEqualToString:filtered];
        return basic;
    }
    return NO;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.codeTextField resignFirstResponder];    //主要是[receiver resignFirstResponder]在哪调用就能把receiver对应的键盘往下收
    [self.secondView.moneyTextField resignFirstResponder];

    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    UIWindow *keyWindow1 = [UIApplication sharedApplication].keyWindow;
    [keyWindow1 addGestureRecognizer:self.tapGesture];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.secondView.moneyTextField) {
        
        self.allMoneyTextField.text = [self getAllMoney];

    }
    
    UIWindow *keyWidow1 = [UIApplication sharedApplication].keyWindow;
    [keyWidow1 removeGestureRecognizer:self.tapGesture];
}
 

-(NSString *)getAllMoney
{
    float mon1 = [self.secondView.moneyTextField.text floatValue];
    float mon2 = [self.secondView.ticketBtn.titleLabel.text floatValue];
    float mon3 = [self.secondView.packetBtn.titleLabel.text floatValue];
    
    float mon = mon1 + mon2 + mon3;
    NSString *str = [NSString stringWithFormat:@"%.2f",mon];
    return str;
}

#pragma mark - alertView delelgate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag ==1000) {//投资券
        if (buttonIndex == 0) {
            //使用投资券
            [self.secondView.ticketBtn setTitle:@"不使用" forState:0];
            self.isTicket = @"0";
            
        }else{
            self.isTicket = @"1";
            self.allMoneyTextField.text = [self getAllMoney];
        }
    }else{//红包
        if (buttonIndex == 0) {
            //使用红包
            [self.secondView.packetBtn setTitle:@"不使用" forState:0];
            self.isPacket = @"";
        }else{
            self.isPacket = self.investModel.pid;
            self.allMoneyTextField.text = [self getAllMoney];
        }
    }
}

-(BOOL)isPureFloat:(NSString *)string
{
    NSScanner *scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
    
}
 */


#pragma mark - data request
//投资完成
-(void)requestDataOfInvestFinish
{
    [self.view endEditing:YES];
    NSString *investFinishString = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFinvestFinish];
    
    [self.investDataDic setValue:TOKEN forKey:@"token"];
    [self.investDataDic setValue:self.borrowID forKey:@"borrow_id"];
    [self.investDataDic setValue:@"0" forKey:@"is_tzq"];
    [self.investDataDic setValue:@"0" forKey:@"is_rid"];
    [self.investDataDic setValue:@"0" forKey:@"code"];
    [self.investDataDic setValue:@"1" forKey:@"is_phone"];
    
    
    NSDictionary *params = self.investDataDic;
    
    ZXWeakSelf;
    [self requestDataPostWithUrlString:investFinishString andParams:params andSuccessBlock:^(id responseObject){
        
        FinishInvestModel *finishInvestModel = [FinishInvestModel objectWithKeyValues:responseObject];
        
        [weakself showHint:finishInvestModel.info];
        
        if ([finishInvestModel.status intValue] == 1) {//投资成功
            FinishInvestViewController *finishInvestVC = [[FinishInvestViewController alloc] init];
            finishInvestVC.finishModel = finishInvestModel;
            [weakself.navigationController pushViewController:finishInvestVC animated:YES];
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
