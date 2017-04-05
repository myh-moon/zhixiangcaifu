//
//  AddCardViewController.m
//  zichanbao
//
//  Created by zhixiang on 16/1/8.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import "AddCardViewController.h"
#import "BasicButton.h"
#import "JKCountDownButton.h"

#import "RechargeViewController.h"  //充值
#import "AgreementViewController.h"//直向理财用户协议
#import "WithdraViewController.h"  //提现

#import "BorrowCell.h"
#import "LoginCodeCell.h"

#import "BaseModel.h"
#import "AraeModel.h"
#import "ProModel.h"

#define fontA [UIFont systemFontOfSize:16]

@interface AddCardViewController ()<UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,assign) BOOL didSetupConstraint;
@property (nonatomic,strong) UITableView *addCardTableView;
@property (nonatomic,strong) UIView *adadView;

@property (nonatomic,strong) UIPickerView *bankPickerView;//pickerView
@property (nonatomic,strong) JKCountDownButton *codeButton;  //获取验证码

@property (nonatomic,assign) NSString *whichPicker; //标记pickerView
@property (nonatomic,strong) NSString *idProString;    //标记省份对应的id
@property (nonatomic,strong) NSString *idBankString;  //标记银行对应的id
@property (nonatomic,strong) NSString *idCityString;  //标记省份对应的城市id

//解析数据（银行列表，省份列表，城市列表）
@property (nonatomic,strong) NSArray *bankArray;
@property (nonatomic,strong) NSArray *proArray;
@property (nonatomic,strong) NSArray *cityArray;

@property (nonatomic,strong) NSMutableArray *idProArray;
@property (nonatomic,strong) NSMutableArray *nameProArray;

@property (nonatomic,strong) NSString *isWithdra;

@property (nonatomic,strong) NSMutableDictionary *addCardDic;

@end

@implementation AddCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加银行卡";
    self.view.backgroundColor = kBackgroundColor;
    self.navigationItem.leftBarButtonItem = self.leftItem;
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.extendedLayoutIncludesOpaqueBars = NO;
    
//    self.idBankString = @"";
//    self.idProString = @"";
//    self.idCityString = @"";
    
    [self.view addSubview:self.addCardTableView];
    
    [self.view setNeedsUpdateConstraints];
}

- (void)updateViewConstraints
{
    if (!self.didSetupConstraint) {
        
        [self.addCardTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
        
        self.didSetupConstraint = YES;
    }
    [super updateViewConstraints];
}

#pragma mark - getter view
- (UITableView *)addCardTableView
{
    if (!_addCardTableView) {
        _addCardTableView = [UITableView newAutoLayoutView];
        _addCardTableView.delegate = self;
        _addCardTableView.dataSource = self;
        _addCardTableView.backgroundColor = kBackgroundColor;
        _addCardTableView.tableFooterView = [[UIView alloc] init];
    }
    return _addCardTableView;
}

- (NSMutableDictionary *)addCardDic
{
    if (!_addCardDic) {
        _addCardDic = [NSMutableDictionary dictionary];
    }
    return _addCardDic;
}

-(UIPickerView *)bankPickerView
{
    if (!_bankPickerView) {
        _bankPickerView = [UIPickerView newAutoLayoutView];
        _bankPickerView.backgroundColor = [UIColor whiteColor];
        _bankPickerView.delegate = self;
        _bankPickerView.dataSource = self;
    }
    return _bankPickerView;
}

- (UIView *)adadView
{
    if (!_adadView) {
        _adadView = [UIView newAutoLayoutView];
        _adadView.backgroundColor = [UIColor colorWithRed:0.0000 green:0.0000 blue:0.0000 alpha:0.65];
        
        //layout
        UIButton *okButton = [UIButton newAutoLayoutView];
        [okButton setTitle:@"确定" forState:0];
        [okButton setTitleColor:[UIColor blackColor] forState:0];
        okButton.titleLabel.font = font14;
        [okButton setBackgroundColor:[UIColor whiteColor]];
        [okButton setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, kSmallPadding)];
        okButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        ZXWeakSelf;
        [okButton addAction:^(UIButton *btn) {
            if ([_whichPicker integerValue] == 1) {//省份
                if (weakself.addCardDic[@"bank_province"]) {
                    BorrowCell *cell = [weakself.addCardTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
                    cell.nameTextField.text = weakself.addCardDic[@"bank_provinceText"];
                }
            }else if ([_whichPicker integerValue] == 2){//市区
                if (weakself.addCardDic[@"bank_city"]) {
                    BorrowCell *cell = [weakself.addCardTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
                    cell.nameTextField.text = weakself.addCardDic[@"bank_cityText"];
                }
            }else if ([_whichPicker integerValue] == 0){ //开户银行
                BorrowCell *cell = [weakself.addCardTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
                cell.nameTextField.text = weakself.addCardDic[@"banknumText"];
            }
            [weakself hiddenPickerView];
        }];
        [_adadView addSubview:okButton];
        [_adadView addSubview:self.bankPickerView];
        
        
        [okButton autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.bankPickerView];
        [okButton autoSetDimension:ALDimensionHeight toSize:kSmallCellHeight];
        [okButton autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [okButton autoPinEdgeToSuperviewEdge:ALEdgeRight];
        
        [self.bankPickerView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
        [self.bankPickerView autoSetDimension:ALDimensionHeight toSize:kSmallCellHeight*5];
    }
    return _adadView;
}

- (void)showPickerView
{
    [self.view endEditing:YES];
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self.adadView];
    [self.adadView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

- (void)hiddenPickerView
{
    [self.adadView removeFromSuperview];
}

#pragma mark - tableview delegate and datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 9;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier;
    if (indexPath.row < 3) {
        identifier = @"addCard00";
        BorrowCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[BorrowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.leftTextFieldConstraint.constant = 80;
        
        NSArray *textArr0 = @[@[@"持卡人",@"持卡人"],@[@"证件号",@"身份证号或护照号"],@[@"银行卡号",@"仅限已开通网银的借记卡"]];
        cell.nameLabel.text = textArr0[indexPath.row][0];
        cell.nameTextField.placeholder = textArr0[indexPath.row][1];
        
        ZXWeakSelf;
        [cell setDidEndEditing:^(NSString * text) {
            if (indexPath.row == 0) {
                [weakself.addCardDic setValue:text forKey:@"real_name"];
            }else if (indexPath.row == 1) {
                [weakself.addCardDic setValue:text forKey:@"idCard"];
            }else if (indexPath.row == 2) {
                [weakself.addCardDic setValue:text forKey:@"card"];
            }
        }];
        
        return cell;
    }else if(indexPath.row >=3 && indexPath.row <= 5){
        identifier = @"addCard11";
        BorrowCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[BorrowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.leftTextFieldConstraint.constant = 80;
        cell.nameTextField.userInteractionEnabled = NO;
        cell.nameButton.userInteractionEnabled = NO;
        [cell.nameButton setImage:[UIImage imageNamed:@"arro"] forState:0];
        
        NSArray *textArr1 = @[@"开户银行",@"开户省份",@"开户城市"];
        cell.nameLabel.text = textArr1[indexPath.row-3];
        cell.nameTextField.placeholder = @"请选择";
        
        return cell;
    }else if (indexPath.row == 6){
        identifier = @"addCard22";
        BorrowCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[BorrowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.leftTextFieldConstraint.constant = 80;
        cell.nameLabel.text = @"开户地址";
        cell.nameTextField.placeholder = @"请输入开户地址";
        
        ZXWeakSelf;
        [cell setDidEndEditing:^(NSString * text) {
            [weakself.addCardDic setValue:text forKey:@"bank_address"];
        }];
        
        return cell;
    }else if (indexPath.row == 7){
        identifier = @"addCard33";
        LoginCodeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[LoginCodeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.leftTextFieldConstraint.constant = 80;
        [cell.nameButton setTitle:@"手机号" forState:0];
        cell.nameTextField.placeholder = @"与银行预留手机号一致";
        [cell.codeButton setTitle:@"获取验证码" forState:0];
        [cell.codeButton setBackgroundColor:kNavigationColor];
        [cell.codeButton setTitleColor:[UIColor whiteColor] forState:0];
        [cell.codeButton addTarget:self action:@selector(requestDataOfCodeIdentifier:) forControlEvents:UIControlEventTouchUpInside];
        
        ZXWeakSelf;
        [cell setDidEndEditing:^(NSString * text) {
            [weakself.addCardDic setValue:text forKey:@"phone"];
        }];
        
        return cell;
    }else if (indexPath.row == 8){
        identifier = @"addCard44";
        BorrowCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[BorrowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.leftTextFieldConstraint.constant = 80;
        cell.nameLabel.text = @"验证码";
        cell.nameTextField.placeholder = @"一分钟内有效";
        
        ZXWeakSelf;
        [cell setDidEndEditing:^(NSString * text) {
            [weakself.addCardDic setValue:text forKey:@"code"];
        }];
        
        return cell;
    }
    return nil;
    
    /*
    BorrowCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[BorrowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.leftTextFieldConstraint.constant = 80;
    
    NSArray *array1 = [NSArray arrayWithObjects:@"持卡人",@"证件号",@"银行卡号",@"开户银行",@"开户省份",@"开户城市",@"开户地址",@"手机号",@"验证码", nil];
    NSArray *array2 = [NSArray arrayWithObjects:@"持卡人",@"身份证号或护照号",@"仅限已开通网银的借记卡",@"",@"",@"",@"请输入开户地址",@"与银行预留手机号一致",@"一分钟内有效", nil];
    
    cell.nameLabel.text = array1[indexPath.row];
    cell.nameTextField.placeholder = array2[indexPath.row];
    
    if (indexPath.row == 0) {
        [cell.nameButton setHidden:YES];
        cell.nameTextField.userInteractionEnabled = YES;
        
    }else if (indexPath.row == 1) {
        [cell.nameButton setHidden:YES];
        cell.nameTextField.userInteractionEnabled = YES;

    }else if (indexPath.row == 2) {
        [cell.nameButton setHidden:YES];
        cell.nameTextField.userInteractionEnabled = YES;

    }else if (indexPath.row == 3) {
        cell.nameTextField.userInteractionEnabled = NO;
        [cell.nameButton setHidden:NO];
        [cell.nameButton setImage:[UIImage imageNamed:@"arro"] forState:0];

    }else if (indexPath.row == 4) {
        cell.nameTextField.userInteractionEnabled = NO;
        [cell.nameButton setHidden:NO];
        [cell.nameButton setImage:[UIImage imageNamed:@"arro"] forState:0];

    }else if (indexPath.row == 5) {
        cell.nameTextField.userInteractionEnabled = NO;
        [cell.nameButton setHidden:NO];
        [cell.nameButton setImage:[UIImage imageNamed:@"arro"] forState:0];

    }else if (indexPath.row == 6) {
        cell.nameTextField.userInteractionEnabled = YES;
        [cell.nameButton setHidden:YES];
    }else if (indexPath.row == 7) {
        cell.nameTextField.userInteractionEnabled = YES;
        [cell.nameButton setHidden:NO];
        [cell.nameButton setTitle:@"获取验证码" forState:0];
        [cell.nameButton setTitleColor:[UIColor whiteColor] forState:0];
        cell.nameButton.layer.cornerRadius = 4;
        [cell.nameButton setBackgroundColor:kNavigationColor];
        [cell.nameButton addTarget:self action:@selector(requestDataOfCodeIdentifier:) forControlEvents:UIControlEventTouchUpInside];
    }else if (indexPath.row == 8) {
        cell.nameTextField.userInteractionEnabled = YES;
        [cell.nameButton setHidden:YES];
    }
    
    ZXWeakSelf;
    [cell setDidEndEditing:^(NSString * text) {
        if (indexPath.row == 0) {
            [weakself.addCardDic setValue:text forKey:@"real_name"];
        }else if (indexPath.row == 1) {
            [weakself.addCardDic setValue:text forKey:@"idCard"];
        }else if (indexPath.row == 2) {
            [weakself.addCardDic setValue:text forKey:@"card"];
        }else if (indexPath.row == 6) {
            [weakself.addCardDic setValue:text forKey:@"bank_address"];
        }else if (indexPath.row == 7) {
            [weakself.addCardDic setValue:text forKey:@"phone"];
        }else if (indexPath.row == 8) {
            [weakself.addCardDic setValue:text forKey:@"code"];
        }
    }];
    
    return cell;
     */
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 100;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    
    UIButton *agreeBtn1 = [UIButton newAutoLayoutView];
    [agreeBtn1 setImage:[UIImage imageNamed:@"kuang"] forState:0];
    [agreeBtn1 setImage:[UIImage imageNamed:@"yougou"] forState:UIControlStateSelected];
    [footerView addSubview:agreeBtn1];
    [agreeBtn1 addAction:^(UIButton *btn) {
        btn.selected = !btn.selected;
    }];
    
    UIButton *agreeBtn2 = [UIButton newAutoLayoutView];
    [agreeBtn2 setTitle:@"同意《直向理财用户协议》" forState:0];
    agreeBtn2.titleLabel.font = [UIFont systemFontOfSize:12];
    [agreeBtn2 setTitleColor:[UIColor lightGrayColor] forState:0];
    [footerView addSubview:agreeBtn2];
    ZXWeakSelf;
    [agreeBtn2 addAction:^(UIButton *btn) {
        AgreementViewController *agreementVC = [[AgreementViewController alloc] init];
        [weakself.navigationController pushViewController:agreementVC animated:YES];
    }];
    
    BasicButton *addCardCoomitButton = [BasicButton newAutoLayoutView];
    [addCardCoomitButton setTitle:@"提交" forState:0];
    [footerView addSubview:addCardCoomitButton];
    [addCardCoomitButton addAction:^(UIButton *btn) {
        //若同意协议
        if (agreeBtn1.selected) {
            [weakself requestDataOfCommitBank];
        }else{
            //若不同意
            [weakself showHint:@"需同意协议"];
        }
    }];
    
//    NSArray *views = @[agreeBtn1,agreeBtn2];
//    [views autoAlignViewsToAxis:ALAxisVertical];
    [agreeBtn1 autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:agreeBtn2 withOffset:-10];
    [agreeBtn1 autoAlignAxis:ALAxisHorizontal toSameAxisOfView:agreeBtn2];
    
    [agreeBtn2 autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:footerView withOffset:30];
    [agreeBtn2 autoAlignAxisToSuperviewAxis:ALAxisVertical];
    
    [addCardCoomitButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:agreeBtn1 withOffset:20];
    [addCardCoomitButton autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:footerView withOffset:kBigPadding];
    [addCardCoomitButton autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:footerView withOffset:-kBigPadding];
    [addCardCoomitButton autoSetDimension:ALDimensionHeight toSize:50];
    
    return footerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 3) {//银行
        _whichPicker = 0;
        [self showPickerView];
        [self.bankPickerView reloadAllComponents];
    }else if (indexPath.row == 4){//省
        _whichPicker = @"1";
        [self requestDataOfProvince];
    }else if (indexPath.row == 5){//市
        _whichPicker = @"2";
        if (self.addCardDic[@"bank_province"]) {
            [self requestDataOfCity];
        }else{
            [self showHint:@"请先选择省份"];
        }
    }
}

#pragma mark - pickerView delegate and dataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if ([_whichPicker integerValue] == 0) {
        return self.bankArray.count;
    }else if ([_whichPicker integerValue] == 1){
        return self.nameProArray.count;
    }else if ([_whichPicker integerValue] == 2){
        return self.cityArray.count;
    }
    return 0;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return kScreenWidth;;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30;
}

//- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//    if ([_whichPicker integerValue] == 0) {
//        return self.bankArray[row][1];
//    }else if ([_whichPicker integerValue] == 1){
//        return self.nameProArray[row];
//    }else{
//        return self.cityArray[row][1];
//    }
//    return nil;
//}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *pl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    pl.backgroundColor = [UIColor whiteColor];
    pl.textColor = [UIColor blackColor];
    pl.font = font14;
    pl.textAlignment = NSTextAlignmentCenter;
    
    if ([_whichPicker integerValue] == 0) {
        pl.text = self.bankArray[row][1];
    }else if ([_whichPicker integerValue] == 1){
        pl.text = self.nameProArray[row];
    }else{
        pl.text = self.cityArray[row][1];
    }
    
    return pl;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ([_whichPicker integerValue] == 0) {
//        UITextField *tf = (UITextField *)[self.whiteView1 viewWithTag:103];
//        tf.text = self.bankArray[row][1];
//        self.idBankString = self.bankListDic.allKeys[row];
        
//        BorrowCell *cell = [self.addCardTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
//        cell.nameTextField.text = self.bankArray[row][1];
        
        [self.addCardDic setValue:self.bankListDic.allKeys[row] forKey:@"banknum"];
        [self.addCardDic setValue:self.bankArray[row][1] forKey:@"banknumText"];
        
    }else if ([_whichPicker integerValue] == 1){
//        UITextField *tf = (UITextField *)[self.whiteView1 viewWithTag:104];
//        tf.text = self.nameProArray[row];
//        self.idProString = self.idProArray[row];
        
//        BorrowCell *cell = [self.addCardTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
//        cell.nameTextField.text = self.nameProArray[row];
        
        [self.addCardDic setValue:self.idProArray[row] forKey:@"bank_province"];
        [self.addCardDic setValue:self.nameProArray[row] forKey:@"bank_provinceText"];

    }else{
//        UITextField *tf = (UITextField *)[self.whiteView1 viewWithTag:105];
//        tf.text = self.cityArray[row][1];
//        self.idCityString = self.cityArray[row][0];
        
//        BorrowCell *cell = [self.addCardTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
//        cell.nameTextField.text = self.cityArray[row][1];
        
        [self.addCardDic setValue:self.cityArray[row][0] forKey:@"bank_city"];
        [self.addCardDic setValue:self.cityArray[row][1] forKey:@"bank_cityText"];
    }
}

#pragma mark - init array and dictionary
-(NSArray *)bankArray
{
    if (!_bankArray) {
        _bankArray = [NSArray array];
        _bankArray = self.bankListDic.allValues;
    }
    return _bankArray;
}

-(NSMutableArray *)idProArray
{
    if (!_idProArray) {
        _idProArray = [NSMutableArray array];
    }
    return _idProArray;
}

-(NSMutableArray *)nameProArray
{
    if (!_nameProArray) {
        _nameProArray = [NSMutableArray array];
    }
    return _nameProArray;
}

-(NSArray *)cityArray
{
    if (!_cityArray) {
        _cityArray = [NSArray array];
    }
    return _cityArray;
}

#pragma mark - request
//获取省份列表
-(void)requestDataOfProvince
{
    NSString *provinceString = [NSString stringWithFormat:@"%@%@?token=%@",ZXCF,ZXCFprovince,TOKEN];
    NSDictionary *param = @{
                            @"token" : TOKEN
                            };
    
    ZXWeakSelf;
    [self requestDataGetWithUrlString:provinceString paramter:param SucceccBlock:^(id responseObject){
        AraeModel *areaModel = [AraeModel objectWithKeyValues:responseObject];
        
        for (ProModel *proModel in areaModel.area) {
            [weakself.idProArray addObject:proModel.ID];
            [weakself.nameProArray addObject:proModel.name];
        }
        [weakself showPickerView];
        [weakself.bankPickerView reloadAllComponents];
    } andFailedBlock:^{
    }];
}
//获取城市列表
-(void)requestDataOfCity
{
    NSString *cityString = [NSString stringWithFormat:@"%@%@?token=%@&id=%@",ZXCF,ZXCFprovince,TOKEN,self.idProString];
    NSDictionary *params = @{
                             @"token" : TOKEN,
                             @"id" : self.addCardDic[@"bank_province"]
                             };
    ZXWeakSelf;
    [self requestDataGetWithUrlString:cityString paramter:params SucceccBlock:^(id responseObject){
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        weakself.cityArray = dictionary.allValues;
        [weakself showPickerView];
        [weakself.bankPickerView reloadAllComponents];
    } andFailedBlock:^{
        
    }];
}

//获取验证码
-(void)requestDataOfCodeIdentifier:(JKCountDownButton *)sender
{
    [self.view endEditing:YES];
    NSString *codeString = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFBindingBankCode];
    [self.addCardDic setValue:TOKEN forKey:@"token"];
    NSDictionary *params = self.addCardDic;
    
    ZXWeakSelf;
    [self requestDataPostWithUrlString:codeString andParams:params andSuccessBlock:^(id responseObject){
        
        BaseModel *codeModel = [BaseModel objectWithKeyValues:responseObject];
        
        [weakself showHint:codeModel.info];
        
        if ([codeModel.status intValue] == 1) {//发送成功
            [sender startWithSecond:60];
            [sender didChange:^NSString *(JKCountDownButton *countDownButton, int second) {
                sender.backgroundColor = [UIColor lightGrayColor];
                sender.enabled = NO;
                NSString *title = [NSString stringWithFormat:@"剩余%d秒",second];
                return title;
            }];
            [sender didFinished:^NSString *(JKCountDownButton *countDownButton, int second) {
                sender.backgroundColor = kNavigationColor;
                countDownButton.enabled = YES;
                return @"获取验证码";
            }];
        }
        
    } andFailedBlock:^{

    }];
}

//绑定银行卡
-(void)requestDataOfCommitBank
{
    [self.view endEditing:YES];
    NSString *commitString = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFBindingBank];
    NSDictionary *params = self.addCardDic;
    
    ZXWeakSelf;
    [self requestDataPostWithUrlString:commitString andParams:params andSuccessBlock:^(id responseObject){
        
        BaseModel *commitModel = [BaseModel objectWithKeyValues:responseObject];
        
        [weakself showHint:commitModel.info];
        
        if ([commitModel.status intValue] == 1) {//提交成功
            
            UINavigationController *navv = weakself.navigationController;
            [navv popViewControllerAnimated:NO];
            [navv popViewControllerAnimated:NO];
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
