//
//  BorrowViewController.m
//  zichanbao
//
//  Created by zhixiang on 15/10/15.
//  Copyright (c) 2015年 zhixiang. All rights reserved.
//

#import "BorrowViewController.h"
#import "BasicButton.h"

#import "BorrowModel.h"
#import "AraeModel.h"
#import "ProModel.h"
#import "BorrowCell.h"

#import "AuthentyViewController.h"  //认证未完成
#import "BorrowFinishViewController.h"  //提交～借款完成

@interface BorrowViewController ()<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIAlertViewDelegate,UITableViewDelegate,UITableViewDataSource>

//view
@property (nonatomic,assign) BOOL didSetupConstrains;
@property (nonatomic,strong) UITableView *borrowTableView;
@property (nonatomic,strong) UIView *bhbhView;

@property (nonatomic,strong) UIPickerView *borrowPickerView;

@property (nonatomic,strong) NSArray *rowTextArray;
@property (nonatomic,strong) MBProgressHUD *hud;

@property (nonatomic,strong) NSString *whichPicker;  //标记pickerView
@property (nonatomic,strong) NSMutableArray *idArray;
@property (nonatomic,strong) NSMutableArray *nameArray;
@property (nonatomic,strong) NSString *idProString;  //选择省份之后对应的城市id
@property (nonatomic,copy) NSArray *cityArray;
@property (nonatomic,copy) NSString *idCityString;//选择城市之后对应的id

//params
@property (nonatomic,strong) NSMutableDictionary *borrowDic;

@end

@implementation BorrowViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.extendedLayoutIncludesOpaqueBars = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kBackgroundColor;
    self.navigationItem.title = @"借款";

    [self.view addSubview:self.borrowTableView];
    
    [self.view setNeedsUpdateConstraints];
    
    [self requestDataOfBorrowMessage];
}

- (void)updateViewConstraints
{
    if (!self.didSetupConstrains) {
        
        [self.borrowTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
        
        self.didSetupConstrains = YES;
    }
    [super updateViewConstraints];
}

#pragma mark - init view

- (UITableView *)borrowTableView
{
    if (!_borrowTableView) {
        _borrowTableView = [UITableView newAutoLayoutView];
        _borrowTableView.backgroundColor = kBackgroundColor;
        _borrowTableView.delegate = self;
        _borrowTableView.dataSource = self;
    }
    return _borrowTableView;
}

- (UIView *)bhbhView
{
    if (!_bhbhView) {
        _bhbhView = [UIView newAutoLayoutView];
        _bhbhView.backgroundColor = [UIColor colorWithRed:0.0000 green:0.0000 blue:0.0000 alpha:0.65];
        
        UIView *borrowView = [UIView newAutoLayoutView];//蒙板
        [_bhbhView addSubview:borrowView];
        [borrowView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
        [borrowView autoSetDimension:ALDimensionHeight toSize:kSmallCellHeight*6];
        
        //layout
        UIButton *okButton = [UIButton newAutoLayoutView];
        [okButton setTitle:@"确定" forState:0];
        [okButton setTitleColor:kBlackColor forState:0];
        okButton.titleLabel.font = font14;
        [okButton setBackgroundColor:[UIColor whiteColor]];
        [okButton setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, kSmallPadding)];
        okButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        okButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
        okButton.layer.borderWidth = 1;
        
        ZXWeakSelf;
        [okButton addAction:^(UIButton *btn) {
            if ([_whichPicker integerValue] == 0) {//省份
                if (weakself.borrowDic[@"province"]) {
                    BorrowCell *cell = [weakself.borrowTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
                    cell.nameTextField.text = weakself.borrowDic[@"province"];
                }
            }else if ([_whichPicker integerValue] == 1){//市区
                if (weakself.borrowDic[@"city"]) {
                    BorrowCell *cell = [weakself.borrowTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
                    cell.nameTextField.text = weakself.borrowDic[@"city"];
                }
            }
            [weakself hiddenPickerViewOfBorrow];
        }];
        [borrowView addSubview:okButton];
        [borrowView addSubview:self.borrowPickerView];
        
        [okButton autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:borrowView];
        [okButton autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:borrowView];
        [okButton autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:borrowView];
        [okButton autoSetDimension:ALDimensionHeight toSize:kSmallCellHeight];
        
        [self.borrowPickerView autoSetDimension:ALDimensionHeight toSize:kSmallCellHeight*5];
        [self.borrowPickerView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:borrowView];
        [self.borrowPickerView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:borrowView];
        [self.borrowPickerView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:borrowView];
    }
    return _bhbhView;
}

- (UIPickerView *)borrowPickerView
{
    if (!_borrowPickerView) {
        _borrowPickerView = [UIPickerView newAutoLayoutView];
        _borrowPickerView.delegate = self;
        _borrowPickerView.dataSource = self;
        _borrowPickerView.backgroundColor = [UIColor whiteColor];
    }
    return _borrowPickerView;
}

- (void)showPickerViewOfBorrow
{
    [self.view endEditing:YES];
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self.bhbhView];
    [self.bhbhView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

- (void)hiddenPickerViewOfBorrow
{
    [self.bhbhView removeFromSuperview];
}

#pragma mark - init array
-(NSMutableArray *)idArray
{
    if (!_idArray) {
        _idArray = [NSMutableArray array];
    }
    return _idArray;
}

-(NSMutableArray *)nameArray
{
    if (!_nameArray) {
        _nameArray = [NSMutableArray array];
    }
    return _nameArray;
}

-(NSArray *)cityArray
{
    if (!_cityArray) {
        _cityArray = [NSArray array];
    }
    return _cityArray;
}

- (NSMutableDictionary *)borrowDic
{
    if (!_borrowDic) {
        _borrowDic = [NSMutableDictionary dictionary];
    }
    return _borrowDic;
}

#pragma mark - tableview delegate and datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"borrow";
    BorrowCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[BorrowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSArray *borrowArr = @[@"您的姓名",@"借款金额",@"手机号",@"借款省份",@"借款城市"];
    NSArray *borrowArr1 = @[@"请输入您的姓名",@"请输入借款金额",@"请输入手机号",@"请选择借款省份",@"请选择借款城市"];
    cell.nameLabel.text = borrowArr[indexPath.row];
    cell.nameTextField.placeholder = borrowArr1[indexPath.row];
    
    ZXWeakSelf;

    if (indexPath.row == 0) {
        cell.nameTextField.userInteractionEnabled = YES;
        [cell.nameButton setHidden:YES];
        [cell setDidEndEditing:^(NSString *text) {
            [weakself.borrowDic setObject:text forKey:@"name"];
        }];
    }else if(indexPath.row == 1){
        cell.nameTextField.userInteractionEnabled = YES;
        cell.nameTextField.keyboardType = UIKeyboardTypeNumberPad;
        [cell.nameButton setHidden:NO];
        [cell.nameButton setTitle:@"万元" forState:0];
        [cell setDidEndEditing:^(NSString *text) {
            [weakself.borrowDic setObject:text forKey:@"money"];
        }];
    }else if (indexPath.row == 2){
        cell.nameTextField.userInteractionEnabled = YES;
        cell.nameTextField.keyboardType = UIKeyboardTypeNumberPad;
        [cell.nameButton setHidden:YES];
        [cell setDidEndEditing:^(NSString *text) {
            [weakself.borrowDic setObject:text forKey:@"phone"];
        }];
    }else{
        cell.nameTextField.userInteractionEnabled = NO;
        [cell.nameButton setHidden: NO];
        [cell.nameButton setImage:[UIImage imageNamed:@"arro"] forState:0];
        cell.nameButton.userInteractionEnabled = NO;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return kBigPadding+50;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50+kBigPadding)];
    
    BasicButton *borrowCommitButton = [BasicButton newAutoLayoutView];
    [borrowCommitButton setTitle:@"提交" forState:0];
    [footerView addSubview:borrowCommitButton];
    [borrowCommitButton autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:footerView withOffset:kBigPadding];
    [borrowCommitButton autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:footerView withOffset:kBigPadding];
    [borrowCommitButton autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:footerView withOffset:-kBigPadding];
    [borrowCommitButton autoSetDimension:ALDimensionHeight toSize:kCommitHeight];
    [borrowCommitButton addTarget:self action:@selector(requestDataOfBorrowFinish) forControlEvents:UIControlEventTouchUpInside];
    
    return footerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 3) {//省份
        _whichPicker = @"0";
        if (self.idArray.count > 0) {
            [self showPickerViewOfBorrow];
        }else{
            [self requestDataOfProvince];
        }
    }else if (indexPath.row == 4){//市区
        
        if (self.borrowDic[@"province"]) {
            _whichPicker = @"1";
            [self requestDataOfCityWithId:self.borrowDic[@"provinceId"]];
        }else{
            [self showHint:@"请先选择省份"];
        }
    }
}

#pragma mark - alertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex ==  1) {
        AuthentyViewController *authentyVC = [[AuthentyViewController alloc] init];
        authentyVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:authentyVC animated:YES];
    }
}

#pragma mark - pickView deledate and dataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if ([_whichPicker intValue] == 0) {//省份
        return self.nameArray.count;
    }
    //城市
    return self.cityArray.count;
}
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30;
}
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 80;
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *pl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    pl.textColor = [UIColor blackColor];
    pl.font = font14;
    pl.textAlignment = NSTextAlignmentCenter;
    
    if ([_whichPicker intValue] == 0) {//省份
        pl.text = self.nameArray[row];
    }else if ([_whichPicker intValue] == 1){//城市
        pl.text = self.cityArray[row][1];
    }
    
    return pl;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ([_whichPicker intValue] == 0) {//省份
        [self.borrowDic setObject:self.nameArray[row] forKey:@"province"];
        [self.borrowDic setObject:self.idArray[row] forKey:@"provinceId"];
    }else if ([_whichPicker intValue] == 1){//城市
        [self.borrowDic setObject:self.cityArray[row][1] forKey:@"city"];
        [self.borrowDic setObject:self.cityArray[row][0] forKey:@"cityId"];
    }
}

#pragma mark - request data
-(void)requestDataOfBorrowMessage
{
    AccountModel *accountModel = [self checkMyAccount];
    if (!accountModel.status) {//登录正常
        NSString *messageString = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFBorrow];
        
        NSDictionary *param = @{
                                @"token" : TOKEN,
                                };
        ZXWeakSelf;
        [self requestDataGetWithUrlString:messageString paramter:param SucceccBlock:^(id responseObject) {
            
            BorrowModel *borrowModel = [BorrowModel objectWithKeyValues:responseObject];
            
            if ([borrowModel.status intValue] == 0) {//请求失败
                [weakself showHint:borrowModel.info];
            }else if ([borrowModel.status intValue] == 1){//已认证
                
                BorrowCell *cell0 = [weakself.borrowTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
                cell0.nameTextField.text = borrowModel.name;
                [weakself.borrowDic setObject:borrowModel.name forKey:@"name"];
                
                BorrowCell *cell2 = [weakself.borrowTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
                cell2.nameTextField.text = borrowModel.phone;
                [weakself.borrowDic setObject:borrowModel.phone forKey:@"phone"];
                
            }else if ([borrowModel.status intValue] == 2){//未认证
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"身份未认证" message:@"借款需身份认证，请先认证" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                [alertView show];
            }
        } andFailedBlock:^{
            
        }];
    }else{//登录正常
        [self showHint:accountModel.info];
    }
}

-(void)requestDataOfProvince
{
    AccountModel *accountModel = [self checkMyAccount];
    if (!accountModel.status) {//登录正常
        NSString *provinceString = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFprovince];
        NSDictionary *param = @{
                                @"token" : TOKEN
                                };
        
        ZXWeakSelf;
        [self requestDataGetWithUrlString:provinceString paramter:param SucceccBlock:^(id responseObject){
            AraeModel *areaModel = [AraeModel objectWithKeyValues:responseObject];
            for (ProModel *proModel in areaModel.area) {
                [weakself.idArray addObject:proModel.ID];
                [weakself.nameArray addObject:proModel.name];
            }
            
            [weakself showPickerViewOfBorrow];
            [weakself.borrowPickerView reloadAllComponents];
        } andFailedBlock:^{
        }];
    }else{
        [self showHint:accountModel.info];
    }
}

//request city
-(void)requestDataOfCityWithId:(NSString *)proID
{
    NSString *cityString = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFprovince];
    
    NSDictionary *params = nil;
    
    if (TOKEN == nil || TOKEN == 0) {
        params = @{
                   @"token" : @"",
                   @"id" : proID
                   };
    }else{
        params = @{
                   @"token" : TOKEN,
                   @"id" : proID
                   };
    }
    
    ZXWeakSelf;
    [self requestDataGetWithUrlString:cityString paramter:params SucceccBlock:^(id responseObject){
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        weakself.cityArray = dic.allValues;
        [weakself.borrowPickerView reloadAllComponents];
        [weakself showPickerViewOfBorrow];
    } andFailedBlock:^{
        
    }];
}

//提交借款信息
-(void)requestDataOfBorrowFinish
{
    [self.view endEditing:YES];
    _hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    NSString *borrowString = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFBorrow];
    
    [self.borrowDic setObject:@"1" forKey:@"is_phone"];

    NSDictionary *params = self.borrowDic;
    
    ZXWeakSelf;
    [self requestDataPostWithUrlString:borrowString andParams:params andSuccessBlock:^(id responseObject){
        [_hud removeFromSuperview];
        
        BorrowModel *borrowFinishModel = [BorrowModel objectWithKeyValues:responseObject];
        
        [weakself showHint:borrowFinishModel.info];
        
        if ([borrowFinishModel.status intValue] == 1) {//申请成功
            BorrowFinishViewController *borrowFinishVC = [[BorrowFinishViewController alloc] init];
            borrowFinishVC.hidesBottomBarWhenPushed = YES;
            [weakself.navigationController pushViewController:borrowFinishVC animated:YES];
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
