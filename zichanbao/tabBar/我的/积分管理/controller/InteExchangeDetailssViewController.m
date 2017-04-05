//
//  InteExchangeDetailssViewController.m
//  zichanbao
//
//  Created by zhixiang on 16/11/9.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import "InteExchangeDetailssViewController.h"
#import "MineReceiptAddressViewController.h"  //收货地址
#import "RecordsInteViewController.h" //兑换记录

#import "BorrowBaseCell.h"
#import "ExChangeDetailssCell.h"
#import "PayCell.h"
#import "PayAddressCell.h"
#import "OnesCell.h"
#import "PayNumberCell.h"

#import "InteExchModel.h"

#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"

@interface InteExchangeDetailssViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,assign) BOOL didSetupConstraints;
@property (nonatomic,strong) UITableView *excTableView;
@property (nonatomic,strong) UIButton *payButton;

//json
@property (nonatomic,strong) NSMutableDictionary *buyDic;
@property (nonatomic,assign) BOOL choose;  //标记是否已选择地址
@property (nonatomic,assign) NSInteger number;  //购买产品数量

@property (nonatomic, strong) UITableViewCell *prototypeCell;

@end

@implementation InteExchangeDetailssViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"确认订单";
    self.navigationItem.leftBarButtonItem = self.leftItem;
    
    self.prototypeCell  = [self.excTableView dequeueReusableCellWithIdentifier:@"eddd21"];
    
    [self.view addSubview:self.excTableView];
    [self.view addSubview:self.payButton];
    
    [self.view setNeedsUpdateConstraints];
    
}

- (void)updateViewConstraints
{
    if (!self.didSetupConstraints) {
        
        [self.excTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
        [self.excTableView autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.payButton];
        
        [self.payButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
        [self.payButton autoSetDimension:ALDimensionHeight toSize:56];
        
        self.didSetupConstraints = YES;
    }
    [super updateViewConstraints];
}

- (UITableView *)excTableView
{
    if (!_excTableView) {
        _excTableView.translatesAutoresizingMaskIntoConstraints = NO;
        _excTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _excTableView.backgroundColor = kBackgroundColor;
        _excTableView.delegate = self;
        _excTableView.dataSource = self;
        _excTableView.estimatedRowHeight = 37.0;
        _excTableView.rowHeight = UITableViewAutomaticDimension;
    }
    return _excTableView;
}

- (UIButton *)payButton
{
    if (!_payButton) {
        _payButton = [UIButton newAutoLayoutView];
        _payButton.backgroundColor = [UIColor whiteColor];
        [_payButton setTitleEdgeInsets:UIEdgeInsetsMake(0, kSmallPadding, 0, 0)];
        [_payButton setContentHorizontalAlignment:1];
        
        ZXWeakSelf;
        [_payButton addAction:^(UIButton *btn) {
            NSString *aaaa = [NSString stringWithFormat:@"%@积分＋%@元",weakself.productModel.list.score,weakself.productModel.list.smoney];
            [weakself showBuyAlertViewWithTitle:aaaa];
        }];
        
        if (_number == 0) {
            NSString *qqqq1 = @"应付款:";
            NSString *qqqq2 = self.productModel.list.score;
            NSString *qqqq3 = @"积分+";
            NSString *qqqq4 = self.productModel.list.smoney;
            NSString *qqqq5 = @"元";
            NSString *qqqq = [NSString stringWithFormat:@"%@%@%@%@%@",qqqq1,qqqq2,qqqq3,qqqq4,qqqq5];
            NSMutableAttributedString *attributeQQ = [[NSMutableAttributedString alloc] initWithString:qqqq];
            [attributeQQ setAttributes:@{NSFontAttributeName:font14,NSForegroundColorAttributeName:[UIColor lightGrayColor]} range:NSMakeRange(0, qqqq1.length)];
            [attributeQQ setAttributes:@{NSFontAttributeName:font18,NSForegroundColorAttributeName:kRedColor} range:NSMakeRange(qqqq1.length, qqqq2.length)];
            [attributeQQ setAttributes:@{NSFontAttributeName:font14,NSForegroundColorAttributeName:[UIColor lightGrayColor]} range:NSMakeRange(qqqq1.length+qqqq2.length, qqqq3.length)];
            [attributeQQ setAttributes:@{NSFontAttributeName:font18,NSForegroundColorAttributeName:kRedColor} range:NSMakeRange(qqqq1.length+qqqq2.length+qqqq3.length, qqqq4.length)];
            [attributeQQ setAttributes:@{NSFontAttributeName:font14,NSForegroundColorAttributeName:[UIColor lightGrayColor]} range:NSMakeRange(qqqq1.length+qqqq2.length+qqqq3.length+qqqq4.length, qqqq5.length)];
            [_payButton setAttributedTitle:attributeQQ forState:0];
        }
        
        //我要兑换按钮
        UIButton *exchangeButton = [UIButton newAutoLayoutView];
        [exchangeButton setTitleColor:[UIColor whiteColor] forState:0];
        [exchangeButton setTitle:@"我要兑换" forState:0];
        exchangeButton.titleLabel.font = font16;
        exchangeButton.backgroundColor = kNavigationColor;
        exchangeButton.layer.cornerRadius = 15;
        exchangeButton.userInteractionEnabled = NO;
        [_payButton addSubview:exchangeButton];
        
        [exchangeButton autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:_payButton withOffset:-kSmallPadding];
        [exchangeButton autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_payButton];
        [exchangeButton autoSetDimension:ALDimensionWidth toSize:100];
    }
    return _payButton;
}

- (NSMutableDictionary *)buyDic
{
    if (!_buyDic) {
        _buyDic = [NSMutableDictionary dictionary];
    }
    return _buyDic;
}

#pragma mark - delegate and datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2 || section == 4) {
        return 2;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 100;
    }else if (indexPath.section == 1){
        UIImageView *v1 = [UIImageView new];
        [v1 sd_setImageWithURL:[NSURL URLWithString:self.productModel.list.bimg] placeholderImage:nil options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            v1.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        }];
        
        return v1.height;
        
    }else if (indexPath.section == 2 && indexPath.row == 1){
        NSString *infoString = self.productModel.list.remark;
        CGSize constraint = CGSizeMake(kScreenWidth/2, 100);
        CGSize size = [infoString sizeWithFont:font12 constrainedToSize:constraint lineBreakMode:UILineBreakModeCharacterWrap];
        CGFloat height = MAX(size.height, 14);
        return height + 20;
    }else if (indexPath.section == 3){
        return 70;
    }
    return 35;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier;
    if (indexPath.section == 0) {
        if (!_choose) {//初始状态
            if (!self.productModel.address) {//无默认地址
                identifier = @"eddd0";
                OnesCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
                if (!cell) {
                    cell = [[OnesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.oneButton.userInteractionEnabled = NO;
                [cell.oneButton setImage:[UIImage imageNamed:@"querenddad"] forState:0];
                [cell.oneButton setTitle:@"     ＋请添加收获地址" forState:0];
                
                return cell;
            }else{//有默认地址
                identifier = @"eddd00";
                PayAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
                if (!cell) {
                    cell = [[PayAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.addressButton.userInteractionEnabled = NO;
                
                [cell.addressImageView setImage:[UIImage imageNamed:@"querddaddicon"]];
                cell.nameLabel.text = [NSString stringWithFormat:@"收货人：%@",self.productModel.address.name];
                cell.phoneLabel.text = self.productModel.address.tel;
                NSString *address = [NSString stringWithFormat:@"%@",self.productModel.address.address];
                [cell.addressButton setTitle:address forState:0];
                [cell.addressButton setTitleColor:[UIColor blackColor] forState:0];
                cell.ideaLabel.text = @"(收获不便时，可选择免费代收货服务)";
                
                [self.buyDic setValue:self.productModel.address.ID forKey:@"aid"];
                
                return cell;
            }
        }else{//选择了收货地址
            identifier = @"eddd00";
            PayAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell) {
                cell = [[PayAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.addressButton.userInteractionEnabled = NO;
            
            AddressModel *addressModle = self.buyDic[@"addressModel"];
            
            [cell.addressImageView setImage:[UIImage imageNamed:@"querddaddicon"]];
            cell.nameLabel.text = [NSString stringWithFormat:@"收货人：%@",addressModle.name];
            cell.phoneLabel.text = addressModle.tel;
            NSString *address = [NSString stringWithFormat:@"%@",addressModle.address];
            [cell.addressButton setTitle:address forState:0];
            [cell.addressButton setTitleColor:[UIColor blackColor] forState:0];
            cell.ideaLabel.text = @"(收获不便时，可选择免费代收货服务)";
            
            return cell;
        }
    }else if (indexPath.section == 1){
        identifier = @"eddd1";
        BorrowBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[BorrowBaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.leftButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
        [cell.leftButton autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        
        [cell.leftButton sd_setImageWithURL:[NSURL URLWithString:self.productModel.list.bimg] forState:0 placeholderImage:nil];
        
        return cell;
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            identifier = @"eddd20";
            PayNumberCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell) {
                cell = [[PayNumberCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.ppButton setTitle:self.productModel.list.name forState:0];
            
            if (_number == 0) {
                cell.addNumberView.numberLabel.text = @"1";
            }
            
            ZXWeakSelf;
            [cell.addNumberView setDidSelected:^(NSInteger tag) {
                
                _number = [cell.addNumberView.numberLabel.text integerValue];

                [tableView reloadData];
                
                NSString *qqqq1 = @"应付款:";
                NSString *qqqq2 = [NSString stringWithFormat:@"%ld",_number * [self.productModel.list.score integerValue]];
                NSString *qqqq3 = @"积分+";
                NSString *qqqq4 = [NSString stringWithFormat:@"%ld",_number * [self.productModel.list.smoney integerValue]];
                NSString *qqqq5 = @"元";
                NSString *qqqq = [NSString stringWithFormat:@"%@%@%@%@%@",qqqq1,qqqq2,qqqq3,qqqq4,qqqq5];
                NSMutableAttributedString *attributeQQ = [[NSMutableAttributedString alloc] initWithString:qqqq];
                [attributeQQ setAttributes:@{NSFontAttributeName:font14,NSForegroundColorAttributeName:[UIColor lightGrayColor]} range:NSMakeRange(0, qqqq1.length)];
                [attributeQQ setAttributes:@{NSFontAttributeName:font18,NSForegroundColorAttributeName:kRedColor} range:NSMakeRange(qqqq1.length, qqqq2.length)];
                [attributeQQ setAttributes:@{NSFontAttributeName:font14,NSForegroundColorAttributeName:[UIColor lightGrayColor]} range:NSMakeRange(qqqq1.length+qqqq2.length, qqqq3.length)];
                [attributeQQ setAttributes:@{NSFontAttributeName:font18,NSForegroundColorAttributeName:kRedColor} range:NSMakeRange(qqqq1.length+qqqq2.length+qqqq3.length, qqqq4.length)];
                [attributeQQ setAttributes:@{NSFontAttributeName:font14,NSForegroundColorAttributeName:[UIColor lightGrayColor]} range:NSMakeRange(qqqq1.length+qqqq2.length+qqqq3.length+qqqq4.length, qqqq5.length)];
                [weakself.payButton setAttributedTitle:attributeQQ forState:0];
                
                [weakself.payButton addAction:^(UIButton *btn) {
                    [weakself showBuyAlertViewWithTitle:qqqq];
                }];
            }];
            
            return cell;
            
        }else{
            identifier = @"eddd21";
            BorrowBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell) {
                cell = [[BorrowBaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.leftButton.titleLabel.font = font14;
            [cell.leftButton setTitle:@"商品描述" forState:0];
            [cell.leftButton setTitleColor:[UIColor blackColor] forState:0];
            
            [cell.rightButton autoSetDimension:ALDimensionWidth toSize:kScreenWidth/2];
            [cell.rightButton setContentHorizontalAlignment:2];
            cell.rightButton.titleLabel.font = font12;
            cell.rightButton.titleLabel.numberOfLines = 0;
            [cell.rightButton setTitle:self.productModel.list.remark forState:0];
            
            return cell;
        }
    }else if (indexPath.section == 3){
        identifier = @"eddd3";
        ExChangeDetailssCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[ExChangeDetailssCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.ssLabel.text = @"备注：";
        cell.ssTextView.placeholder = @"填写您需要对我们说的...";
        
        ZXWeakSelf;
        [cell setDidEndEditting:^(NSString *text) {
            [weakself.buyDic setValue:text forKey:@"mark"];
        }];
        
        return cell;
    }else if (indexPath.section == 4){
        identifier = @"eddd4";
        PayCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[PayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.row == 0) {
            cell.payLabel1.text = @"使用积分:";
            cell.payLabel3.text = [NSString stringWithFormat:@"分  (可用%@积分)",self.productModel.score];
            
            if (_number == 0) {
                cell.payLabel2.text = self.productModel.list.score;
            }else{
                NSString *score = [NSString stringWithFormat:@"%ld", _number * [self.productModel.list.score integerValue]];
                cell.payLabel2.text = score;
            }
        }else{
            cell.payLabel1.text = @"使用余额:";
            cell.payLabel3.text = [NSString stringWithFormat:@"元  (可用%@元)",self.productModel.money];
            if (_number == 0) {
                cell.payLabel2.text = self.productModel.list.smoney;
            }else{
                NSString *money = [NSString stringWithFormat:@"%ld", _number * [self.productModel.list.smoney integerValue]];
                cell.payLabel2.text = money;
            }
        }
        
        return cell;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return kSmallSpace;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        MineReceiptAddressViewController *mineReceiptAddressVC = [[MineReceiptAddressViewController alloc] init];
        [self.navigationController pushViewController:mineReceiptAddressVC animated:YES];
        
        ZXWeakSelf;
        [mineReceiptAddressVC setDidSelectedRow:^(AddressModel *addressModel) {
            
            _choose = YES;
            
            [weakself.buyDic setValue:addressModel.ID forKey:@"aid"];
            [weakself.buyDic setValue:addressModel forKey:@"addressModel"];
            
            [tableView reloadData];
        }];
    }
}

#pragma mark - method
- (void)showBuyAlertViewWithTitle:(NSString *)title
{
    UIAlertController *buyAlert = [UIAlertController alertControllerWithTitle:@"需付款" message:title preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *act0 = [UIAlertAction actionWithTitle:@"取消" style:0 handler:nil];
    
    ZXWeakSelf;
    UIAlertAction *act1 = [UIAlertAction actionWithTitle:@"确认" style:0 handler:^(UIAlertAction * _Nonnull action) {
        [weakself commitToBuyProducts];
    }];
    
    [buyAlert addAction:act0];
    [buyAlert addAction:act1];
    
    [self presentViewController:buyAlert animated:YES completion:nil];
}
- (void)commitToBuyProducts
{
    [self.view endEditing:YES];
    
    NSString *buyString = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFMyInteExchangeOfDetailPay];
    
    [self.buyDic setValue:self.productModel.list.ID forKey:@"gid"];
    [self.buyDic setValue:TOKEN forKey:@"token"];
    
    NSString *mmmmm = [NSString stringWithFormat:@"%ld",(long)_number];
    [self.buyDic setValue:mmmmm forKey:@"number"];
    
    [self.buyDic removeObjectForKey:@"addressModel"];
    
    NSDictionary *params = self.buyDic;
    
    ZXWeakSelf;
    [self requestDataPostWithUrlString:buyString andParams:params andSuccessBlock:^(id responseObject) {
        
        BaseModel *baseModel = [BaseModel objectWithKeyValues:responseObject];
        [weakself showHint:baseModel.info];
        
        if ([baseModel.status integerValue] == 1) {
            UINavigationController *nav = weakself.navigationController;
            [nav popViewControllerAnimated:NO];
            [nav popViewControllerAnimated:NO];
            RecordsInteViewController *recordsInteVC = [[RecordsInteViewController alloc] init];
            [nav pushViewController:recordsInteVC animated:NO];
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
