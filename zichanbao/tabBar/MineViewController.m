//
//  MineViewController.m
//  zichanbao
//
//  Created by zhixiang on 15/10/9.
//  Copyright (c) 2015年 zhixiang. All rights reserved.
//

#import "MineViewController.h"
#import "AccountModel.h"  //我的账户Model
#import "CallPhoneModel.h"//客服电话Model

#import "LoginViewController.h"       //登录
#import "RegisterViewController.h"   //注册

#import "RechargeViewController.h"  //充值
#import "AddCardViewController.h"   //添加银行卡
#import "WithdraViewController.h"   //提现
#import "InteExchangeViewController.h"  //积分兑换
#import "MineReceiptAddressViewController.h"
#import "MyInvestViewController.h"  //我的投资
#import "MyOrderViewController.h"   //我的预约
#import "FundRecordViewController.h" //资金记录
#import "ChannelIntermediaryViewController.h"  //渠道中介
#import "OpenCreditViewController.h" //查询征信
#import "CreditListViewController.h"  //征信列表
#import "PlanViewController.h"       //回款计划，还款计划
#import "AuthentyViewController.h"  //认证管理－－尚未认证
#import "CompleteViewController.h"  //认证管理－－已认证
#import "MyShareViewController.h"   //我的分享码
#import "HelpCenterVViewController.h"  //帮助中心

#import "MyLoanViewController.h"  //我的借款

#import "MyFinancialView.h"
#import "MyBorrowView.h"
#import "CreditAlertView.h"

#import "UIImageView+WebCache.h"
#import "AuthentyModel.h"

@interface MineViewController ()

@property (nonatomic,strong) MyBorrowView *borrowView;//借款账户
@property (nonatomic,strong) MyFinancialView *financialView;//理财账户
@property (nonatomic,strong) CreditAlertView *creditAlertController; //征信查询1
@property (nonatomic,strong) CreditAlertView *creditAlertController2; //征信查询1


@property (nonatomic,assign) BOOL tagSwitch;

@end

@implementation MineViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    self.navigationController.navigationBarHidden = YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    
    AccountModel *model = [self checkMyAccount];
    
    if (TOKEN == nil ||model.status||[TOKEN isKindOfClass:[NSNull class]]) {//未登录
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        loginVC.hidesBottomBarWhenPushed = YES;
        loginVC.backString = @"1";
        UINavigationController *nasd = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:nasd animated:YES completion:nil];
    }else{
        [self refreshBorrowView:model];
        [self refreshFinancialView:model];
        
       [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getCregitor:) name:@"征信查询" object:nil];
    }
}

- (void)getCregitor:(NSNotification *)notification
{
    [self showChooseCreditor1];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.financialView];
    [self.view addSubview:self.borrowView];
    [self.borrowView setHidden:YES];
    
}

-(MyBorrowView *)borrowView
{
    if (!_borrowView) {
        _borrowView = [[MyBorrowView alloc] initWithFrame:self.financialView.frame];//CGRectMake(0, 0, kScreenWidth,self.view.height)];
        
        ZXWeakSelf;
        //点击事件
        [_borrowView setBtnClickAction:^(NSNumber *number) {
            if (number.intValue) {
//                [weakself.view addSubview:weakself.financialView];
//                [weakself.borrowView removeFromSuperview];
                
                [weakself.financialView setHidden:NO];
                [weakself.borrowView setHidden:YES];

            }
        }];
        
        [_borrowView setDidSelectedRow:^(NSInteger row) {
            switch (row) {
                case 0:{
                    //我的借款
                    MyLoanViewController *myLoanVC = [[MyLoanViewController alloc] init];
                    myLoanVC.hidesBottomBarWhenPushed = YES;
                    [weakself.navigationController pushViewController:myLoanVC animated:YES];
                }
                    break;
                case 1:{
                    //资金记录
                    FundRecordViewController *fundRecordVC = [[FundRecordViewController alloc] init];
                    fundRecordVC.hidesBottomBarWhenPushed = YES;
                    [weakself.navigationController pushViewController:fundRecordVC animated:YES];
                }
                    break;
                case 2:{
                    //还款计划
                    PlanViewController *planVC = [[PlanViewController alloc] init];
                    planVC.hidesBottomBarWhenPushed = YES;
                    planVC.planType = @"2";
                    [weakself.navigationController pushViewController:planVC animated:YES];
                }
                    break;
                case 3:{
                    //认证管理
                    [weakself requestDataOfIsAuthenty];
                }
                    break;
                case 4:{
                    //客服电话
                    [weakself requestDataOfCallPhone];
                }
                    
                    break;
                    //                case 5:{//帮助中心
                    //
                    //                    HelpCenterVViewController *helpCenterVC = [[HelpCenterVViewController alloc] init];
                    //                    helpCenterVC.hidesBottomBarWhenPushed = YES;
                    //                    [weakself.navigationController pushViewController:helpCenterVC animated:YES];
                    //                }
                    //                    break;
                case 5:{
                    [weakself loginOut];
                }
                    
                    break;
                default:
                    break;
            }
            
        }];
        
    }
    return _borrowView;
}

-(MyFinancialView *)financialView
{
    if (!_financialView) {
        _financialView = [[MyFinancialView alloc] initWithFrame:CGRectMake(0,10, kScreenWidth, kScreenHeight-20-49)];
        
        ZXWeakSelf;
        [_financialView setBtnClickAction:^(NSNumber *number) {//0-充值 1-提现 2-余额账户 3-账户切换
            switch (number.intValue){
                case 0:{
                    RechargeViewController *rechargeVC = [[RechargeViewController alloc] init];
                    rechargeVC.hidesBottomBarWhenPushed = YES;
                    //                rechargeVC.bankCardDic = dic;
                    [weakself.navigationController pushViewController:rechargeVC animated:YES];
                }
                    break;
                case 1:{
                    WithdraViewController *withdraVC = [[WithdraViewController alloc] init];
                    withdraVC.hidesBottomBarWhenPushed = YES;
                    //                withdraVC.bankDic = dic;
                    [weakself.navigationController pushViewController:withdraVC animated:YES];
                }
                    break;
                case 2:
                    //                {
                    //                    RedPacketViewController *redPacketVC = [[RedPacketViewController alloc] init];
                    //                    redPacketVC.hidesBottomBarWhenPushed = YES;
                    //                    [weakself.navigationController pushViewController:redPacketVC animated:YES];
                    //                }
                    break;
                case 3:{
                    [weakself.borrowView setHidden:NO];
                    [weakself.financialView setHidden:YES];

                }
                    break;
                    
                default:
                    break;
            }
        }];
        
        [_financialView setDidSelectedRow:^(NSIndexPath *indexPath) {
            switch (indexPath.row) {
                case 0://我的投资
                {
                    MyInvestViewController *myInvestVC = [[MyInvestViewController alloc] init];
                    myInvestVC.hidesBottomBarWhenPushed = YES;
                    [weakself.navigationController pushViewController:myInvestVC animated:YES];
                }
                    break;
                case 1:{//我的预约
                    MyOrderViewController *myOrderVC = [[MyOrderViewController alloc] init];
                    myOrderVC.hidesBottomBarWhenPushed = YES;
                    [weakself.navigationController pushViewController:myOrderVC animated:YES];
                }
                    break;
                case 2:{ //资金记录
                    FundRecordViewController *fundRecordVC = [[FundRecordViewController alloc] init];
                    fundRecordVC.hidesBottomBarWhenPushed = YES;
                    [weakself.navigationController pushViewController:fundRecordVC animated:YES];
                }
                    break;
                case 3:{//渠道中介
                    ChannelIntermediaryViewController *channelIntermediaryVC = [[ChannelIntermediaryViewController alloc] init];
                    channelIntermediaryVC.hidesBottomBarWhenPushed = YES;
                    [weakself.navigationController pushViewController:channelIntermediaryVC animated:YES];
                }
                    break;
                case 4:{
                    [weakself showChooseCreditor1];
                    }
                    break;
                case 5:{//回款计划
                    PlanViewController *planVC = [[PlanViewController alloc] init];
                    planVC.hidesBottomBarWhenPushed = YES;
                    planVC.planType = @"1";
                    [weakself.navigationController pushViewController:planVC animated:YES];
                }
                    break;
                case 6:{
                    //积分管理
                    InteExchangeViewController *inteExchangeVC = [[InteExchangeViewController alloc] init];
                    inteExchangeVC.hidesBottomBarWhenPushed = YES;
                    [weakself.navigationController pushViewController:inteExchangeVC animated:YES];
                }
                    break;
                case 7:{//认证管理
                    [weakself requestDataOfIsAuthenty];
                }
                    break;
                case 8:{//我的分享码
                    MyShareViewController *shareVC = [[MyShareViewController alloc] init];
                    shareVC.hidesBottomBarWhenPushed = YES;
                    [weakself.navigationController pushViewController:shareVC animated:YES];
                }
                    break;
                case 9:{//客服电话
                    [weakself requestDataOfCallPhone];
                }
                    break;
                case 10:{//退出登录
                    [weakself loginOut];
                }
                    break;
                default:
                    break;
            }
        }];
    }
    return _financialView;
}

- (CreditAlertView *)creditAlertController
{
    if (!_creditAlertController) {
        _creditAlertController  = [CreditAlertView newAutoLayoutView];
        _creditAlertController.backgroundColor = kAlphaBackColor;
        [_creditAlertController.titleButton setTitle:@"征信选择" forState:0];
        _creditAlertController.titleButton.backgroundColor = kWhiteColor;
//        _creditAlertController.actButton1.backgroundColor = kWhiteColor;
        [_creditAlertController.actButton1 setImage:[UIImage imageNamed:@"kaiqinide"] forState:0];
//        _creditAlertController.actButton2.backgroundColor = kWhiteColor;
        [_creditAlertController.actButton2 setImage:[UIImage imageNamed:@"chakanzhengxin"] forState:0];
        
        ZXWeakSelf;
        [_creditAlertController setDidSelectedBtn:^(NSInteger tag) {
            [weakself.creditAlertController removeFromSuperview];
            switch (tag) {
                case 88:
//                    [weakself.creditAlertController removeFromSuperview];
                    break;
                case 89:{
                    [weakself showChooseCreditor2];
                }
                    break;
                case 90:{
                    CreditListViewController  *creditListVC = [[CreditListViewController alloc] init];
                    creditListVC.hidesBottomBarWhenPushed = YES;
                    [weakself.navigationController pushViewController:creditListVC animated:YES];
                }
                    break;
                default:
                    break;
            }
        }];
    }
    return _creditAlertController;
}

- (CreditAlertView *)creditAlertController2
{
    if (!_creditAlertController2) {
        _creditAlertController2  = [CreditAlertView newAutoLayoutView];
        _creditAlertController2.backgroundColor = kAlphaBackColor;
        [_creditAlertController2.titleButton setTitle:@"开始你的征信之旅" forState:0];
        _creditAlertController2.titleButton.backgroundColor = kWhiteColor;
//        _creditAlertController2.actButton1.backgroundColor = kWhiteColor;
        [_creditAlertController2.actButton1 setImage:[UIImage imageNamed:@"hulianwang"] forState:0];
//        _creditAlertController2.actButton2.backgroundColor = kWhiteColor;
        [_creditAlertController2.actButton2 setImage:[UIImage imageNamed:@"yanghang"] forState:0];
//        _creditAlertController2.actButton3.backgroundColor = kWhiteColor;
        [_creditAlertController2.actButton3 setImage:[UIImage imageNamed:@"quantao"] forState:0];
        
        ZXWeakSelf;
        [_creditAlertController2 setDidSelectedBtn:^(NSInteger tag) {
            [weakself.creditAlertController2 removeFromSuperview];
            switch (tag) {
                case 88:
                    [weakself showChooseCreditor1];
                    break;
                case 89:{
                    OpenCreditViewController *openCreditVC = [[OpenCreditViewController alloc] init];
                    openCreditVC.hidesBottomBarWhenPushed = YES;
                    [weakself.navigationController pushViewController:openCreditVC animated:YES];
                }
                    break;
                case 90:{
                    OpenCreditViewController *openCreditVC = [[OpenCreditViewController alloc] init];
                    openCreditVC.hidesBottomBarWhenPushed = YES;
                    [weakself.navigationController pushViewController:openCreditVC animated:YES];
                }
                    break;
                case 91:{
                    OpenCreditViewController *openCreditVC = [[OpenCreditViewController alloc] init];
                    openCreditVC.hidesBottomBarWhenPushed = YES;
                    [weakself.navigationController pushViewController:openCreditVC animated:YES];
                }
                    break;
                default:
                    break;
            }
        }];
    }
    return _creditAlertController2;
}

#pragma mark - request data
- (void)loginOut
{
    UIAlertController *loginOutAlert = [UIAlertController alertControllerWithTitle:nil message:@"确认退出？" preferredStyle:UIAlertControllerStyleAlert];
    
    ZXWeakSelf;
    UIAlertAction *act0 = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //退出登录
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        loginVC.hidesBottomBarWhenPushed = YES;
        loginVC.backString = @"1";
        UINavigationController *nsb = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [weakself presentViewController:nsb animated:YES completion:nil];
    }];
    
    UIAlertAction *act1 = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:nil];
    [loginOutAlert addAction:act0];
    [loginOutAlert addAction:act1];
    
    [self presentViewController:loginOutAlert animated:YES completion:nil];
}

-(void)refreshFinancialView:(AccountModel *)accountModel
{
    //显示信息
    NSString *title1 = @"可用余额：";
    NSString *title2 = [NSString stringWithFormat:@"%@元",accountModel.now_money];
    //    NSString *title3 = @"红包：";
    //    NSString *title4 = [NSString stringWithFormat:@"%@元",accountModel.packets_moneys];
    NSString *title = [NSString stringWithFormat:@"%@%@",title1,title2];
    
    //设置汉字为灰色，设置数字为紫色
    NSMutableAttributedString *retainAttributeString = [[NSMutableAttributedString alloc] initWithString:title];
    [retainAttributeString addAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} range:NSMakeRange(0,title1.length)];
    [retainAttributeString addAttributes:@{NSForegroundColorAttributeName:kNavigationColor} range:NSMakeRange(title1.length,title2.length)];
    [self.financialView.fMoneyView.retainBtn setAttributedTitle:retainAttributeString forState:0];
    
    self.financialView.fMoneyView.moneyLabel1.text = [NSString stringWithFormat:@"%@元",accountModel.total];
    self.financialView.fMoneyView.moneyLabel2.text = [NSString stringWithFormat:@"待收收益\n%@元",accountModel.dslx];
    self.financialView.fMoneyView.moneyLabel3.text = [NSString stringWithFormat:@"累计收益\n%@元",accountModel.ljlx];
    self.financialView.fMoneyView.moneyLabel4.text = [NSString stringWithFormat:@"待收本金\n%@元",accountModel.dsbj];
    self.financialView.fMoneyView.moneyLabel5.text = [NSString stringWithFormat:@"冻结本金\n%@元",accountModel.money_freeze];
}

-(void)refreshBorrowView:(AccountModel *)accountModel
{
    //显示信息
    NSString *title1 = @"当前借款笔数：";
    NSString *title2 = @"累计借款笔数：";
//    NSString *title3 = @"累计利息：";
    NSString *s1 = accountModel.now_borrow_count;
    NSString *s2 = accountModel.borrow_count;
//    NSString *s3 = accountModel.ljlx;
    
    NSString *string1 = [NSString stringWithFormat:@"%@%@笔",title1,s1];
    NSString *string2 = [NSString stringWithFormat:@"%@%@笔",title2,s2];
//    NSString *string3 = [NSString stringWithFormat:@"%@%@元",title3,s3];
    NSString *string = [NSString stringWithFormat:@"%@\n%@",string1,string2];
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:string];
    [attributeString addAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} range:NSMakeRange(0, 7)];
    [attributeString addAttributes:@{NSForegroundColorAttributeName:kNavigationColor} range:NSMakeRange(7, s1.length)];
    [attributeString addAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} range:NSMakeRange(7+s1.length, 2+7)];
    [attributeString addAttributes:@{NSForegroundColorAttributeName:kNavigationColor} range:NSMakeRange(7+s1.length+2+7, s2.length)];
    [attributeString addAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} range:NSMakeRange(7+s1.length+2+7+s2.length, 1)];
//    [attributeString addAttributes:@{NSForegroundColorAttributeName:kNavigationColor} range:NSMakeRange(7+s1.length+2+7+s2.length+2+5, s3.length)];
//    [attributeString addAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} range:NSMakeRange(string.length-1, 1)];
    [self.borrowView.bMoneyView.retainBtn setAttributedTitle:attributeString forState:0];
    
    self.borrowView.bMoneyView.moneyLabel1.text = [NSString stringWithFormat:@"%@元",accountModel.borrow_money];
    self.borrowView.bMoneyView.moneyLabel2.text = [NSString stringWithFormat:@"待还本金\n%@元",accountModel.nreceive_capital];
    self.borrowView.bMoneyView.moneyLabel3.text = [NSString stringWithFormat:@"待还利息\n%@元",accountModel.nreceive_interest];
    self.borrowView.bMoneyView.moneyLabel4.text = [NSString stringWithFormat:@"已还本金\n%@元",accountModel.receive_capital];
    self.borrowView.bMoneyView.moneyLabel5.text = [NSString stringWithFormat:@"已还利息\n%@元",accountModel.receive_interest];
}

//判断是否绑定银行卡
-(void)requestDataOfBindingCard:(NSString *)string
{
    NSString *bankCardString = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFbindingBankCard];
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYYMMddhhmmss"];
    NSString *locationString=[dateformatter stringFromDate:senddate];
    NSDictionary *params = @{
                             @"token" : TOKEN,
                             @"sb"    :locationString
                             };
    
    ZXWeakSelf;
    [self requestDataGetWithUrlString:bankCardString paramter:params SucceccBlock:^(id responseObject){
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        if (([dic[@"status"] intValue] == 0)&&[dic[@"info"] isEqualToString:@"登录过期，请重新登录"]) {
            
            [weakself showHint:dic[@"info"]];
            
        } else {
            if ([string intValue] == 0) {//充值
                RechargeViewController *rechargeVC = [[RechargeViewController alloc] init];
                rechargeVC.hidesBottomBarWhenPushed = YES;
//                rechargeVC.bankCardDic = dic;
                [weakself.navigationController pushViewController:rechargeVC animated:YES];
            }else{//提现
                WithdraViewController *withdraVC = [[WithdraViewController alloc] init];
                withdraVC.hidesBottomBarWhenPushed = YES;
//                withdraVC.bankDic = dic;
                [weakself.navigationController pushViewController:withdraVC animated:YES];
            }
        }
        
    } andFailedBlock:^{
        
    }];
}

//判断是否认证过
-(void)requestDataOfIsAuthenty
{
    NSString *authentyString = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFifAuthenty];
    NSDictionary *param = @{
                            @"token" : TOKEN
                            };
    
    ZXWeakSelf;
    [self requestDataGetWithUrlString:authentyString paramter:param SucceccBlock:^(id responseObject){
        AuthentyModel *authentyModel = [AuthentyModel objectWithKeyValues:responseObject];
        
        if ([authentyModel.status integerValue] == -1) {//未认证
            [weakself showHint:authentyModel.info];
            AuthentyViewController *authentyVC = [[AuthentyViewController alloc] init];
            authentyVC.hidesBottomBarWhenPushed = YES;
            [weakself.navigationController pushViewController:authentyVC animated:YES];
        }else if([authentyModel.status integerValue] == 0){//登录过期
            [weakself showHint:authentyModel.info];
        }else{//认证完成
            CompleteViewController *completeVC = [[CompleteViewController alloc] init];
            completeVC.completeModel = authentyModel;
            completeVC.hidesBottomBarWhenPushed = YES;
            [weakself.navigationController pushViewController:completeVC animated:YES];
        }
        
    } andFailedBlock:^{
        
    }];
}

//客服电话
-(void)requestDataOfCallPhone
{
    NSString *callPhoneStr = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFcallPhone];
    NSDictionary *param = @{
                            @"token" : TOKEN
                            };
    
    ZXWeakSelf;
    [self requestDataGetWithUrlString:callPhoneStr paramter:param SucceccBlock:^(id responseObject){
        CallPhoneModel *callPhoneModel = [CallPhoneModel objectWithKeyValues:responseObject];
        if ([callPhoneModel.status intValue] == 1) {//成功
            NSMutableString *phoneStr = [NSMutableString stringWithFormat:@"telprompt://%@",callPhoneModel.tel];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneStr]];
        }else{
            [weakself showHint:callPhoneModel.info];
        }
        
    } andFailedBlock:^{
        
    }];
}

#pragma mark - method
- (void)showChooseCreditor1
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self.creditAlertController];
    
    [self.creditAlertController autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    
//    CreditAlertView *creditAlertController = [CreditAlertView newAutoLayoutView];
    
//    UIAlertController *creditAlertController = [UIAlertController alertControllerWithTitle:nil message:@"征信选择" preferredStyle:UIAlertControllerStyleAlert];
//    
//    ZXWeakSelf;
//    UIAlertAction *creitAct0 = [UIAlertAction actionWithTitle:@"开始你的征信之旅" style:0 handler:^(UIAlertAction * _Nonnull action) {
//        [weakself showChooseCreditor2];
//    }];
//    UIAlertAction *creitAct1 = [UIAlertAction actionWithTitle:@"查看征信" style:0 handler:^(UIAlertAction * _Nonnull action) {
//        CreditListViewController  *creditListVC = [[CreditListViewController alloc] init];
//        creditListVC.hidesBottomBarWhenPushed = YES;
//        [weakself.navigationController pushViewController:creditListVC animated:YES];
//    }];
//    UIAlertAction *creitAct2 = [UIAlertAction actionWithTitle:@"取消" style:0 handler:nil];
//    [creditAlertController addAction:creitAct0];
//    [creditAlertController addAction:creitAct1];
//    [creditAlertController addAction:creitAct2];
//    [self presentViewController:creditAlertController animated:YES completion:nil];
}

- (void)showChooseCreditor2
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self.creditAlertController2];
    
    [self.creditAlertController2 autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    
//    UIAlertController *openCreditAlertController = [UIAlertController alertControllerWithTitle:nil message:@"征信选择" preferredStyle:UIAlertControllerStyleAlert];
//    
//    ZXWeakSelf;
//    UIAlertAction *openCreditAct0 = [UIAlertAction actionWithTitle:@"互联网征信" style:0 handler:^(UIAlertAction * _Nonnull action) {
//        OpenCreditViewController *openCreditVC = [[OpenCreditViewController alloc] init];
//        openCreditVC.hidesBottomBarWhenPushed = YES;
//        [weakself.navigationController pushViewController:openCreditVC animated:YES];
//    }];
//    UIAlertAction *openCreditAct1 = [UIAlertAction actionWithTitle:@"央行征信" style:0 handler:^(UIAlertAction * _Nonnull action) {
//        OpenCreditViewController *openCreditVC = [[OpenCreditViewController alloc] init];
//        openCreditVC.hidesBottomBarWhenPushed = YES;
//        [weakself.navigationController pushViewController:openCreditVC animated:YES];
//    }];
//    UIAlertAction *openCreditAct2 = [UIAlertAction actionWithTitle:@"全套征信" style:0 handler:^(UIAlertAction * _Nonnull action) {
//        OpenCreditViewController *openCreditVC = [[OpenCreditViewController alloc] init];
//        openCreditVC.hidesBottomBarWhenPushed = YES;
//        [weakself.navigationController pushViewController:openCreditVC animated:YES];
//    }];
//    UIAlertAction *openCreditAct3 = [UIAlertAction actionWithTitle:@"取消" style:0 handler:^(UIAlertAction * _Nonnull action) {
//        [weakself showChooseCreditor1];
//    }];
//
//    [openCreditAlertController addAction:openCreditAct0];
//    [openCreditAlertController addAction:openCreditAct1];
//    [openCreditAlertController addAction:openCreditAct2];
//    [openCreditAlertController addAction:openCreditAct3];
//    [self presentViewController:openCreditAlertController animated:YES completion:nil];
}

@end
