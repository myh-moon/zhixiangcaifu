//
//  WithdraViewController.m
//  zichanbao
//
//  Created by zhixiang on 15/10/28.
//  Copyright (c) 2015年 zhixiang. All rights reserved.
//

#import "WithdraViewController.h"
#import "BasicButton.h"
#import "WithdraFinishViewController.h"  //提现完成
#import "AddCardViewController.h"   //添加银行卡

#import "WithdraCell.h"

@interface WithdraViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,assign) BOOL didSetupConstraint;
@property (nonatomic,strong) UITableView *withdraTableView;
@property (nonatomic,strong) UIView *anotherView;

@property (nonatomic,strong) NSMutableDictionary *withdraDic; //提交数据
@property (nonatomic,strong) NSDictionary *withDataDic;  //返回数据

@end

@implementation WithdraViewController
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
    [self requestDataOfBindingCard];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBackgroundColor;
    self.title = @"提现";
    self.navigationItem.leftBarButtonItem = self.leftItem;
}

- (void)updateViewConstraints
{
    if (!self.didSetupConstraint) {
        
        if ([self.withDataDic[@"status"] integerValue] == 0) {
            [self.anotherView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
        }else{
            [self.withdraTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
        }
        
        self.didSetupConstraint = YES;
    }
    [super updateViewConstraints];
}

#pragma mark - view getter
- (UITableView *)withdraTableView
{
    if (!_withdraTableView) {
        _withdraTableView = [UITableView newAutoLayoutView];
        _withdraTableView.backgroundColor = [UIColor whiteColor];
        _withdraTableView.delegate = self;
        _withdraTableView.dataSource = self;
        _withdraTableView.backgroundColor = kBackgroundColor;
        _withdraTableView.tableFooterView = [[UIView alloc] init];
    }
    return _withdraTableView;
}

- (UIView *)anotherView
{
    if (!_anotherView) {
        _anotherView = [UIView newAutoLayoutView];
        _anotherView.backgroundColor = kBackgroundColor;
        
        //imageview
        UIButton *anotherButton1 = [UIButton newAutoLayoutView];
        [anotherButton1 setBackgroundColor:kNavigationColor];
        [anotherButton1 setImage:[UIImage imageNamed:@"tainjiayinhangka"] forState:0];
        [_anotherView addSubview:anotherButton1];
        
        ZXWeakSelf;
        [anotherButton1 addAction:^(UIButton *btn) {
            AddCardViewController *addCardVC = [[AddCardViewController alloc] init];
            addCardVC.bankListDic = weakself.withDataDic[@"bank"];
            [weakself.navigationController pushViewController:addCardVC animated:YES];
        }];
        
        //余额
        UILabel *anotherLabel = [UILabel newAutoLayoutView];
        [_anotherView addSubview:anotherLabel];
        NSString *monStr1 = @"余额：";
        NSString *monStr2 = [NSString stringWithFormat:@"%@元",self.withDataDic[@"account_money"]];
        NSString *monStr = [NSString stringWithFormat:@"%@%@",monStr1,monStr2];
        NSMutableAttributedString *attributeMonStr = [[NSMutableAttributedString alloc] initWithString:monStr];
        [attributeMonStr setAttributes:@{NSForegroundColorAttributeName:kBlackColor} range:NSMakeRange(0, monStr1.length)];
        [attributeMonStr setAttributes:@{NSForegroundColorAttributeName:kNavigationColor} range:NSMakeRange(monStr1.length, monStr2.length)];
        [anotherLabel setAttributedText:attributeMonStr];
        
        //添加银行卡
        UIButton *anotherButton2 = [UIButton newAutoLayoutView];
        [anotherButton2 setTitle:@"提现请先添加银行卡" forState:0];
        [anotherButton2 setTitleColor:kNavigationColor forState:0];
        [_anotherView addSubview:anotherButton2];
        [anotherButton2 addAction:^(UIButton *btn) {
            AddCardViewController *addCardVC = [[AddCardViewController alloc] init];
            addCardVC.bankListDic = weakself.withDataDic[@"bank"];
            [weakself.navigationController pushViewController:addCardVC animated:YES];
        }];
        
        [anotherButton1 autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
        [anotherButton1 autoSetDimension:ALDimensionHeight toSize:230];
        
        [anotherLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:kSpacePadding];
        [anotherLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:anotherButton1 withOffset:kSpacePadding];
        
        [anotherButton2 autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [anotherButton2 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:anotherLabel withOffset:kSpacePadding];
    }
    return _anotherView;
}

- (NSMutableDictionary *)withdraDic
{
    if (!_withdraDic) {
        _withdraDic = [NSMutableDictionary dictionary];
    }
    return _withdraDic;
}

#pragma mark - delegate and datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"withdra0";
    WithdraCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[WithdraCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = kBackgroundColor;
    cell.cardButton.backgroundColor = RGBCOLOR(0.9647, 0.9686, 0.9725);
    cell.separatorInset = UIEdgeInsetsMake(0, kScreenWidth, 0, 0);
    
    NSString *cardStr1 = @"    储蓄卡        ";
    NSString *cardStr2 = self.withDataDic[@"bank"][@"name"];
    NSString *cardStr = [NSString stringWithFormat:@"%@%@",cardStr1,cardStr2];
    NSMutableAttributedString *cardAttributeStr = [[NSMutableAttributedString alloc] initWithString:cardStr];
    [cardAttributeStr addAttributes:@{NSFontAttributeName:font14,NSForegroundColorAttributeName:[UIColor blackColor],NSKernAttributeName:@(0.5)} range:NSMakeRange(0, cardStr1.length)];
    [cardAttributeStr addAttributes:@{NSFontAttributeName:font14,NSForegroundColorAttributeName:kNavigationColor,NSKernAttributeName:@(0.5)} range:NSMakeRange(cardStr1.length, cardStr2.length)];
    [cell.cardButton setAttributedTitle:cardAttributeStr forState:0];
    
    NSString *moneyStr1 = [NSString stringWithFormat:@"    余额¥%@，",self.withDataDic[@"account_money"]];
    NSString *moneyStr2 = @"全部提现";
    NSString *moneyStr = [NSString stringWithFormat:@"%@%@",moneyStr1,moneyStr2];
    NSMutableAttributedString *moneyAttributeStr = [[NSMutableAttributedString alloc] initWithString:moneyStr];
    [moneyAttributeStr addAttributes:@{NSFontAttributeName:font14,NSForegroundColorAttributeName:[UIColor grayColor],NSKernAttributeName : @(0.5)} range:NSMakeRange(0, moneyStr1.length)];
    [moneyAttributeStr addAttributes:@{NSFontAttributeName:font14,NSForegroundColorAttributeName:kNavigationColor,NSKernAttributeName:@(0.5)} range:NSMakeRange(moneyStr1.length, moneyStr2.length)];
    [cell.allMoneyButton setAttributedTitle:moneyAttributeStr forState:0];
    
    ZXWeakSelf;
    ZXWeak(cell);
    [cell.allMoneyButton addAction:^(UIButton *btn) {
        weakcell.moneyTextField.text = self.withDataDic[@"account_money"];
        [weakself.withdraDic setObject:weakcell.moneyTextField.text forKey:@"amount"];
    }];
    
    [cell setDidEndEditing:^(NSString *text) {
        [weakself.withdraDic setObject:text forKey:@"amount"];
    }];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 200;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    footerView.backgroundColor = kBackgroundColor;
    
    //3个工作日内到账
    UIButton *dayButton = [UIButton newAutoLayoutView];
    dayButton.titleLabel.font = font14;
    [dayButton setTitle:@"三个工作日内到账" forState:0];
    [dayButton setTitleColor:[UIColor grayColor] forState:0];
    [footerView addSubview:dayButton];
    [dayButton autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:footerView];
    [dayButton autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:footerView withOffset:kBigPadding];
    [dayButton autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:footerView withOffset:-kBigPadding];
    [dayButton autoSetDimension:ALDimensionHeight toSize:40];
    
    
    UIButton *withdraButton = [UIButton newAutoLayoutView];
    withdraButton.backgroundColor = kNavigationColor;
    withdraButton.layer.cornerRadius = 2;
    [withdraButton setTitle:@"提  现" forState:0];
    withdraButton.titleLabel.font = font14;
    [withdraButton setTitleColor:[UIColor whiteColor] forState:0];
    [footerView addSubview:withdraButton];
    [withdraButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:dayButton];
    [withdraButton autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:footerView withOffset:kBigPadding];
    [withdraButton autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:footerView withOffset:-kBigPadding];
    [withdraButton autoSetDimension:ALDimensionHeight toSize:40];
    ZXWeakSelf;
    [withdraButton addAction:^(UIButton *btn) {
        [weakself requestDataOfWithdra];
    }];
    
    UILabel *remindLabel = [UILabel newAutoLayoutView];
    remindLabel.textColor = [UIColor grayColor];
    remindLabel.font = [UIFont systemFontOfSize:10];
    remindLabel.numberOfLines = 0;
    NSString *testd = @"1、提现申请的受理时间为工作日9:00至16:00，免手续费。\n\n2、提现成功后，资金将于三个工作日之内转入指定的认证银行卡。\n\n3、平台禁止洗钱、信用卡充值套现等行为，平台有权拒绝信用卡充值无投资账户的提现申请。\n\n4、如果要更换提现银行卡，请联系客服";
    remindLabel.text = testd;
    [footerView addSubview:remindLabel];
    [remindLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:footerView withOffset:kBigPadding];
    [remindLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:footerView withOffset:-kBigPadding];
    [remindLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:withdraButton withOffset:50];
    
    return footerView;
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
        
        weakself.withDataDic = dic;
        
        if (([dic[@"status"] intValue] == 0)||[dic[@"info"] isEqualToString:@"登录过期，请重新登录"]) {
            [weakself showHint:dic[@"info"]];
            [weakself.withdraTableView removeFromSuperview];
            [weakself.view addSubview:self.anotherView];
            
        } else if ([dic[@"status"] intValue] == 1) {//已绑定
            [weakself.anotherView removeFromSuperview];
            [weakself.view addSubview:self.withdraTableView];
        }
        [weakself.view setNeedsUpdateConstraints];
        
    } andFailedBlock:^{
        
    }];
}

-(void)requestDataOfWithdra
{
    [self.view endEditing:YES];
    
    NSString *withdraString = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFwithdraws];
    
    [self.withdraDic setObject:self.withDataDic[@"bank"][@"id"] forKey:@"id"];
    [self.withdraDic setObject:TOKEN forKey:@"token"];
    
    NSDictionary *params = self.withdraDic;
    
    ZXWeakSelf;
    [self requestDataPostWithUrlString:withdraString andParams:params andSuccessBlock:^(id responseObject){
        
        BaseModel *baseModel = [BaseModel objectWithKeyValues:responseObject];
        
        //显示信息
        [weakself showHint:baseModel.info];
        
        if ([baseModel.status integerValue] == 1) {
            WithdraFinishViewController *withdraFinishVC = [[WithdraFinishViewController alloc] init];
            withdraFinishVC.moneyString = weakself.withdraDic[@"amount"];
            [weakself.navigationController pushViewController:withdraFinishVC animated:YES];
        }
    } andFailedBlock:^{
        
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
