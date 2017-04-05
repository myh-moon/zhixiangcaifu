//
//  EstimateViewController.m
//  zichanbao
//
//  Created by zhixiang on 16/12/27.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import "EstimateViewController.h"

#import "EstimateCell.h"
#import "EstimateTwoCell.h"

#import "UIViewController+BlurView.h"

@interface EstimateViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,assign) BOOL didSetupConstraints;
@property (nonatomic,strong) UITableView *estimateTableView;
@property (nonatomic,strong) UIView *calendarKeyView;

//json
@property (nonatomic,strong) NSMutableDictionary *estimateDic;

@end

@implementation EstimateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"房产预估";
    self.navigationItem.leftBarButtonItem  = self.leftItem;
    self.view.backgroundColor = kBackgroundColor;
    
    [self.view addSubview:self.estimateTableView];
    
    [self.view setNeedsUpdateConstraints];
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self.calendarKeyView];
    [self.calendarKeyView setHidden:YES];
    [self.calendarKeyView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

- (void)updateViewConstraints
{
    if (!self.didSetupConstraints) {
        
        [self.estimateTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
        
        self.didSetupConstraints = YES;
    }
    [super updateViewConstraints];
}

- (UITableView *)estimateTableView
{
    if (!_estimateTableView) {
        _estimateTableView = [UITableView newAutoLayoutView];
        _estimateTableView.backgroundColor = [UIColor whiteColor];
        _estimateTableView.delegate = self;
        _estimateTableView.dataSource = self;
        _estimateTableView.tableFooterView = [[UIView alloc] init];
    }
    return _estimateTableView;
}

- (UIView *)calendarKeyView
{
    if (!_calendarKeyView) {
        _calendarKeyView = [UIView newAutoLayoutView];
        _calendarKeyView.backgroundColor = kAlphaBackColor;
        
        UIButton *cancelButton = [UIButton newAutoLayoutView];
        cancelButton.backgroundColor = kBackgroundColor;
        [cancelButton setTitle:@"取消" forState:0];
        [cancelButton setTitleColor:kBlackColor forState:0];
        cancelButton.titleLabel.font = font14;
        [cancelButton setContentHorizontalAlignment:1];
        [cancelButton setContentEdgeInsets:UIEdgeInsetsMake(0, kBigPadding, 0, 0)];
        [_calendarKeyView addSubview:cancelButton];
        
        UIButton *okButton = [UIButton newAutoLayoutView];
        okButton.backgroundColor = kBackgroundColor;
        [okButton setTitle:@"确定" forState:0];
        [okButton setTitleColor:kBlackColor forState:0];
        okButton.titleLabel.font = font14;
        [okButton setContentHorizontalAlignment:2];
        [okButton setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, kBigPadding)];
        [_calendarKeyView addSubview:okButton];
        
        UIDatePicker *chDatePicker = [UIDatePicker newAutoLayoutView];
        chDatePicker.backgroundColor = kWhiteColor;
        chDatePicker.datePickerMode = UIDatePickerModeDate;
        [_calendarKeyView addSubview:chDatePicker];
        
        [cancelButton autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [cancelButton autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:chDatePicker];
        [cancelButton autoSetDimension:ALDimensionWidth toSize:kScreenWidth/2];
        [cancelButton autoSetDimension:ALDimensionHeight toSize:40];
        
        [okButton autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [okButton autoAlignAxis:ALAxisHorizontal toSameAxisOfView:cancelButton];
        [okButton autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:cancelButton];
        [okButton autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:cancelButton];
        
        [chDatePicker autoSetDimension:ALDimensionHeight toSize:kSmallCellHeight*6];
        [chDatePicker autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
        
        ZXWeakSelf;
        [cancelButton addAction:^(UIButton *btn) {
            [weakself hiddenDatePickerView];
        }];
        [okButton addAction:^(UIButton *btn) {
            [weakself hiddenDatePickerView];
            NSDate *selected = [chDatePicker date];
            NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
            [dateformatter setDateFormat:@"YYYY-MM-dd"];
            NSString *locationString=[dateformatter stringFromDate:selected];
            
            EstimateCell *cell = [weakself.estimateTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
            cell.esTextField.text = locationString;
            
            //params
            [weakself.estimateDic setValue:locationString forKey:@"comple_date"];
        }];
    }
    return _calendarKeyView;
}

- (NSMutableDictionary *)estimateDic
{
    if (!_estimateDic) {
        _estimateDic = [NSMutableDictionary dictionary];
    }
    return _estimateDic;
}

#pragma mark - delegate and datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 9;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < 8) {
        return kCellHeight1;
    }
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier;
    if (indexPath.row < 8) {
        identifier = @"es";
        EstimateCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[EstimateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.preservesSuperviewLayoutMargins = NO;
        cell.separatorInset = UIEdgeInsetsZero;
        cell.layoutMargins = UIEdgeInsetsZero;
        cell.esTypeButton.userInteractionEnabled = NO;
        [cell.esTypeButton setContentHorizontalAlignment:2];
       
        NSArray *texssss = @[@[@"房产地址",@"房产面积",@"房产类型",@"地下面积",@"年租金",@"竣工日期",@"所在楼层/总层",@"分配销售"],@[@"请输入",@"请输入",@"请选择",@"请输入",@"请输入",@"请输入",@"请输入",@"请输入"]];
        [cell.esNameButton setTitle:texssss[0][indexPath.row] forState:0];
        cell.esTextField.placeholder = texssss[1][indexPath.row];
        
        ZXWeakSelf;
        if (indexPath.row == 0) {
            [cell.esTypeButton setHidden:YES];
            cell.esTextField.userInteractionEnabled = YES;
            [cell setDidEndEditting:^(NSString *text) {
                [weakself.estimateDic setValue:text forKey:@"address"];
            }];
        }else if (indexPath.row == 1){
            [cell.esTypeButton setHidden:NO];
            [cell.esTypeButton setTitle:@"m²" forState:0];
            cell.esTextField.userInteractionEnabled = YES;
            [cell setDidEndEditting:^(NSString *text) {
                [weakself.estimateDic setValue:text forKey:@"spare"];
            }];
        }else if (indexPath.row == 2){
            [cell.esTypeButton setHidden:NO];
            [cell.esTypeButton setImage:[UIImage imageNamed:@"xialasjx"] forState:0];
            cell.esTextField.userInteractionEnabled = NO;
        }else if (indexPath.row == 3){
            [cell.esTypeButton setHidden:NO];
            [cell.esTypeButton setTitle:@"m²" forState:0];
            cell.esTextField.userInteractionEnabled = YES;
            [cell setDidEndEditting:^(NSString *text) {
                [weakself.estimateDic setValue:text forKey:@"narea"];
            }];
        }else if (indexPath.row == 4){
            [cell.esTypeButton setHidden:NO];
            [cell.esTypeButton setTitle:@"万" forState:0];
            cell.esTextField.userInteractionEnabled = YES;
            [cell setDidEndEditting:^(NSString *text) {
                [weakself.estimateDic setValue:text forKey:@"rent"];
            }];
        }else if (indexPath.row == 5){
            [cell.esTypeButton setHidden:NO];
            cell.esTextField.userInteractionEnabled = NO;
            [cell.esTypeButton setImage:[UIImage imageNamed:@"xialasjx"] forState:0];

        }else if (indexPath.row == 6){
            [cell.esTypeButton setHidden:NO];
            [cell.esTypeButton setTitle:@"层" forState:0];
            cell.esTextField.userInteractionEnabled = YES;
            [cell setDidEndEditting:^(NSString *text) {
                [weakself.estimateDic setValue:text forKey:@"layer"];
            }];
        }else if (indexPath.row == 7){
            [cell.esTypeButton setHidden:NO];
            cell.esTextField.userInteractionEnabled = NO;
            [cell.esTypeButton setImage:[UIImage imageNamed:@"xialasjx"] forState:0];
        }
        
        return cell;
    }else{
        identifier = @"esTwo";
        EstimateTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[EstimateTwoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.preservesSuperviewLayoutMargins = NO;
        cell.separatorInset = UIEdgeInsetsZero;
        cell.layoutMargins = UIEdgeInsetsZero;
        
        [cell.etButton2 setTitle:@"提交" forState:0];
        [cell.etButton3 setTitle:@"取消" forState:0];
        
        ZXWeakSelf;
        [cell.etButton2 addAction:^(UIButton *btn) {
            [weakself addEstimatePro];
        }];
        [cell.etButton3 addAction:^(UIButton *btn) {
            [weakself back];
        }];
        
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {//房产类型
        [self getListOfHouseType];
    }else if (indexPath.row == 5){//竣工日期
        [self showDatePickerView];
    }else if (indexPath.row == 7){//分配销售
        [self getListOfSalesPerson];
    }
}

#pragma mark - method

- (void)getListOfHouseType
{
    NSString *houseType = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFChannelOfEstimateHouseTypeString];
    NSDictionary *params = @{@"token" : TOKEN};
    
    ZXWeakSelf;
    [self requestDataGetWithUrlString:houseType paramter:params SucceccBlock:^(id responseObject) {
        NSDictionary *houDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
       
        if ([houDic[@"status"] integerValue] == 1) {
            
            [weakself showBlurInView:self.view withArray:[houDic[@"list"] allValues] andTitle:@"请选择房产类型" finishBlock:^(NSString *text, NSInteger row){
                EstimateCell *cell = [weakself.estimateTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
                cell.esTextField.text = text;
                
                NSString *ioio = [houDic[@"list"] allKeys][row-1];
                [weakself.estimateDic setValue:ioio forKey:@"type"];
            }];
        }else{
            [weakself showHint:houDic[@"info"]];
        }
    } andFailedBlock:^{
        
    }];
}

- (void)getListOfSalesPerson
{
    NSString *salesPerson = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFChannelOfEstimateSalesString];
    NSDictionary *params = @{@"token" : TOKEN};
    
    ZXWeakSelf;
    [self requestDataGetWithUrlString:salesPerson paramter:params SucceccBlock:^(id responseObject) {
        
        NSDictionary *salesDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        if ([salesDic[@"status"] integerValue] == 1 && [salesDic[@"seller_list"] count] > 0) {
            
            NSMutableArray *idArray = [NSMutableArray array];
            NSMutableArray *nameArray = [NSMutableArray array];
            for (NSInteger i=0; i<[salesDic[@"seller_list"] count]; i++) {
                NSDictionary *aaa = salesDic[@"seller_list"][i];
                [idArray addObject:aaa.allKeys[0]];
                [nameArray addObject:aaa.allValues[0]];
            }
            
            [weakself showBlurInView:self.view withArray:nameArray andTitle:salesDic[@"info"] finishBlock:^(NSString *text, NSInteger row){
                EstimateCell *cell = [weakself.estimateTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:7 inSection:0]];
                cell.esTextField.text = text;
                
                NSString *popo = idArray[row-1];
                [weakself.estimateDic setValue:popo forKey:@"apply_id"];
            }];
        }else if ([salesDic[@"status"] integerValue] == 1 &&[salesDic[@"seller_list"] count] == 0){
            [weakself showHint:@"暂无销售"];
        }else{
            [weakself showHint:salesDic[@"info"]];
        }
        
    } andFailedBlock:^{
        
    }];
}

- (void)addEstimatePro
{
    [self.view endEditing:YES];
    
    NSString *estimateString = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFChannelOfEstimateAddString];
    
    [self.estimateDic setValue:TOKEN forKey:@"token"];
    
    NSDictionary *params = self.estimateDic;

    ZXWeakSelf;
    [self requestDataPostWithUrlString:estimateString andParams:params andSuccessBlock:^(id responseObject) {
        BaseModel *baseModel = [BaseModel objectWithKeyValues:responseObject];
        [weakself showHint:baseModel.info];
        if ([baseModel.status integerValue] == 1) {
            [weakself back];
        }
    } andFailedBlock:^{
        
    }];
}

- (void)showDatePickerView
{
    [self.calendarKeyView setHidden:NO];
}

- (void)hiddenDatePickerView
{
    [self.calendarKeyView setHidden:YES];
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
