//
//  InteExchangeDetailViewController.m
//  zichanbao
//
//  Created by zhixiang on 16/11/8.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import "InteExchangeDetailViewController.h"
#import "InteExchangeDetailssViewController.h"   //确认兑换

#import "BorrowBaseCell.h"
#import "ExchangeDetailCell.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"

#import "InteExchDetailModel.h"
#import "InteExchModel.h"

#import "UIImage+Color.h"

@interface InteExchangeDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,assign) BOOL didSetupConstraints;
@property (nonatomic,strong) UITableView *exDetailTableView;
@property (nonatomic,strong) UIButton *exDetailButton; //我要兑换按钮

//json
@property (nonatomic,strong) NSMutableArray *exDetailArray;

@end

@implementation InteExchangeDetailViewController

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:17],NSFontAttributeName, nil]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品详情";
    self.navigationItem.leftBarButtonItem = self.leftItem;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.exDetailTableView];
    [self.view addSubview:self.exDetailButton];

    [self.view setNeedsUpdateConstraints];
    
    [self getDetailOfInteExchange];
}

- (void)updateViewConstraints
{
    if (!self.didSetupConstraints) {
        
        [self.exDetailTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
        [self.exDetailTableView autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.exDetailButton];
        
        [self.exDetailButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
        [self.exDetailButton autoSetDimension:ALDimensionHeight toSize:56];
        
        self.didSetupConstraints = YES;
    }
    [super updateViewConstraints];
}

- (UITableView *)exDetailTableView
{
    if (!_exDetailTableView) {
        _exDetailTableView.translatesAutoresizingMaskIntoConstraints = NO;
        _exDetailTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _exDetailTableView.backgroundColor = kBackgroundColor;
        _exDetailTableView.delegate = self;
        _exDetailTableView.dataSource = self;
        _exDetailTableView.separatorColor = [UIColor clearColor];
    }
    return _exDetailTableView;
}

- (UIButton *)exDetailButton
{
    if (!_exDetailButton) {
        _exDetailButton = [UIButton newAutoLayoutView];
        _exDetailButton.backgroundColor = [UIColor whiteColor];
        [_exDetailButton setTitleEdgeInsets:UIEdgeInsetsMake(0, kSmallPadding, 0, 0)];
        [_exDetailButton setContentHorizontalAlignment:1];
        
        ZXWeakSelf;
        [_exDetailButton addAction:^(UIButton *btn) {
            
            InteExchDetailModel *exchDetailModel = weakself.exDetailArray[0];
            
            InteExchangeDetailssViewController *inteExchangeDetailssVC = [[InteExchangeDetailssViewController alloc] init];
            inteExchangeDetailssVC.productModel = exchDetailModel;
            [weakself.navigationController pushViewController:inteExchangeDetailssVC animated:YES];
        }];
        
        //我要兑换按钮
        UIButton *exchangeButton = [UIButton newAutoLayoutView];
        [exchangeButton setTitleColor:[UIColor whiteColor] forState:0];
        [exchangeButton setTitle:@"我要兑换" forState:0];
        exchangeButton.titleLabel.font = font16;
        exchangeButton.backgroundColor = kNavigationColor;
        exchangeButton.layer.cornerRadius = 15;
        exchangeButton.userInteractionEnabled = NO;
        [_exDetailButton addSubview:exchangeButton];
        
        [exchangeButton autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:_exDetailButton withOffset:-kSmallPadding];
        [exchangeButton autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_exDetailButton];
        [exchangeButton autoSetDimension:ALDimensionWidth toSize:100];
    }
    return _exDetailButton;
}

- (NSMutableArray *)exDetailArray
{
    if (!_exDetailArray) {
        _exDetailArray = [NSMutableArray array];
    }
    return _exDetailArray;
}

#pragma mark - delegate and datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.exDetailArray.count > 0) {
        return 3;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {

        InteExchDetailModel *exchDetailModel = self.exDetailArray[0];
        
        UIImageView *img1 = [[UIImageView alloc] init];
        [img1 sd_setImageWithURL:[NSURL URLWithString:exchDetailModel.list.bimg] placeholderImage:nil options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            img1.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        }];
        
        return img1.height;
        
    }else if (indexPath.section == 1){
        return 105;
    }
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier;
    
    InteExchDetailModel *exchDetailModel = self.exDetailArray[0];
    InteExchModel *exchModel = exchDetailModel.list;
    
    if (indexPath.section == 0) {
        identifier = @"exDetail0";
        BorrowBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[BorrowBaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.leftButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
        [cell.leftButton autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        
        [cell.leftButton sd_setImageWithURL:[NSURL URLWithString:exchModel.bimg] forState:0 placeholderImage:nil];
        
        return cell;
    }else if (indexPath.section == 1){
        identifier = @"exDetail0";
        ExchangeDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[ExchangeDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.exchangeLabel1.text = exchModel.name;
        [cell.exchangeButton setImage:[UIImage imageNamed:@"shangpinxqicon"] forState:0];
        NSString *sss = [NSString stringWithFormat:@" %@",exchModel.score];
        NSMutableAttributedString *attributeEE = [NSString getStringFromFirstString:sss andFirstColor:kRedColor andFirstFont:font18 ToSecondString:@"积分" andSecondColor:[UIColor grayColor] andSecondFont:font14];
        [cell.exchangeButton setAttributedTitle:attributeEE forState:0];
        
        NSString *aa1 = [NSString stringWithFormat:@"当前积分%@，需另付%@元人民币\n",exchDetailModel.score,exchModel.smoney];
        NSString *aa2 = [NSString stringWithFormat:@"市场参考价格：%@元",exchModel.money];
        NSString *reString = [NSString stringWithFormat:@"%@%@",aa1,aa2];
        NSMutableAttributedString *attributeRR = [[NSMutableAttributedString alloc] initWithString:reString];
        [attributeRR addAttributes:@{NSFontAttributeName:font14,NSForegroundColorAttributeName:[UIColor grayColor]} range:NSMakeRange(0, aa1.length)];
        [attributeRR addAttributes:@{NSFontAttributeName:font14,NSForegroundColorAttributeName:[UIColor grayColor]} range:NSMakeRange(aa1.length, aa2.length)];
        NSMutableParagraphStyle *styple = [[NSMutableParagraphStyle alloc] init];
        [styple setLineSpacing:4];
        [attributeRR addAttribute:NSParagraphStyleAttributeName value:styple range:NSMakeRange(0, reString.length)];
        [cell.exchangeLabel2 setAttributedText:attributeRR];

        return cell;
        
    }else{
        identifier = @"exDetail0";
        BorrowBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[BorrowBaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.rightButton setHidden:YES];
        cell.backgroundColor = kBackgroundColor;
        
        [cell.leftButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:kSmallPadding];
        cell.leftButton.titleLabel.numberOfLines = 0;
        [cell.leftButton setContentEdgeInsets:UIEdgeInsetsMake(kSmallPadding, 0, kBigPadding, 0)];
        [cell.leftButton setContentVerticalAlignment:1];
        [cell.leftButton setContentHorizontalAlignment:1];
        
        NSString *string1 = @"商品描述\n";
        NSString *string2 = exchModel.remark;
        NSString *reString = [NSString stringWithFormat:@"%@%@",string1,string2];
        NSMutableAttributedString *attributeRR = [[NSMutableAttributedString alloc] initWithString:reString];
        [attributeRR addAttributes:@{NSFontAttributeName:font12,NSForegroundColorAttributeName:[UIColor darkGrayColor]} range:NSMakeRange(0, string1.length)];
        [attributeRR addAttributes:@{NSFontAttributeName:font12,NSForegroundColorAttributeName:[UIColor darkGrayColor]} range:NSMakeRange(string1.length, string2.length)];
        
        NSMutableParagraphStyle *styple = [[NSMutableParagraphStyle alloc] init];
        [styple setLineSpacing:4];
        [styple setParagraphSpacing:4];
        [attributeRR addAttribute:NSParagraphStyleAttributeName value:styple range:NSMakeRange(0, reString.length)];
        [cell.leftButton setAttributedTitle:attributeRR forState:0];
        
        return cell;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

#pragma mark - method
- (void)getDetailOfInteExchange
{
    NSString *detaString = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFMyInteExchangeOfDetails];
    NSDictionary *params = @{@"token" : TOKEN,
                             @"id" : self.productID};
    
    ZXWeakSelf;
    [self requestDataGetWithUrlString:detaString paramter:params SucceccBlock:^(id responseObject) {
        
        InteExchDetailModel *response = [InteExchDetailModel objectWithKeyValues:responseObject];
        
        [weakself.exDetailArray addObject:response];
        
        //我要兑换
        NSString *qqqq1 = @"单价:";
        NSString *qqqq2 = response.list.score;
        NSString *qqqq3 = @"积分+";
        NSString *qqqq4 = response.list.smoney;
        NSString *qqqq5 = @"元";
        NSString *qqqq = [NSString stringWithFormat:@"%@%@%@%@%@",qqqq1,qqqq2,qqqq3,qqqq4,qqqq5];
        NSMutableAttributedString *attributeQQ = [[NSMutableAttributedString alloc] initWithString:qqqq];
        [attributeQQ setAttributes:@{NSFontAttributeName:font14,NSForegroundColorAttributeName:[UIColor lightGrayColor]} range:NSMakeRange(0, qqqq1.length)];
        [attributeQQ setAttributes:@{NSFontAttributeName:font18,NSForegroundColorAttributeName:kRedColor} range:NSMakeRange(qqqq1.length, qqqq2.length)];
        [attributeQQ setAttributes:@{NSFontAttributeName:font14,NSForegroundColorAttributeName:[UIColor lightGrayColor]} range:NSMakeRange(qqqq1.length+qqqq2.length, qqqq3.length)];
        [attributeQQ setAttributes:@{NSFontAttributeName:font18,NSForegroundColorAttributeName:kRedColor} range:NSMakeRange(qqqq1.length+qqqq2.length+qqqq3.length, qqqq4.length)];
        [attributeQQ setAttributes:@{NSFontAttributeName:font14,NSForegroundColorAttributeName:[UIColor lightGrayColor]} range:NSMakeRange(qqqq1.length+qqqq2.length+qqqq3.length+qqqq4.length, qqqq5.length)];
        [weakself.exDetailButton setAttributedTitle:attributeQQ forState:0];
        
        [weakself.exDetailTableView reloadData];
        
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
