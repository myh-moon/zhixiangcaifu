//
//  RegisterViewController.m
//  zichanbao
//
//  Created by zhixiang on 15/10/26.
//  Copyright (c) 2015年 zhixiang. All rights reserved.
//

#import "RegisterViewController.h"
#import "JKCountDownButton.h"
#import "BasicButton.h"
#import "BaseModel.h"
#import "AgreementViewController.h"   //《直向理财用户协议》

#import "BorrowCell.h"
#import "LoginCodeCell.h"

@interface RegisterViewController ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic,assign) BOOL didSetupConstraint;
@property (nonatomic,strong) UITableView *registerTableView;
@property (nonatomic,strong) UIPickerView *registerPickerView;

//行数
@property (nonatomic,assign) NSInteger rowNumber;
@property (nonatomic,strong) NSMutableDictionary *registerDic;
@property (nonatomic,strong) NSArray *sourceArray;
@property (nonatomic,strong) NSString *sourceString;  //选中的客户来源

@end

@implementation RegisterViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"注册";
    self.view.backgroundColor = kBackgroundColor;
    self.navigationItem.leftBarButtonItem = self.leftItem;
    
    _rowNumber = 6;
    _sourceArray = @[@"网络广告",@"朋友转介",@"活动推广",@"品牌口碑",@"中介推荐",@"其他"];
    
    [self.view addSubview:self.registerTableView];
    
    [self.view setNeedsUpdateConstraints];
}

- (void)updateViewConstraints
{
    if (!self.didSetupConstraint) {
        
        [self.registerTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
        
        self.didSetupConstraint = YES;
    }
    [super updateViewConstraints];
}

#pragma mark - init view
- (UITableView *)registerTableView
{
    if (!_registerTableView) {
        _registerTableView = [UITableView newAutoLayoutView];
        _registerTableView.backgroundColor = kBackgroundColor;
        _registerTableView.delegate = self;
        _registerTableView.dataSource = self;
        _registerTableView.tableFooterView = [[UIView alloc] init];
    }
    return _registerTableView;
}

- (UIPickerView *)registerPickerView
{
    if (!_registerPickerView) {
        _registerPickerView = [UIPickerView newAutoLayoutView];
        _registerPickerView.delegate = self;
        _registerPickerView.dataSource = self;
        _registerPickerView.backgroundColor = [UIColor colorWithRed:1.0000 green:1.0000 blue:1.0000 alpha:0.7];
        _registerPickerView.showsSelectionIndicator = YES;
    }
    return _registerPickerView;
}

- (NSMutableDictionary *)registerDic
{
    if (!_registerDic) {
        _registerDic = [NSMutableDictionary dictionary];
    }
    return _registerDic;
}

#pragma mark - tableView delegate and datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _rowNumber;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier;
    if (indexPath.row == 0) {//手机号
        identifier = @"register0";
        BorrowCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[BorrowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.nameLabel.text = @"手机号";
        cell.nameTextField.placeholder = @"请输入手机号";
        
        ZXWeakSelf;
        [cell setDidEndEditing:^(NSString *text) {
            [weakself.registerDic setValue:text forKey:@"phone"];
        }];
        
        return cell;
    }else if (indexPath.row == 1){//验证码
        identifier = @"register1";
        LoginCodeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[LoginCodeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.nameButton setTitle: @"验证码" forState:0];
        cell.nameTextField.placeholder = @"请输入验证码";
        
        [cell.codeButton setBackgroundColor:kNavigationColor];
        [cell.codeButton setTitle:@" 获取验证码 " forState:0];
        [cell.codeButton setTitleColor:[UIColor whiteColor] forState:0];
        [cell.codeButton addTarget:self action:@selector(getRegisterCode:) forControlEvents:UIControlEventTouchUpInside];
        
        ZXWeakSelf;
        [cell setDidEndEditing:^(NSString *text) {
            [weakself.registerDic setValue:text forKey:@"txtView"];
        }];
        
        return cell;
    }else if (indexPath.row == 2){//密码
        identifier = @"register2";
        BorrowCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[BorrowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.nameLabel.text = @"密码";
        cell.nameTextField.placeholder = @"不少于6位的字母数字";
        
        ZXWeakSelf;
        [cell setDidEndEditing:^(NSString *text) {
            [weakself.registerDic setValue:text forKey:@"user_pass"];
        }];
        
        return cell;
    }else if (indexPath.row == 3){//确认密码
        identifier = @"register3";
        BorrowCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[BorrowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.nameLabel.text = @"确认密码";
        cell.nameTextField.placeholder = @"请再次输入密码";
        
        ZXWeakSelf;
        [cell setDidEndEditing:^(NSString *text) {
            [weakself.registerDic setValue:text forKey:@"rep_user_pass"];
        }];
        
        return cell;
    }else if (indexPath.row == 4){//邀请码
        identifier = @"register4";
        BorrowCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[BorrowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.nameLabel.text = @"邀请码";
        cell.nameTextField.placeholder = @"请输入邀请码(可不写)";
        
        //code_uid
        ZXWeakSelf;
        [cell setDidEndEditing:^(NSString *text) {
            [weakself.registerDic setValue:text forKey:@"code_uid"];
        }];

        return cell;
    }else if (indexPath.row == 5){//您从哪里知道直向
        identifier = @"register5";
        BorrowCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[BorrowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.nameLabel.text = @"客户来源";
        cell.nameTextField.userInteractionEnabled = NO;
        cell.nameTextField.placeholder = @"请选择";
        
        return cell;
    }else if (indexPath.row == 6){//来源详细
        identifier = @"register6";
        BorrowCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[BorrowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell.nameLabel setHidden:YES];
        
        cell.leftTextFieldConstraint.constant = kSmallPadding;
        cell.nameTextField.placeholder = @"请输入具体来源";
        
        ZXWeakSelf;
        [cell setDidEndEditing:^(NSString *text) {
            [weakself.registerDic setValue:text forKey:@"other"];
        }];
        
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 100;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    
    UIButton *agreeButton = [UIButton newAutoLayoutView];
    [agreeButton setTitle:@"  同意《直向理财用户协议》" forState:0];
    [agreeButton setTitleColor:[UIColor lightGrayColor] forState:0];
    agreeButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [agreeButton setImage:[UIImage imageNamed:@"yougou"] forState:0];
    [footerView addSubview:agreeButton];
    ZXWeakSelf;
    [agreeButton addAction:^(UIButton *btn) {
        AgreementViewController *agreementVC = [[AgreementViewController alloc] init];
        [weakself.navigationController pushViewController:agreementVC animated:YES];
    }];
    
    //commit
    BasicButton *commitBtn  = [BasicButton newAutoLayoutView];
    [commitBtn setBackgroundColor:kNavigationColor];
    [commitBtn setTitle:@"提交" forState:0];
    [footerView addSubview:commitBtn];
    [commitBtn addAction:^(UIButton *btn) {
        [weakself requestDataRegisterFinish];
    }];
    
    [agreeButton autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:footerView withOffset:20];
    [agreeButton autoAlignAxisToSuperviewAxis:ALAxisVertical];
    
    [commitBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:footerView withOffset:kSmallPadding];
    [commitBtn autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:footerView withOffset:-kSmallPadding];
    [commitBtn autoSetDimension:ALDimensionHeight toSize:kCommitHeight];
    [commitBtn autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:footerView];

    return footerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 5) {//froms
        [self showHegPickerView];
    }
}

#pragma mark - pickerView delegate and datasource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 6;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return kSmallCellHeight;
}
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _sourceArray[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *ssss = [NSString stringWithFormat:@"%ld",(long)row+1];
    
    [self.registerDic setValue:ssss forKey:@"froms"];
    
    if (row == 5) {
        _rowNumber = 7;
    }else{
        _rowNumber = 6;
    }
    [self.registerTableView reloadData];
    
    BorrowCell *cell = [self.registerTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
    cell.nameTextField.text = _sourceArray[row];
    
    [self performSelector:@selector(hiddenHegPickerView) withObject:nil afterDelay:0.5];
}

#pragma mark - pickerView
- (void)showHegPickerView
{
    [self.view endEditing:YES];
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self.registerPickerView];
    
    [self.registerPickerView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

- (void)hiddenHegPickerView
{
    [self.registerPickerView removeFromSuperview];
}

#pragma mark - #pragma mark - request
//get phone code
-(void)getRegisterCode:(JKCountDownButton *)sender
{
    [self.view endEditing:YES];
    
    NSString *codeString = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFphone];
    
    NSDictionary *params = self.registerDic;
    
    ZXWeakSelf;
    [self requestDataPostWithUrlString:codeString andParams:params andSuccessBlock:^(id responseObject){
        BaseModel *registerModel = [BaseModel objectWithKeyValues:responseObject];
        [weakself showHint:registerModel.info];
        
        if ([registerModel.status intValue] == 1) {//发送成功
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
                return @"获取";
            }];
        }

    } andFailedBlock:^{

    }];
}

//register
-(void)requestDataRegisterFinish
{
    [self.view endEditing:YES];
    
    NSString *registerString = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFregist];
    
    if ([self.registerType integerValue] == 1) {
        [self.registerDic setValue:@"1" forKey:@"type"];
    }
    
    NSDictionary *params = self.registerDic;
    
    ZXWeakSelf;
    [self requestDataPostWithUrlString:registerString andParams:params andSuccessBlock:^(id  responseObject){
        
        BaseModel *model = [BaseModel objectWithKeyValues:responseObject];
        
        [weakself showHint:model.info];
        
        if ([model.status intValue] == 1) {//注册成功
            [weakself back];
        }

    } andFailedBlock:^{
    }];
}

#pragma mark - textField delegate
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
