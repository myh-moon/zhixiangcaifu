//
//  OpenCreditViewController.m
//  zichanbao
//
//  Created by zhixiang on 17/2/15.
//  Copyright © 2017年 zhixiang. All rights reserved.
//

#import "OpenCreditViewController.h"
#import "UIImage+Color.h"

#import "BorrowCell.h"
#import "OnesCell.h"

#import "StepView.h"
#import "AnotherAlertView.h"

@interface OpenCreditViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,assign)BOOL didSetupConstraints;
@property (nonatomic,strong) UIButton *aBackButton;
@property (nonatomic,strong) UILabel *aTitleLabel;
@property (nonatomic,strong)StepView *stepView;
@property (nonatomic,strong) UITableView *stepTableView;
@property (nonatomic,strong) AnotherAlertView *codeAlertView;
@property (nonatomic,strong) AnotherAlertView *resetAlertView;

@property (nonatomic,strong)NSString *stepString ; //标记步骤
@property (nonatomic,strong)NSMutableDictionary *openCreditDic;   //params

@end

@implementation OpenCreditViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg"]forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"开启征信之旅";
    self.navigationItem.leftBarButtonItem = self.leftItem;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
    [self.rightButton setTitle:@"下一步" forState:0];
    
    self.stepString = @"1";
    
    [self.view addSubview:self.stepView];
    [self.view addSubview:self.stepTableView];
    
    [self.view setNeedsUpdateConstraints];
}

- (void)updateViewConstraints
{
    if (!self.didSetupConstraints) {
        
        [self.stepView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeBottom];
        [self.stepView autoSetDimension:ALDimensionHeight toSize:120];
        
        [self.stepTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
        [self.stepTableView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.stepView];
        
        self.didSetupConstraints = YES;
    }
    [super updateViewConstraints];
}

- (UIButton *)aBackButton
{
    if (!_aBackButton) {
        _aBackButton = [UIButton newAutoLayoutView];
        [_aBackButton setTitle:@"< 返回" forState:0];
        [_aBackButton setTitleColor:RGBCOLOR(0.6510, 0.5843, 0.6314) forState:0];
        _aBackButton.titleLabel.font = [UIFont systemFontOfSize:17];
    }
    return _aBackButton;
}

- (UILabel *)aTitleLabel
{
    if(_aTitleLabel){
        _aTitleLabel = [UILabel newAutoLayoutView];
        _aTitleLabel.text = @"开启征信之旅";
        _aTitleLabel.font = font17;
        _aTitleLabel.textColor = kWhiteColor;
    }
    return _aTitleLabel;
}

- (StepView *)stepView
{
    if (!_stepView) {
        _stepView = [StepView newAutoLayoutView];
        [_stepView setBackgroundImage:[UIImage imageNamed:@"stepbg"] forState:0];
    }
    return _stepView;
}

- (UITableView *)stepTableView
{
    if (!_stepTableView) {
        _stepTableView = [UITableView newAutoLayoutView];
        _stepTableView.delegate = self;
        _stepTableView.dataSource = self;
        _stepTableView.tableFooterView = [[UIView alloc] init];
        _stepTableView.backgroundColor = kBackgroundColor;
    }
    return _stepTableView;
}

- (AnotherAlertView *)codeAlertView
{
    if (!_codeAlertView) {
        _codeAlertView = [AnotherAlertView newAutoLayoutView];
        _codeAlertView.backgroundColor = kAlphaBackColor;
        [_codeAlertView.aTitleButton setBackgroundImage:[UIImage imageNamed:@"duanxin"] forState:0];
        _codeAlertView.aTextField.placeholder = @"请输入短信验证码";
        [_codeAlertView.aLeftButton setTitle:@"取消" forState:0];
        [_codeAlertView.aRightButton setTitle:@"提交" forState:0];
        
        ZXWeakSelf;
        [_codeAlertView setDidEndEditting:^(NSString *text) {
            [weakself.openCreditDic setValue:text forKey:@""];
        }];
        [_codeAlertView setDidSelectedBtn:^(NSInteger tag) {
            [weakself.codeAlertView removeFromSuperview];
            if (tag == 67) {
            }else if (tag == 68){
                [weakself showResetCode2];
            }
        }];
    }
    return _codeAlertView;
}

- (AnotherAlertView *)resetAlertView
{
    if (!_resetAlertView) {
        _resetAlertView = [AnotherAlertView newAutoLayoutView];
        _resetAlertView.backgroundColor = kAlphaBackColor;
        [_resetAlertView.aTitleButton setBackgroundImage:[UIImage imageNamed:@"chongzhi"] forState:0];
        _resetAlertView.aTextField.placeholder = @"请输入新密码";
        [_resetAlertView.aLeftButton setTitle:@"取消" forState:0];
        [_resetAlertView.aRightButton setTitle:@"确认修改" forState:0];
        
        ZXWeakSelf;
        [_resetAlertView setDidEndEditting:^(NSString *text) {
            [weakself.openCreditDic setValue:text forKey:@""];
        }];
        [_resetAlertView setDidSelectedBtn:^(NSInteger tag) {
            [weakself.resetAlertView removeFromSuperview];
            if (tag == 67) {
            }else if (tag == 68){
            }
        }];
    }
    return _resetAlertView;
}

- (NSMutableDictionary *)openCreditDic
{
    if (!_openCreditDic) {
        _openCreditDic = [NSMutableDictionary dictionary];
    }
    return _openCreditDic;
}

#pragma mark - tableview delegate and datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.stepString integerValue] == 1) {
        return 4;
    }else if ([self.stepString integerValue] == 2){
        return 3;
    }else if ([self.stepString integerValue] == 3){
        return 5;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier;
    if ([self.stepString integerValue] == 1) {
        if (indexPath.row < 3) {
            identifier = @"step1";
            BorrowCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell) {
                cell = [[BorrowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.leftTextFieldConstraint.constant = 80;
            
            NSArray *sss = @[@"姓    名",@"手机号",@"身份证"];
            NSArray *rrr = @[@"请填写您的姓名",@"请填写您的手机号",@"请填写您的身份证号码"];
            cell.nameLabel.text = sss[indexPath.row];
            cell.nameTextField.placeholder = rrr[indexPath.row];
            
            ZXWeakSelf;
            [cell setDidEndEditing:^(NSString *text) {
                if (indexPath.row == 0) {
                    [weakself.openCreditDic setValue:text forKey:@"0"];
                }else if (indexPath.row == 1){
                    [weakself.openCreditDic setValue:text forKey:@"1"];
                }else if (indexPath.row == 2){
                    [weakself.openCreditDic setValue:text forKey:@"2"];
                }
            }];
            return cell;
        }
        identifier = @"step13";
        OnesCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[OnesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = kBackgroundColor;
        cell.oneButton.userInteractionEnabled = NO;
        
        [cell.oneButton setTitle:@"需同意该协议" forState:0];
        [cell.oneButton setTitleColor:kNavigationColor forState:0];
        cell.oneButton.titleLabel.font = font14;
        return cell;
    }else if ([self.stepString integerValue] == 2){
        if (indexPath.row < 2) {
            identifier = @"step21";
            BorrowCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell) {
                cell = [[BorrowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.leftTextFieldConstraint.constant = 80;
            
            NSArray *sss = @[@"手  机  号",@"服务密码"];
            NSArray *rrr = @[@"请填写您的手机号",@"请输入运营商服务密码"];
            cell.nameLabel.text = sss[indexPath.row];
            cell.nameTextField.placeholder = rrr[indexPath.row];
            
            ZXWeakSelf;
            [cell setDidEndEditing:^(NSString *text) {
                if (indexPath.row == 0) {
                    [weakself.openCreditDic setValue:text forKey:@"0"];
                }else if (indexPath.row == 1){
                    [weakself.openCreditDic setValue:text forKey:@"1"];
                }else if (indexPath.row == 2){
                    [weakself.openCreditDic setValue:text forKey:@"2"];
                }
            }];
            return cell;
        }
        identifier = @"step22";
        OnesCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[OnesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = kBackgroundColor;
        cell.oneButton.userInteractionEnabled = NO;
        
        [cell.oneButton setTitle:@"忘记服务密码？点我重置" forState:0];
        [cell.oneButton setTitleColor:kNavigationColor forState:0];
        cell.oneButton.titleLabel.font = font14;
        return cell;
    }else if ([self.stepString integerValue] == 3){
        if (indexPath.row < 2) {
            identifier = @"step31";
            BorrowCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell) {
                cell = [[BorrowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.leftTextFieldConstraint.constant = 80;
            
            NSArray *sss = @[@"账  号",@"密  码"];
            NSArray *rrr = @[@"请输入人行征信账号",@"请输入人行征信密码"];
            cell.nameLabel.text = sss[indexPath.row];
            cell.nameTextField.placeholder = rrr[indexPath.row];
            
            ZXWeakSelf;
            [cell setDidEndEditing:^(NSString *text) {
                if (indexPath.row == 0) {
                    [weakself.openCreditDic setValue:text forKey:@"30"];
                }else if (indexPath.row == 1){
                    [weakself.openCreditDic setValue:text forKey:@"31"];
                }
            }];
            return cell;
        }else if (indexPath.row >= 2 && indexPath.row < 4){
            identifier = @"step33";
            BorrowCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell) {
                cell = [[BorrowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.nameLabel setHighlighted:YES];
            cell.leftTextFieldConstraint.constant = kSmallPadding;
            
            NSArray *rrr = @[@"请输入人行身份（短信）验证码",@"请输入图像验证码"];
            cell.nameTextField.placeholder = rrr[indexPath.row - 2];
            
            return cell;
        }
        identifier = @"step34";
        OnesCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[OnesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = kBackgroundColor;
        cell.oneButton.userInteractionEnabled = NO;
        
        [cell.oneButton setTitle:@"看不清？换一个" forState:0];
        [cell.oneButton setTitleColor:kNavigationColor forState:0];
        cell.oneButton.titleLabel.font = font14;
        return cell;

    }else if ([self.stepString integerValue] == 4){
        identifier = @"step4";
        OnesCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[OnesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = kBackgroundColor;
        cell.oneButton.titleLabel.font = font14;
        [cell.oneButton setTitle:@"数据采集中......" forState:0];
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if ([self.stepString integerValue] == 2) {
        return kScreenHeight-self.stepView.height-kCellHeight*4-64;
    }
    return kScreenHeight-self.stepView.height-kCellHeight*5-64;

}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIButton *footerView = [[UIButton alloc] init];
    footerView.titleLabel.font = font12;
    [footerView setTitleColor:kNavigationColor forState:0];
    footerView.titleLabel.numberOfLines = 0;
 
    switch ([self.stepString integerValue]) {
        case 1:
            [footerView setTitle:@" " forState:0];
            break;
        case 2:{
            [footerView setContentHorizontalAlignment:1];
            [footerView setContentVerticalAlignment:2];
            [footerView setContentEdgeInsets:UIEdgeInsetsMake(0, kSmallPadding, 0, kSmallPadding)];
            [footerView setTitle:@"提交您的手机信息进行认证，我们会收集您的身份、账单、通话信息等用于认证。\n运营商会发短信告知您，我们从网上营业厅查询过您的详单，这是认证您信息的正常过程。" forState:0];
        }
            break;
        case 3:{
            [footerView setContentHorizontalAlignment:0];
            [footerView setContentVerticalAlignment:2];
            [footerView setContentEdgeInsets:UIEdgeInsetsMake(0, kSmallPadding, kSmallPadding*2, kSmallPadding)];
            [footerView setTitle:@"  如何申请人行征信报告？" forState:0];
            [footerView setImage:[UIImage imageNamed:@"hands"] forState:0];
            ZXWeakSelf;
            [footerView addAction:^(UIButton *btn) {
                [weakself showHint:@"查看如何申请征信"];
            }];
        }
            break;
        case 4:
            [footerView setTitle:@" " forState:0];
            break;
        default:
            break;
    }
    
    return footerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch ([self.stepString integerValue]) {
        case 1:{
            if (indexPath.row == 3) {
                [self showHint:@"协议"];
            }
        }
            break;
        case 2:{
            if (indexPath.row == 2) {
                [self showResetCode1];
            }
            }
            break;
        case 3:{
            if (indexPath.row == 4) {
                [self showHint:@"看不清，换一个"];
            }
        }
            break;
        default:
            break;
    }
}

#pragma mark - method
- (void)rightAction
{
    if ([self.stepString integerValue] == 1) {
        //1.变色
        self.stepView.stepLine1.backgroundColor = kWhiteColor;
        [self.stepView.stepButton2 setBackgroundColor:kWhiteColor];
        
        //2
        self.stepString = @"2";
        [self.stepTableView reloadData];
    }else if ([self.stepString integerValue] == 2){
        self.stepView.stepLine2.backgroundColor = kWhiteColor;
        [self.stepView.stepButton3 setBackgroundColor:kWhiteColor];

        self.stepString = @"3";
        [self.stepTableView reloadData];
    }else if ([self.stepString integerValue] == 3){
        self.stepView.stepLine3.backgroundColor = kWhiteColor;
        [self.stepView.stepButton4 setBackgroundColor:kWhiteColor];
        
        self.stepString = @"4";
        [self.rightButton setTitle:@" " forState:0];
        [self.stepTableView reloadData];
    }
}

-(void)showResetCode1
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self.codeAlertView];
    [self.codeAlertView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

- (void)showResetCode2
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self.resetAlertView];
    [self.resetAlertView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
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
