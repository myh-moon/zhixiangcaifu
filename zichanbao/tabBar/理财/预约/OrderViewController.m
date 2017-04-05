//
//  OrderViewController.m
//  zichanbao
//
//  Created by zhixiang on 15/11/17.
//  Copyright © 2015年 zhixiang. All rights reserved.
//

#import "OrderViewController.h"
#import "DetailsView.h"
#import "IntermAgreementViewController.h"  //借款协议
#import "OrderFinishViewController.h"    //预约成功
#import "AuthentyViewController.h"   //认证

#import "BorrowCell.h"
#import "BorrowBaseCell.h"

@interface OrderViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIAlertViewDelegate>

@property (nonatomic,assign) BOOL didSetupConstarint;
@property (nonatomic,strong) UITableView *myOrderTableView;
@property (nonatomic,strong) DetailsView *topView;

@property (nonatomic,strong) NSMutableDictionary *orderDataDic;

@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBackgroundColor;
    self.navigationItem.title = @"预约";
    self.navigationItem.leftBarButtonItem = self.leftItem;
    
    [self.view addSubview:self.myOrderTableView];
    
    [self.view setNeedsUpdateConstraints];
    
}

- (void)updateViewConstraints
{
    if (!self.didSetupConstarint) {
        
        [self.myOrderTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
        
        self.didSetupConstarint = YES;
    }
    [super updateViewConstraints];
}

#pragma mark - init
-(UITableView *)myOrderTableView
{
    if (!_myOrderTableView) {
        _myOrderTableView.translatesAutoresizingMaskIntoConstraints = NO;
        _myOrderTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _myOrderTableView.backgroundColor = kBackgroundColor;
        _myOrderTableView.delegate = self;
        _myOrderTableView.dataSource = self;
        _myOrderTableView.tableFooterView = [[UIView alloc] init];
    }
    return _myOrderTableView;
}
-(DetailsView *)topView
{
    if (!_topView) {
        _topView = [[DetailsView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, 170)];
        [_topView.typeBtn1 setTitle:self.orderModel.borrow_type forState:0];
        _topView.nameLabel.text = self.orderModel.borrow_name;
        _topView.rateLabel1.text = @"年化率";
        _topView.rateLabel2.text = self.orderModel.borrow_interest_rate;
        _topView.timeLabel1.text = @"借款时间";
        _topView.timeLabel2.text = self.orderModel.borrow_duration;
        _topView.progressView.progress = [self.orderModel.progress floatValue]*0.01;
        
//        NSString *progressStr1 = @"已预约";
//        NSString *progressStr2 = self.orderModel.progress;
//        NSString *progressStr = [NSString stringWithFormat:@"%@%@",progressStr1,progressStr2];
        
        NSMutableAttributedString *leftString = [NSString getStringFromFirstString:@"已预约" andFirstColor:kBlackColor andFirstFont:font12 ToSecondString:self.orderModel.progress andSecondColor:kNavigationColor andSecondFont:font12];
        [_topView.leftLabel setAttributedText:leftString];
        
        NSString *sy_moneyStr = [NSString stringWithFormat:@"%@元",self.orderModel.sy_money];
        NSMutableAttributedString *rightString = [NSString getStringFromFirstString:@"剩余总额" andFirstColor:kBlackColor andFirstFont:font12 ToSecondString:sy_moneyStr andSecondColor:kNavigationColor andSecondFont:font12];
        [_topView.rightLabel setAttributedText:rightString];
        
        NSString *borrow_min = [NSString stringWithFormat:@"%@元",self.orderModel.borrow_min];
        NSMutableAttributedString *startMoney = [NSString getStringFromFirstString:@"起投金额" andFirstColor:kBlackColor andFirstFont:font12 ToSecondString:borrow_min andSecondColor:kNavigationColor andSecondFont:font12];
        [_topView.startMomeyLabel setAttributedText:startMoney];
        _topView.wayLabel.text = self.orderModel.repayment_type;
    }
    return _topView;
}

- (NSMutableDictionary *)orderDataDic
{
    if (!_orderDataDic) {
        _orderDataDic = [NSMutableDictionary dictionary];
    }
    return _orderDataDic;
}

#pragma mark - tableView delegate and dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return 3;
    }
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 170;
    }
    return 50;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier;
    
    if (indexPath.section == 0) {
        identifier = @"myDetailOrder0";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell addSubview:self.topView];
        return cell;
    }else if (indexPath.section == 1){
        identifier = @"myDetailOrder1";
        BorrowCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[BorrowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSArray *orderArray1 = @[@"预约金额",@"预约人",@"联系电话"];
        cell.nameLabel.text = orderArray1[indexPath.row];
    
        if (indexPath.row == 0) {
            cell.nameTextField.userInteractionEnabled = YES;
            cell.nameTextField.placeholder = @"请输入预约金额";
            [cell.nameButton setHidden:NO];
            [cell.nameButton setTitle:@"元" forState:0];
            
            ZXWeakSelf;
            [cell setDidEndEditing:^(NSString *text) {
                [weakself.orderDataDic setValue:text forKey:@"money"];
            }];
            
        }else if (indexPath.row == 1){
            cell.nameTextField.userInteractionEnabled = NO;
            if (self.orderModel.name) {
                cell.nameTextField.text = self.orderModel.name;
                cell.nameTextField.textColor = [UIColor lightGrayColor];
            }
            [cell.nameButton setHidden:YES];
            
        }else if (indexPath.row == 2){
            cell.nameTextField.userInteractionEnabled = NO;
            if (self.orderModel.phone) {
                cell.nameTextField.text = self.orderModel.phone;
                cell.nameTextField.textColor = [UIColor lightGrayColor];
            }else{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"身份未认证" message:@"预约需身份认证" delegate:self cancelButtonTitle:@"是" otherButtonTitles:nil, nil];
                alertView.delegate = self;
                [alertView show];
            }
            [cell.nameButton setHidden:YES];
        }
        return cell;
        
    }else if (indexPath.section == 2){
        identifier = @"myDetailOrder2";
        BorrowBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[BorrowBaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell.leftButton setTitle:@"借款协议" forState:0];
        [cell.rightButton setImage:[UIImage imageNamed:@"list_more"] forState:0];
        
        return cell;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 2) {
        return 100;
    }
    return 10;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 2) {
        UIView *myOrderFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
        
        //同意上述协议
        UIButton *b1 = [UIButton buttonWithType:0];
        b1.frame = CGRectMake((kScreenWidth-100)/2, 10, 100, 20);
        [b1 setImage:[UIImage imageNamed:@"kuang"] forState:0];
        [b1 setImage:[UIImage imageNamed:@"yougou"] forState:UIControlStateSelected];
        [b1 setTitle:@"  同意以上协议" forState:0];
        [b1 setTitleColor:[UIColor lightGrayColor] forState:0];
        b1.titleLabel.font = [UIFont systemFontOfSize:12];
        [myOrderFooterView addSubview:b1];
        [b1 addAction:^(UIButton *btn) {
            btn.selected = !btn.selected;
        }];
        
        //预约
        UIButton *b2 = [UIButton buttonWithType:0];
        b2.frame = CGRectMake((kScreenWidth-100)/2, b1.bottom+10, 100, 40);
        [b2 setBackgroundColor:kNavigationColor];
        [b2 setTitleColor:[UIColor whiteColor] forState:0];
        b2.layer.cornerRadius = 2;
        [b2 setTitle:@"预约" forState:0];
        [myOrderFooterView addSubview:b2];
        ZXWeakSelf;
        [b2 addAction:^(UIButton *btn) {
            if (b1.selected) {
                [weakself requestDataOfOrderFinish];
            }else{
                
                [self showHint:@"需同意协议"];
            }
        }];
        return myOrderFooterView;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        //借款协议
        IntermAgreementViewController *intermAgreementVC = [[IntermAgreementViewController alloc] init];
        intermAgreementVC.titleString = @"借款协议";
        intermAgreementVC.urlString = [NSString stringWithFormat:@"%@%@",ZXCF,self.orderModel.url];
        [self.navigationController pushViewController:intermAgreementVC animated:YES];
    }
}

#pragma mark - alertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        //去认证
        AuthentyViewController *authentyVC = [[AuthentyViewController alloc] init];
        [self.navigationController pushViewController:authentyVC animated:YES];
    }
}

#pragma mark - request data
-(void)requestDataOfOrderFinish
{
    [self.view endEditing:YES];
    NSString *orderFinishString = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCForderFinish];
    
    [self.orderDataDic setValue:TOKEN forKey:@"token"];
    [self.orderDataDic setValue:self.borrowID forKey:@"borrow_id"];
    [self.orderDataDic setValue:self.orderModel.name forKey:@"name"];
    [self.orderDataDic setValue:self.orderModel.phone forKey:@"phone"];
    [self.orderDataDic setValue:@"1" forKey:@"is_phone"];
    
    NSDictionary *params = self.orderDataDic;
    
    ZXWeakSelf;
    [self requestDataPostWithUrlString:orderFinishString andParams:params andSuccessBlock:^(id responseObject){
        
        BaseModel *finishModel = [BaseModel objectWithKeyValues:responseObject];
        
        [weakself showHint:finishModel.info];
        
        if ([finishModel.status intValue] == 1) {//预约成功
            OrderFinishViewController *orderFinishVC = [[OrderFinishViewController alloc] init];
            orderFinishVC.phoneString = weakself.orderModel.phone;
            orderFinishVC.remindString = finishModel.info;
            [weakself.navigationController pushViewController:orderFinishVC animated:YES];
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
