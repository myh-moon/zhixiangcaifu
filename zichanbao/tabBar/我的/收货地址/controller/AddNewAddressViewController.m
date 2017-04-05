//
//  AddNewAddressViewController.m
//  zichanbao
//
//  Created by zhixiang on 16/11/10.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import "AddNewAddressViewController.h"

#import "BorrowCell.h"
#import "ExChangeDetailssCell.h"  //详细地址
#import "AddressSwitchCell.h"

#import "AraeModel.h"
#import "ProModel.h"

#import "BasicButton.h"

@interface AddNewAddressViewController ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic,assign) BOOL didSetupConstraints;
@property (nonatomic,strong) UITableView *addNewTableView;
@property (nonatomic,strong) UIView *uiuiView;
@property (nonatomic,strong) UIPickerView *AddressPickerView;

//params
@property (nonatomic,strong) NSMutableDictionary *addNewDic;

@property (nonatomic,strong) NSMutableArray *idArray;
@property (nonatomic,strong) NSMutableArray *nameArray;
@property (nonatomic,strong) NSString *idProString;  //选择省份之后对应的城市id
@property (nonatomic,copy) NSArray *cityArray;
@property (nonatomic,copy) NSString *idCityString;//选择城市之后对应的id

@end

@implementation AddNewAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加地址";
    self.navigationItem.leftBarButtonItem = self.leftItem;
    
    [self.view addSubview:self.addNewTableView];
//    [self.view addSubview:self.saveNewButton];
    
    [self.view setNeedsUpdateConstraints];
}

- (void)updateViewConstraints
{
    if (!self.didSetupConstraints) {
        
        [self.addNewTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
//        [self.addNewTableView autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.saveNewButton];
//        
//        [self.saveNewButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
//        [self.saveNewButton autoSetDimension:ALDimensionHeight toSize:kCommitHeight];
        
        self.didSetupConstraints = YES;
    }
    [super updateViewConstraints];
}

- (UITableView *)addNewTableView
{
    if (!_addNewTableView) {
        _addNewTableView = [UITableView newAutoLayoutView];
        _addNewTableView.backgroundColor = kBackgroundColor;
        _addNewTableView.delegate = self;
        _addNewTableView.dataSource = self;
        _addNewTableView.tableFooterView = [[UIView alloc] init];
    }
    return _addNewTableView;
}

- (UIView *)uiuiView
{
    if (!_uiuiView) {
        _uiuiView = [UIView newAutoLayoutView];
        _uiuiView.backgroundColor = [UIColor colorWithRed:0.0000 green:0.0000 blue:0.0000 alpha:0.65];
        
        UIView *borrowView = [UIView newAutoLayoutView];//蒙板
        [_uiuiView addSubview:borrowView];
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
            if (weakself.addNewDic[@"province"] && weakself.addNewDic[@"city"]) {
                BorrowCell *cell = [weakself.addNewTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
                cell.nameTextField.text = [NSString stringWithFormat:@"%@%@",weakself.addNewDic[@"province"],weakself.addNewDic[@"city"]];
            }
            [weakself hiddenPickerViewOfAddNew];
        }];
        [borrowView addSubview:okButton];
        [borrowView addSubview:self.AddressPickerView];
        
        [okButton autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:borrowView];
        [okButton autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:borrowView];
        [okButton autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:borrowView];
        [okButton autoSetDimension:ALDimensionHeight toSize:kSmallCellHeight];
        
        [self.AddressPickerView autoSetDimension:ALDimensionHeight toSize:kSmallCellHeight*5];
        [self.AddressPickerView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:borrowView];
        [self.AddressPickerView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:borrowView];
        [self.AddressPickerView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:borrowView];
    }
    return _uiuiView;
}

- (UIPickerView *)AddressPickerView
{
    if (!_AddressPickerView) {
        _AddressPickerView = [UIPickerView newAutoLayoutView];
        _AddressPickerView.delegate = self;
        _AddressPickerView.dataSource = self;
        _AddressPickerView.backgroundColor = [UIColor whiteColor];
    }
    return _AddressPickerView;
}

- (void)showPickerViewOfAddNew
{
    [self.view endEditing:YES];
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self.uiuiView];
    [self.uiuiView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

- (void)hiddenPickerViewOfAddNew
{
    [self.uiuiView removeFromSuperview];
}

- (NSMutableDictionary *)addNewDic
{
    if (!_addNewDic) {
        _addNewDic = [NSMutableDictionary dictionary];
    }
    return _addNewDic;
}

- (NSMutableArray *)nameArray
{
    if (!_nameArray) {
        _nameArray = [NSMutableArray array];
    }
    return _nameArray;
}

- (NSMutableArray *)idArray
{
    if (!_idArray) {
        _idArray = [NSMutableArray array];
    }
    return _idArray;
}

#pragma mark - delegate and datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier;
    if (indexPath.row == 0) {//名字
        identifier = @"add0";
        BorrowCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[BorrowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.leftTextFieldConstraint.constant = 60;
        cell.nameLabel.text = @"姓名";
        cell.nameTextField.placeholder = @"请输入收件人姓名";
        
        ZXWeakSelf;
        [cell setDidEndEditing:^(NSString *text) {
            [weakself.addNewDic setValue:text forKey:@"name"];
        }];
        
        return cell;
    }else if (indexPath.row == 1){//电话
        identifier = @"add1";
        BorrowCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[BorrowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.leftTextFieldConstraint.constant = 60;
        cell.nameLabel.text = @"电话";
        cell.nameTextField.placeholder = @"请输入11位手机号或0开头的固定电话";
        ZXWeakSelf;
        [cell setDidEndEditing:^(NSString *text) {
            [weakself.addNewDic setValue:text forKey:@"tel"];
        }];
        return cell;
    }else if (indexPath.row == 2){//地区
        identifier = @"add2";
        BorrowCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[BorrowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.leftTextFieldConstraint.constant = 60;
        cell.nameLabel.text = @"地区";
        cell.nameTextField.placeholder = @"请选择省市区";
        cell.nameTextField.userInteractionEnabled = NO;
        
        return cell;
    }else if (indexPath.row == 3){//详细地址
        identifier = @"add3";
        ExChangeDetailssCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[ExChangeDetailssCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.ssLabel setHidden:YES];
        cell.lefTextViewConstraints.constant = 12;
        
        cell.ssTextView.placeholder = @"填写详细地址";
        cell.ssTextView.font = font14;
        
        ZXWeakSelf;
        [cell setDidEndEditting:^(NSString *text) {
            [weakself.addNewDic setValue:text forKey:@"address"];
        }];
        
        return cell;
    }else if(indexPath.row == 4){//邮编
        identifier = @"add4";
        BorrowCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[BorrowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.leftTextFieldConstraint.constant = 60;
        cell.nameLabel.text = @"邮编";
        cell.nameTextField.placeholder = @"请输入收货地址邮编";
        
        ZXWeakSelf;
        [cell setDidEndEditing:^(NSString *text) {
            [weakself.addNewDic setValue:text forKey:@"zip"];
        }];
        
        return cell;
    }else{//AddressSwitchCell.h
        identifier = @"add5";
        AddressSwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[AddressSwitchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.addNewDic setObject:@"0" forKey:@"type"];
        
        ZXWeakSelf;
        [cell setDidSelestedSwitch:^(BOOL isOn) {
            if (isOn) {
                [weakself.addNewDic setObject:@"1" forKey:@"type"];
            }else{
                [weakself.addNewDic setObject:@"0" forKey:@"type"];
            }
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
    
    BasicButton *saveNewButton = [BasicButton newAutoLayoutView];
    [saveNewButton setTitle:@"保存" forState:0];
    [footerView addSubview:saveNewButton];
    [saveNewButton addTarget:self action:@selector(addNewaddressAction) forControlEvents:UIControlEventTouchUpInside];
    
    [saveNewButton autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:footerView withOffset:kBigPadding];
    [saveNewButton autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:footerView withOffset:kSmallPadding];
    [saveNewButton autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:footerView withOffset:-kSmallPadding];
    [saveNewButton autoSetDimension:ALDimensionHeight toSize:kCommitHeight];
    
    return footerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
//        [self showPickerViewOfAddNew];
        [self requestDataOfProvince];
    }
}

#pragma mark - pickView deledate and dataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (self.cityArray.count == 0) {
        return 1;
    }
    return 2;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return self.nameArray.count;
    }
    
    return self.cityArray.count;
}
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30;
}
//-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
//{
//    return 80;
//}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        return self.nameArray[row];
    }
    return self.cityArray[row][1];
}
//-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
//{
//    UILabel *pl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
//    pl.textColor = [UIColor blackColor];
//    pl.font = font14;
//    pl.textAlignment = NSTextAlignmentCenter;
//    
//    if (component == 0) {//省份
//        pl.text = self.nameArray[row];
//    }else if (component == 1){//城市
//        pl.text = self.cityArray[row][1];
//    }
//    
//    return pl;
//}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        [self.addNewDic setObject:self.nameArray[row] forKey:@"province"];
        [self.addNewDic setObject:self.idArray[row] forKey:@"provinceId"];
        [self requestDataOfCityWithId:self.idArray[row]];
    }else{
        [self.addNewDic setObject:self.cityArray[row][1] forKey:@"city"];
        [self.addNewDic setObject:self.cityArray[row][0] forKey:@"cityId"];
    }
}

#pragma mark - method
- (void)addNewaddressAction
{
    [self.view endEditing:YES];
    
    NSString *addString = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFReceiptAddressOfAdd];
    
    [self.addNewDic setValue:TOKEN forKey:@"token"];
    
    NSDictionary *params = self.addNewDic;
    
    ZXWeakSelf;
    [self requestDataPostWithUrlString:addString andParams:params andSuccessBlock:^(id responseObject) {
        BaseModel *baseModel = [BaseModel objectWithKeyValues:responseObject];

        [weakself showHint:baseModel.info];
        
        if ([baseModel.status integerValue] == 1) {
            [weakself back];
        }
    } andFailedBlock:^{
        
    }];
}

-(void)requestDataOfProvince
{
    NSString *provinceString = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFprovince];
    NSDictionary *param = @{@"token" : TOKEN};
    
    ZXWeakSelf;
    [self requestDataGetWithUrlString:provinceString paramter:param SucceccBlock:^(id responseObject){
        AraeModel *areaModel = [AraeModel objectWithKeyValues:responseObject];
        for (ProModel *proModel in areaModel.area) {
            [weakself.idArray addObject:proModel.ID];
            [weakself.nameArray addObject:proModel.name];
        }
        
        [weakself showPickerViewOfAddNew];
        [weakself.AddressPickerView reloadAllComponents];
    } andFailedBlock:^{
    }];
}

//request city
-(void)requestDataOfCityWithId:(NSString *)proID
{
    NSString *cityString = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFprovince];
    
    NSDictionary *params = @{
               @"token" : TOKEN,
               @"id" : proID
               };
    
    ZXWeakSelf;
    [self requestDataGetWithUrlString:cityString paramter:params SucceccBlock:^(id responseObject){
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        weakself.cityArray = dic.allValues;
        [weakself.AddressPickerView reloadAllComponents];
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
