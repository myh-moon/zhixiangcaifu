//
//  InteExchangeViewController.m
//  zichanbao
//
//  Created by zhixiang on 16/11/8.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import "InteExchangeViewController.h"
#import "NewsProViewController.h"  //规则
#import "RecordsInteViewController.h" //兑换记录
#import "DetailsInteViewController.h"  //积分明细
#import "InteExchangeDetailViewController.h" //商品详情

#import "InteExchangeCell.h"
#import "UIImageView+WebCache.h"

#import "InteExchResponse.h"
#import "InteExchModel.h"

#import "UIImage+Color.h"

@interface InteExchangeViewController ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic,assign) BOOL didSetupConstarints;
@property (nonatomic,strong) UIButton *inteHeaderButton;
@property (nonatomic,strong) UIButton *inteFilterButton;  //积分筛选
@property (nonatomic,strong) UITableView *inteTableView;
@property (nonatomic,strong) UIView *inteFilterPickerView;  //积分筛选页面

//json
@property (nonatomic,strong) NSMutableArray *scoreChooseArray; //积分筛选
@property (nonatomic,strong) NSMutableArray *scoreProductsArray;  //产品
@property (nonatomic,strong) NSString *typeStr;  //积分筛选段
@property (nonatomic,strong) NSString *rulesString;  //规则

@end

@implementation InteExchangeViewController

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:17],NSFontAttributeName, nil]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"积分商城";
    self.navigationItem.leftBarButtonItem = self.leftItem;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
    [self.rightButton setTitleColor:kBlackColor forState:0];
    [self.rightButton setTitle:@"规则" forState:0];
        
    [self.view addSubview:self.inteHeaderButton];
    [self.view addSubview:self.inteFilterButton];
    [self.view addSubview:self.inteTableView];
    [self.view addSubview:self.remindButton];
    [self.remindButton.noTextButton setTitle:@"暂无商品" forState:0];
    [self.remindButton setHidden:YES];
    
    [self.view setNeedsUpdateConstraints];
    
    [self getInteExchangeListWithPage:@"0"];
}

- (void)updateViewConstraints
{
    if (!self.didSetupConstarints) {
        [self.inteHeaderButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
        [self.inteHeaderButton autoSetDimension:ALDimensionHeight toSize:180];
        
        [self.inteFilterButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.inteHeaderButton];
        [self.inteFilterButton autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [self.inteFilterButton autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [self.inteFilterButton autoSetDimension:ALDimensionHeight toSize:26];
        
        [self.inteTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
        [self.inteTableView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.inteFilterButton];
        
        [self.remindButton autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [self.remindButton autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.inteTableView];
        
        self.didSetupConstarints = YES;
    }
    [super updateViewConstraints];
}

- (UIButton *)inteHeaderButton
{
    if (!_inteHeaderButton) {
        _inteHeaderButton = [UIButton newAutoLayoutView];
        _inteHeaderButton.titleLabel.numberOfLines = 0;
        _inteHeaderButton.contentVerticalAlignment = 1;
        _inteHeaderButton.contentEdgeInsets = UIEdgeInsetsMake(kSmallPadding, 0, 0, 0);
        [_inteHeaderButton setBackgroundImage:[UIImage imageNamed:@"jfdhbbg"] forState:0];
        
        //我的积分
//        UIButton *myIntebutton = [UIButton newAutoLayoutView];
//        myIntebutton.titleLabel.numberOfLines = 0;
//        NSString *aaa1 = @"我的积分\n";
//        NSString *aaa2 = @"1000\n";
//        NSString *aaa3 = @"金牌会员";
//        NSString *aaa = [NSString stringWithFormat:@"%@%@%@",aaa1,aaa2,aaa3];
//        NSMutableAttributedString *attributeAA = [[NSMutableAttributedString alloc] initWithString:aaa];
//        [attributeAA addAttributes:@{NSFontAttributeName:font12,NSForegroundColorAttributeName:[UIColor whiteColor]} range:NSMakeRange(0, aaa1.length)];
//        [attributeAA addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:40],NSForegroundColorAttributeName:[UIColor whiteColor]} range:NSMakeRange(aaa1.length, aaa2.length)];
//        [attributeAA addAttributes:@{NSFontAttributeName:font14,NSForegroundColorAttributeName:kRedColor} range:NSMakeRange(aaa1.length+aaa2.length, aaa3.length)];
//        NSMutableParagraphStyle *stylep = [[NSMutableParagraphStyle alloc] init];
//        [stylep setLineSpacing:6];
//        stylep.alignment = 1;
//        [attributeAA addAttribute:NSParagraphStyleAttributeName value:stylep range:NSMakeRange(0, aaa.length)];
//        [myIntebutton setAttributedTitle:attributeAA forState:0];
//        [_inteHeaderButton addSubview:myIntebutton];
        
        //积分明细
        UIButton *inteDetailButton = [UIButton newAutoLayoutView];
        [inteDetailButton setTitle:@"积分明细" forState:0];
        [inteDetailButton setTitleColor:[UIColor whiteColor] forState:0];
        inteDetailButton.titleLabel.font = font14;
        [inteDetailButton setBackgroundImage:[UIImage imageNamed:@"jfdhsbg"] forState:0];
        [inteDetailButton setImage:[UIImage imageNamed:@"jfdhjfmx"] forState:0];
        [_inteHeaderButton addSubview:inteDetailButton];
        
        ZXWeakSelf;
        [inteDetailButton addAction:^(UIButton *btn) {
            DetailsInteViewController *detailsInteVC = [[DetailsInteViewController alloc] init];
            [weakself.navigationController pushViewController:detailsInteVC animated:YES];
        }];
        
        //兑换记录
        UIButton *exchangeButton = [UIButton newAutoLayoutView];
        [exchangeButton setTitle:@"兑换记录" forState:0];
        [exchangeButton setTitleColor:[UIColor whiteColor] forState:0];
        exchangeButton.titleLabel.font = font14;
        [exchangeButton setBackgroundImage:[UIImage imageNamed:@"jfdhsbg"] forState:0];
        [exchangeButton setImage:[UIImage imageNamed:@"jfdhdhjl"] forState:0];
        [_inteHeaderButton addSubview:exchangeButton];
        
        [exchangeButton addAction:^(UIButton *btn) {
            RecordsInteViewController *recordsInteVC = [[RecordsInteViewController alloc] init];
            [weakself.navigationController pushViewController:recordsInteVC animated:YES];
        }];
        
//        [myIntebutton autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_inteHeaderButton];
//        [myIntebutton autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_inteHeaderButton];
//        [myIntebutton autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:_inteHeaderButton];
//        [myIntebutton autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:inteDetailButton];

        
        [inteDetailButton autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_inteHeaderButton];
        [inteDetailButton autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_inteHeaderButton];
        [inteDetailButton autoSetDimensionsToSize:CGSizeMake(kScreenWidth/2, kCellHeight)];
        
        [exchangeButton autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:_inteHeaderButton];
        [exchangeButton autoAlignAxis:ALAxisHorizontal toSameAxisOfView:inteDetailButton];
        [exchangeButton autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:inteDetailButton];
        [exchangeButton autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:inteDetailButton];
    }
    return _inteHeaderButton;
}

- (UIButton *)inteFilterButton
{
    if (!_inteFilterButton) {
        _inteFilterButton = [UIButton newAutoLayoutView];
        _inteFilterButton.contentHorizontalAlignment = 1;
        _inteFilterButton.contentEdgeInsets = UIEdgeInsetsMake(0, kSmallPadding, 0, 0);
        [_inteFilterButton setTitle:@"积分筛选" forState:0];
        [_inteFilterButton setImage:[UIImage imageNamed:@"arrowxiangxia"] forState:0];
        [_inteFilterButton setTitleColor:kNavigationColor forState:0];
        _inteFilterButton.titleLabel.font = font12;
        _inteFilterButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _inteFilterButton.layer.borderWidth = 0.5;
        _inteFilterButton.transform = CGAffineTransformRotate(_inteFilterButton.transform, M_PI);
        _inteFilterButton.titleLabel.transform = CGAffineTransformRotate(_inteFilterButton.titleLabel.transform, M_PI);
        _inteFilterButton.imageView.transform = CGAffineTransformRotate(_inteFilterButton.imageView.transform, M_PI);
        
        ZXWeakSelf;
        [_inteFilterButton addAction:^(UIButton *btn) {
            if (weakself.scoreChooseArray.count > 0) {
                [weakself showHegPickerView];
            }else{
                [weakself getInteExchangeListWithPage:@"0"];
            }
        }];

    }
    return _inteFilterButton;
}

- (UITableView *)inteTableView
{
    if (!_inteTableView) {
        _inteTableView = [UITableView newAutoLayoutView];
        _inteTableView.backgroundColor = kBackgroundColor;
        _inteTableView.dataSource = self;
        _inteTableView.delegate = self;
        _inteTableView.tableFooterView = [[UIView alloc] init];
    }
    return _inteTableView;
}

- (UIView *)inteFilterPickerView
{
    if (!_inteFilterPickerView) {
        _inteFilterPickerView = [UIView newAutoLayoutView];
        _inteFilterPickerView.backgroundColor = [UIColor colorWithRed:0.0000 green:0.0000 blue:0.0000 alpha:0.4];
        
        //取消//确定
        UIView *hegView = [UIView newAutoLayoutView];
        hegView.backgroundColor = kBackgroundColor;
        [_inteFilterPickerView addSubview:hegView];
        UIButton *cancelButton = [UIButton newAutoLayoutView];
        [cancelButton setTitle:@"取消" forState:0];
        [cancelButton setTitleColor:RGBCOLOR(0.3137, 0.5922, 0.8275) forState:0];
        cancelButton.titleLabel.font = font16;
        [hegView addSubview:cancelButton];
        UIButton *okButton = [UIButton newAutoLayoutView];
        [okButton setTitle:@"确定" forState:0];
        [okButton setTitleColor:RGBCOLOR(0.3137, 0.5922, 0.8275) forState:0];
        okButton.titleLabel.font = font16;
        [hegView addSubview:okButton];
        [cancelButton autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:hegView withOffset:kSmallPadding];
        [cancelButton autoAlignAxis:ALAxisHorizontal toSameAxisOfView:hegView];
        [okButton autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:hegView withOffset:-kSmallPadding];
        [okButton autoAlignAxis:ALAxisHorizontal toSameAxisOfView:cancelButton];
        ZXWeakSelf;
        [cancelButton addAction:^(UIButton *btn) {
            [weakself hiddenHegPickerView];
        }];
        [okButton addAction:^(UIButton *btn) {
            [weakself hiddenHegPickerView];
            
            if (!weakself.typeStr) {
                weakself.typeStr = @"1";
                NSString *nnnn = weakself.typeStr?weakself.typeStr:@"1";
                NSString *sosos = weakself.scoreChooseArray[[nnnn integerValue] - 1];
                [weakself.inteFilterButton setTitle:sosos forState:0];
                [weakself getInteExchangeListWithPage:@"0"];
            }else{
                NSString *sosos = weakself.scoreChooseArray[[weakself.typeStr integerValue] - 1];
                [weakself.inteFilterButton setTitle:sosos forState:0];
                [weakself getInteExchangeListWithPage:@"0"];
            }
        }];
        
        //pickerView
        UIPickerView *hegPickerView = [UIPickerView newAutoLayoutView];
        hegPickerView.backgroundColor = [UIColor whiteColor];
        hegPickerView.delegate = self;
        hegPickerView.dataSource = self;
        hegPickerView.showsSelectionIndicator = YES;
        [_inteFilterPickerView addSubview:hegPickerView];
        
        [hegView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [hegView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [hegView autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:hegPickerView];
        [hegView autoSetDimension:ALDimensionHeight toSize:kCellHeight];
        
        [hegPickerView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
        [hegPickerView autoSetDimension:ALDimensionHeight toSize:140];
    }
    return _inteFilterPickerView;
}

- (void)showHegPickerView
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self.inteFilterPickerView];
    
    [self.inteFilterPickerView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

- (void)hiddenHegPickerView
{
    [self.inteFilterPickerView removeFromSuperview];
}

- (NSMutableArray *)scoreChooseArray
{
    if (!_scoreChooseArray) {
        _scoreChooseArray = [NSMutableArray array];
    }
    return _scoreChooseArray;
}

- (NSMutableArray *)scoreProductsArray
{
    if (!_scoreProductsArray) {
        _scoreProductsArray = [NSMutableArray array];
    }
    return _scoreProductsArray;
}

#pragma mark - delegate and datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.scoreProductsArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"inteCell";
    InteExchangeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[InteExchangeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.inteImageView.backgroundColor = [UIColor whiteColor];
    cell.inteLabel.numberOfLines = 0;
    
    InteExchModel *exchModel = self.scoreProductsArray[indexPath.row];
    
    [cell.inteImageView sd_setImageWithURL:[NSURL URLWithString:exchModel.simg] placeholderImage:[UIImage imageNamed:@""]];
    
    NSString *name1 = [NSString stringWithFormat:@"%@\n",exchModel.name];
    NSString *inte1 = exchModel.score;
    NSString *inte2 = @" 积分+ ";
    NSString *inte3 = exchModel.smoney;
    NSString *inte4 = @"元\n";
    NSString *price1 = [NSString stringWithFormat:@"市场参考价：%@元",exchModel.money];
    
    NSString *contentString = [NSString stringWithFormat:@"%@%@%@%@%@%@",name1,inte1,inte2,inte3,inte4,price1];
    NSMutableAttributedString *attributeContent = [[NSMutableAttributedString alloc] initWithString:contentString];
    [attributeContent addAttributes:@{NSFontAttributeName:font14,NSForegroundColorAttributeName:[UIColor blackColor]} range:NSMakeRange(0, name1.length)];
    [attributeContent addAttributes:@{NSFontAttributeName:font18,NSForegroundColorAttributeName:[UIColor redColor]} range:NSMakeRange(name1.length, inte1.length)];
    [attributeContent addAttributes:@{NSFontAttributeName:font12,NSForegroundColorAttributeName:[UIColor grayColor]} range:NSMakeRange(name1.length+inte1.length, inte2.length)];
    [attributeContent addAttributes:@{NSFontAttributeName:font18,NSForegroundColorAttributeName:kRedColor} range:NSMakeRange(name1.length+inte1.length+inte2.length, inte3.length)];
    [attributeContent addAttributes:@{NSFontAttributeName:font12,NSForegroundColorAttributeName:[UIColor grayColor]} range:NSMakeRange(name1.length+inte1.length+inte2.length+inte3.length, inte4.length)];
    [attributeContent addAttributes:@{NSFontAttributeName:font12,NSForegroundColorAttributeName:[UIColor darkGrayColor]} range:NSMakeRange(name1.length+inte1.length+inte2.length+inte3.length+inte4.length, price1.length)];
    NSMutableParagraphStyle *styler = [[NSMutableParagraphStyle alloc] init];
    styler.lineSpacing = 6;
    [attributeContent addAttribute:NSParagraphStyleAttributeName value:styler range:NSMakeRange(0, contentString.length)];
    [cell.inteLabel setAttributedText:attributeContent];

    return cell;
}

-(void)viewDidLayoutSubviews
{
    if ([self.inteTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.inteTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.inteTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.inteTableView setLayoutMargins:UIEdgeInsetsZero];
    }
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    InteExchModel *exchModel = self.scoreProductsArray[indexPath.row];
    
    InteExchangeDetailViewController *inteExchangeDetailVC = [[InteExchangeDetailViewController alloc] init];
    inteExchangeDetailVC.productID = exchModel.ID;
    [self.navigationController pushViewController:inteExchangeDetailVC animated:YES];
}

#pragma mark - pickerView delegate and datasource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.scoreChooseArray.count;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return kSmallCellHeight;
}
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.scoreChooseArray[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.typeStr = [NSString stringWithFormat:@"%ld",(long)row+1];
}

#pragma mark - method
- (void)getInteExchangeListWithPage:(NSString *)page
{
    NSString *inteExString = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFMyInteExchangeOfScoreChoose];
    
    NSDictionary *params;
    if (!self.typeStr) {
        params = @{@"token" : TOKEN};
    }else{
        params = @{@"token" : TOKEN,
                   @"type" : self.typeStr
                   };
    }
    
    ZXWeakSelf;
    [self requestDataGetWithUrlString:inteExString paramter:params SucceccBlock:^(id responseObject) {
        
        [weakself.scoreProductsArray removeAllObjects];
        
        InteExchResponse *response = [InteExchResponse objectWithKeyValues:responseObject];
        
        //产品列表
        for (InteExchModel *exchModel in response.list) {
            [weakself.scoreProductsArray addObject:exchModel];
        }
        
        if (weakself.scoreProductsArray.count == 0) {
            [weakself.remindButton setHidden:NO];
        }else{
            [weakself.remindButton setHidden:YES];
        }
        
        if (weakself.scoreChooseArray.count == 0) {
            weakself.scoreChooseArray = response.jf; //积分筛选列表
        }
        
        //规则
        weakself.rulesString = response.url;
        
        //我的积分
        NSString *aaa1 = @"我的积分\n";
        NSString *aaa2 = [NSString stringWithFormat:@"%@\n",response.score];
        NSString *aaa3 = response.vip;
        NSString *aaa = [NSString stringWithFormat:@"%@%@%@",aaa1,aaa2,aaa3];
        NSMutableAttributedString *attributeAA = [[NSMutableAttributedString alloc] initWithString:aaa];
        [attributeAA addAttributes:@{NSFontAttributeName:font12,NSForegroundColorAttributeName:[UIColor whiteColor]} range:NSMakeRange(0, aaa1.length)];
        [attributeAA addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:40],NSForegroundColorAttributeName:[UIColor whiteColor]} range:NSMakeRange(aaa1.length, aaa2.length)];
        [attributeAA addAttributes:@{NSFontAttributeName:font14,NSForegroundColorAttributeName:[UIColor whiteColor]} range:NSMakeRange(aaa1.length+aaa2.length, aaa3.length)];
        NSMutableParagraphStyle *stylep = [[NSMutableParagraphStyle alloc] init];
        [stylep setLineSpacing:6];
        stylep.alignment = 1;
        [attributeAA addAttribute:NSParagraphStyleAttributeName value:stylep range:NSMakeRange(0, aaa.length)];
        [weakself.inteHeaderButton setAttributedTitle:attributeAA forState:0];
        
        [weakself.inteTableView reloadData];
        
    } andFailedBlock:^{
        
    }];
}

- (void)rightAction
{
    NewsProViewController *newsProVC = [[NewsProViewController alloc] init];
    newsProVC.titleString = @"规则";
    newsProVC.newsString = self.rulesString;
    [self.navigationController pushViewController:newsProVC animated:YES];
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
