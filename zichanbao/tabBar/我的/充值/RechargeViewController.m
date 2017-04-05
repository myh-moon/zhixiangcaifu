//
//  RechargeViewController.m
//  zichanbao
//
//  Created by zhixiang on 15/10/14.
//  Copyright (c) 2015年 zhixiang. All rights reserved.
//

#import "RechargeViewController.h"
#import "AddCardViewController.h"  //添加银行卡
#import "RechargeFinishViewController.h"  //充值完成
#import "JKCountDownButton.h"
#import "UIImageView+WebCache.h"

#import "BaseModel.h"
#import "RechargeModel.h"


@interface RechargeViewController ()<UIAlertViewDelegate,UITextFieldDelegate>

@property (nonatomic,strong) UIView *secondView;

@property (nonatomic,strong) UIView *addView;  //添加银行卡
@property (nonatomic,strong) UIView *bankCardView;
@property (nonatomic,strong) UILabel *cashLabel;  //现金余额
@property (nonatomic,strong) UIView *whiteView;
@property (nonatomic,strong) UILabel *moneyLabel;   //充值金额
@property (nonatomic,strong) UITextField *moneyTextField;  //具体充值金额
@property (nonatomic,strong) UILabel *codeLabel;   //输入验证码
@property (nonatomic,strong) UITextField *codeTextFiled;  //具体验证码
@property (nonatomic,strong) JKCountDownButton *getCodeBtn;   //获取
@property (nonatomic,strong) UIButton *rechargeBtn;   //充值

@property (nonatomic,strong) NSMutableDictionary *rechargeDic;//提交数据
@property (nonatomic,strong) NSDictionary *resultDataDic; //返回数据银行卡信息

@end

@implementation RechargeViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
    [self requestDataOfBindingCard];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账户充值";
    self.view.backgroundColor = kBackgroundColor;
    self.navigationItem.leftBarButtonItem = self.leftItem;
}


#pragma mark - init view
//-(UIButton *)addBtn
//{
//    if (!_addBtn) {
//        _addBtn  = [UIButton buttonWithType:0];
//        _addBtn.frame = CGRectMake(0,10, kScreenWidth, 40);
//        [_addBtn setTitle:@"➕添加银行卡" forState:0];
//        [_addBtn setTitleColor:[UIColor blackColor] forState:0];
//        [_addBtn setBackgroundColor:[UIColor whiteColor]];
//        
//        ZXWeakSelf;
//        [_addBtn addAction:^(UIButton *btn) {
//            //验证是否认证
//            AddCardViewController *addCardVC = [[AddCardViewController alloc] init];
//            addCardVC.bankListDic = weakself.self.resultDataDic[@"bank"];
//            addCardVC.authentyDic = weakself.self.resultDataDic[@"infoes"];
//            addCardVC.whickView = @"0";
//            [weakself.navigationController pushViewController:addCardVC animated:YES];
//        }];
//    }
//    return _addBtn;
//}

- (UIView *)addView
{
    if (!_addView) {
        _addView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 400)];
        _addView.backgroundColor = kBackgroundColor;
        
        //imageview
        UIButton *anotherButton1 = [UIButton newAutoLayoutView];
        [anotherButton1 setBackgroundColor:kNavigationColor];
        [anotherButton1 setImage:[UIImage imageNamed:@"tainjiayinhangka"] forState:0];
        [_addView addSubview:anotherButton1];
        
        ZXWeakSelf;
        [anotherButton1 addAction:^(UIButton *btn) {
            AddCardViewController *addCardVC = [[AddCardViewController alloc] init];
            addCardVC.bankListDic = weakself.resultDataDic[@"bank"];
            [weakself.navigationController pushViewController:addCardVC animated:YES];
        }];
        
        //余额
        UILabel *anotherLabel = [UILabel newAutoLayoutView];
        [_addView addSubview:anotherLabel];
        NSString *monStr1 = @"余额：";
        NSString *monStr2 = [NSString stringWithFormat:@"%@元",self.resultDataDic[@"account_money"]];
        NSString *monStr = [NSString stringWithFormat:@"%@%@",monStr1,monStr2];
        NSMutableAttributedString *attributeMonStr = [[NSMutableAttributedString alloc] initWithString:monStr];
        [attributeMonStr setAttributes:@{NSForegroundColorAttributeName:kBlackColor} range:NSMakeRange(0, monStr1.length)];
        [attributeMonStr setAttributes:@{NSForegroundColorAttributeName:kNavigationColor} range:NSMakeRange(monStr1.length, monStr2.length)];
        [anotherLabel setAttributedText:attributeMonStr];
        
        //添加银行卡
        UIButton *anotherButton2 = [UIButton newAutoLayoutView];
        [anotherButton2 setTitle:@"充值请先添加银行卡" forState:0];
        [anotherButton2 setTitleColor:kNavigationColor forState:0];
        [_addView addSubview:anotherButton2];
        [anotherButton2 addAction:^(UIButton *btn) {
            AddCardViewController *addCardVC = [[AddCardViewController alloc] init];
            addCardVC.bankListDic = weakself.resultDataDic[@"bank"];
            [weakself.navigationController pushViewController:addCardVC animated:YES];
        }];
        
        [anotherButton1 autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
        [anotherButton1 autoSetDimension:ALDimensionHeight toSize:230];
        
        [anotherLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:kSpacePadding];
        [anotherLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:anotherButton1 withOffset:kSpacePadding];
        
        [anotherButton2 autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [anotherButton2 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:anotherLabel withOffset:kSpacePadding];
    }
    return _addView;
}

-(UIView *)secondView
{
    if (!_secondView) {
        _secondView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 400)];
        
        [_secondView addSubview:self.bankCardView];
        [_secondView addSubview:self.cashLabel];
        [_secondView addSubview:self.whiteView];
        [_secondView addSubview:self.codeLabel];
        [_secondView addSubview:self.codeTextFiled];
        [_secondView addSubview:self.getCodeBtn];
        [_secondView addSubview:self.rechargeBtn];
    }
    return _secondView;
}

-(UIView *)bankCardView
{
    if (!_bankCardView) {
        //已绑定银行卡,显示银行卡信息
        _bankCardView = [UIButton buttonWithType:0];
        _bankCardView.frame = CGRectMake(0, 10, kScreenWidth, 70);
        _bankCardView.backgroundColor = [UIColor whiteColor];
        
        //图标
        NSString *imageString = self.self.resultDataDic[@"xe"][0];
        UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 30, 30)];
        [iconImageView sd_setImageWithURL:[NSURL URLWithString:imageString] placeholderImage:[UIImage imageNamed:@"elephant"]];
        [_bankCardView addSubview:iconImageView];
        
        //银行名称
        UILabel *nameBankLabel = [[UILabel alloc] initWithFrame:CGRectMake(iconImageView.right+20, 5, kScreenWidth-(20*2+iconImageView.width+10), 20)];
        nameBankLabel.text = [self.self.resultDataDic[@"bank"][@"name"] substringToIndex:4];
        [_bankCardView addSubview:nameBankLabel];
        
        //银行尾号
        UILabel *numBankLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameBankLabel.left, nameBankLabel.bottom, nameBankLabel.width, 20)];
        NSString *endString1 = [self.self.resultDataDic[@"bank"][@"name"] substringFromIndex:4];
        NSString *endString2 = [self.self.resultDataDic[@"xe"][1] substringWithRange:NSMakeRange(5, 3)];
        
        numBankLabel.text = [NSString stringWithFormat:@"尾号%@  %@",endString1,endString2];
        numBankLabel.font = font14;
        numBankLabel.textColor = [UIColor lightGrayColor];
        numBankLabel.font = [UIFont systemFontOfSize:12];
        [_bankCardView addSubview:numBankLabel];
        
        //金额限制
        UILabel *limitBankLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameBankLabel.left, numBankLabel.bottom, nameBankLabel.width, 20)];
        limitBankLabel.text = [NSString stringWithFormat:@"单笔充值限额：%@元，日累计限额：%@元",self.self.resultDataDic[@"xe"][2],self.self.resultDataDic[@"xe"][3]];
        limitBankLabel.font = [UIFont systemFontOfSize:12];
        limitBankLabel.textColor = [UIColor lightGrayColor];
        [_bankCardView addSubview:limitBankLabel];
    }
    return _bankCardView;
}
-(UILabel *)cashLabel
{
    if (!_cashLabel) {
        _cashLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,self.bankCardView.bottom+10, kScreenWidth, 60)];
        NSString *cashS = [NSString stringWithFormat:@"%@元",self.self.resultDataDic[@"account_money"]];
        NSString *cashString = [NSString stringWithFormat:@"现金余额  %@",cashS];
        NSMutableAttributedString *cashAttributeString = [[NSMutableAttributedString alloc] initWithString:cashString];
        [cashAttributeString addAttributes:@{NSFontAttributeName:font14,NSForegroundColorAttributeName:kNavigationColor} range:NSMakeRange(6,cashS.length)];
        [cashAttributeString addAttributes:@{NSFontAttributeName:font14,NSForegroundColorAttributeName:[UIColor blackColor]} range:NSMakeRange(0, 4)];
        [_cashLabel setAttributedText:cashAttributeString];
    }
    return _cashLabel;
}

-(UIView *)whiteView
{
    if (!_whiteView) {
        
        _whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, self.cashLabel.bottom, kScreenWidth, 50)];
        _whiteView.backgroundColor = [UIColor whiteColor];
        [_whiteView addSubview:self.moneyLabel];
        [_whiteView addSubview:self.moneyTextField];
    }
    return _whiteView;
}

-(UILabel *)moneyLabel
{
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 30)];
        _moneyLabel.text = @"充值金额";
        _moneyLabel.font = font14;
        _moneyLabel.textColor = [UIColor blackColor];
    }
    return _moneyLabel;
}

-(UITextField *)moneyTextField
{
    if (!_moneyTextField) {
        _moneyTextField = [[UITextField alloc] initWithFrame:CGRectMake(self.moneyLabel.right, self.moneyLabel.top, 200, 30)];
        _moneyTextField.placeholder = @"至少100元";
        _moneyTextField.font = font14;
        _moneyTextField.keyboardType = UIKeyboardTypeNumberPad;
        _moneyTextField.delegate = self;
        _moneyTextField.tag = 11;
    }
    return _moneyTextField;
}

-(UILabel *)codeLabel
{
    if (!_codeLabel) {
        _codeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.whiteView.bottom+20, 90, 30)];
        _codeLabel.text = @"输入验证码";
        _codeLabel.font = font14;
        _codeLabel.textColor = [UIColor blackColor];
        
    }
    return _codeLabel;
}

-(UITextField *)codeTextFiled
{
    if (!_codeTextFiled) {
        _codeTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(self.codeLabel.right, self.codeLabel.top, kScreenWidth-10*2-15-self.codeLabel.width-self.getCodeBtn.width, self.codeLabel.height)];
        _codeTextFiled.placeholder = @"输入验证码";
        _codeTextFiled.font = font14;
        _codeTextFiled.layer.borderWidth = 1;
        _codeTextFiled.layer.borderColor = [UIColor grayColor].CGColor;
        _codeTextFiled.layer.cornerRadius = 5;
        _codeTextFiled.backgroundColor = [UIColor whiteColor];
        _codeTextFiled.keyboardType = UIKeyboardTypeNumberPad;
        _codeTextFiled.tag = 12;
        _codeTextFiled.delegate = self;
    }
    return _codeTextFiled;
}

-(JKCountDownButton *)getCodeBtn
{
    if (!_getCodeBtn) {
        _getCodeBtn = [JKCountDownButton buttonWithType:0];
        _getCodeBtn.frame = CGRectMake(kScreenWidth-80-10, self.codeLabel.top, 80, 30);
        _getCodeBtn.backgroundColor = [UIColor whiteColor];
        [_getCodeBtn setTitle:@"获取" forState:0];
        [_getCodeBtn setTitleColor:[UIColor blackColor] forState:0];
        _getCodeBtn.layer.borderColor = [UIColor grayColor].CGColor;
        _getCodeBtn.layer.borderWidth = 1;
        _getCodeBtn.layer.cornerRadius = 5;
        _getCodeBtn.titleLabel.font = font14;
        [_getCodeBtn addTarget:self action:@selector(getPhoneCodeRecharge:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _getCodeBtn;
}

-(UIButton *)rechargeBtn
{
    if (!_rechargeBtn) {
        _rechargeBtn = [UIButton buttonWithType:0];
        _rechargeBtn.frame = CGRectMake((kScreenWidth-200)/2, self.codeLabel.bottom+30, 200, 40);
        [_rechargeBtn setBackgroundColor:kNavigationColor];
        [_rechargeBtn setTitle:@"充值" forState:0];
        [_rechargeBtn setTitleColor:[UIColor whiteColor] forState:0];
        _rechargeBtn.layer.cornerRadius = 20;
       
        ZXWeakSelf;
        [_rechargeBtn addAction:^(UIButton *btn) {
            [weakself requestDataOfRechargeFinish];
        }];
        
    }
    return _rechargeBtn;
}

- (NSMutableDictionary *)rechargeDic
{
    if (!_rechargeDic) {
        _rechargeDic = [NSMutableDictionary dictionary];
    }
    return _rechargeDic;
}

#pragma mark - textfiled delegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 11) {
        [self.rechargeDic setValue:textField.text forKey:@"t_money"];
    }else if (textField.tag == 12){
        [self.rechargeDic setValue:textField.text forKey:@"code"];
    }
}
#pragma mark - request
//判断是否绑定银行卡
-(void)requestDataOfBindingCard
{
    NSString *bankCardString = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFbindingBankCard];
    
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYYMMddhhmmss"];
    NSString *locationString=[dateformatter stringFromDate:senddate];
    
    NSDictionary *params = @{
                             @"token" : TOKEN,
                             @"sb"    : locationString
                             };
    ZXWeakSelf;
    [self requestDataGetWithUrlString:bankCardString paramter:params SucceccBlock:^(id responseObject){
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        weakself.resultDataDic = dic;

        if (([dic[@"status"] intValue] == 0)||[dic[@"info"] isEqualToString:@"登录过期，请重新登录"]) {
            [weakself showHint:dic[@"info"]];
            [weakself.secondView removeFromSuperview];
            [weakself.view addSubview:self.addView];
            
        } else if ([dic[@"status"] intValue] == 1) {//已绑定
            [weakself.addView removeFromSuperview];
            [weakself.view addSubview:self.secondView];
            
            [weakself.rechargeDic setValue:dic[@"bank"][@"number"] forKey:@"number"];
            [weakself.rechargeDic setValue:TOKEN forKey:@"token"];
        }
    } andFailedBlock:^{
        
    }];
}

//获取验证码
-(void)getPhoneCodeRecharge:(JKCountDownButton *)sender
{
    [self.view endEditing:YES];
    NSString *rechargeCodeString = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFrechargeCode];
    NSDictionary *params = self.rechargeDic;
    
    ZXWeakSelf;
    [self requestDataPostWithUrlString:rechargeCodeString andParams:params andSuccessBlock:^(id responseObject){
        
         RechargeModel *recharModel = [RechargeModel objectWithKeyValues:responseObject];
        
        [weakself showHint:recharModel.info];
        
        if ([recharModel.status intValue] == 1) {
            //发送验证码成功
            [sender startWithSecond:60];
            [sender didChange:^NSString *(JKCountDownButton *countDownButton, int second) {
                sender.backgroundColor = [UIColor lightGrayColor];
                sender.enabled = NO;
                NSString *title = [NSString stringWithFormat:@"剩余%d秒",second];
                return title;
            }];
            [sender didFinished:^NSString *(JKCountDownButton *countDownButton, int second) {
                sender.backgroundColor = [UIColor whiteColor];
                countDownButton.enabled = YES;
                return @"获取";
            }];
            
            [weakself.rechargeDic setValue:recharModel.PaymentNo forKey:@"PaymentNo"];
            [weakself.rechargeDic setValue:recharModel.PaymentNo forKey:@"Paymoney"];
        }
        
    } andFailedBlock:^{
        
    }];
}
//确认充值
-(void)requestDataOfRechargeFinish
{
    [self.view endEditing:YES];
    NSString *rechargeFinishString = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFrechargeFinish];
    
    NSDictionary *params = self.rechargeDic;
    
    ZXWeakSelf;
    [self requestDataPostWithUrlString:rechargeFinishString andParams:params andSuccessBlock:^(id responseObject){
        
        BaseModel *finishModel = [BaseModel objectWithKeyValues:responseObject];
        
//        [weakself showHint:finishModel.info];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:weakself.navigationController.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = finishModel.info;
        [hud hide:YES afterDelay:5];
        
        if ([finishModel.status intValue] == 1) {//充值成功，跳转
            RechargeFinishViewController *rechargeFinishVC = [[RechargeFinishViewController alloc] init];
            rechargeFinishVC.moneyString = weakself.moneyTextField.text;
            [weakself.navigationController pushViewController:rechargeFinishVC animated:YES];
        }
        
    } andFailedBlock:^{
        
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
