//
//  ChannelIntermediaryViewController.m
//  zichanbao
//
//  Created by zhixiang on 16/12/23.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import "ChannelIntermediaryViewController.h"
#import "EstimateViewController.h"//预估
#import "EstimateDetailViewController.h"  //预估详情

#import "ChannelCell.h"// 累计
#import "ChannelAACell.h"  //预估
#import "ChannelBBCell.h"  //进件

#import "ChannelResponse.h"
#import "BillModel.h"

#import "ChannelCalendarView.h"
#import "UIViewController+BlurView.h"
#import "NSString+ValidString.h"
#import "NSDate+FormatterTime.h"

@interface ChannelIntermediaryViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,assign) BOOL didSetupConstraints;
@property (nonatomic,strong) UIButton *channelTitleButton;//titleView
@property (nonatomic,strong) ChannelCalendarView *calendarView;//选择日期起始时间

@property (nonatomic,strong) UIView *calendarKeyView;

@property (nonatomic,strong) UITableView *channelTableView;
@property (nonatomic,strong) UITableView *titleTableView;

//params
@property (nonatomic,strong) NSMutableDictionary *billDic;

//json
@property (nonatomic,strong) NSMutableArray *billDataArray;
@property (nonatomic,assign) NSInteger pageChannel;
@property (nonatomic,strong) NSString *tagFromOrTo;  //标记起始时间或终止时间

@end

@implementation ChannelIntermediaryViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = self.channelTitleButton;
    self.navigationItem.leftBarButtonItem = self.leftItem;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
    [self.rightButton setTitle:@"预估" forState:0];
    [self.rightButton setHidden:YES];
    
    [self.view addSubview:self.calendarView];
    [self.view addSubview:self.channelTableView];
    [self.view addSubview:self.remindButton];
    [self.remindButton.noImageButton setImage:[UIImage imageNamed:@"kognbai"] forState:0];
    [self.remindButton setHidden:YES];
    
    [self.view setNeedsUpdateConstraints];
    
    [self headerRefreshOfChannel];
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self.calendarKeyView];
    [self.calendarKeyView setHidden:YES];
    [self.calendarKeyView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

- (void)updateViewConstraints
{
    if (!self.didSetupConstraints) {
        
        [self.calendarView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
        [self.calendarView autoSetDimension:ALDimensionHeight toSize:kSmallCellHeight];
        
        [self.channelTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
        [self.channelTableView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.calendarView];
        
        [self.remindButton autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [self.remindButton autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        self.didSetupConstraints = YES;
    }
    [super updateViewConstraints];
}

- (UIButton *)channelTitleButton
{
    if (!_channelTitleButton) {
        _channelTitleButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 44)];
        _channelTitleButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [_channelTitleButton setTitleColor:[UIColor whiteColor] forState:0];
        [_channelTitleButton setTitle:@"账单" forState:0];
        [_channelTitleButton setImage:[UIImage imageNamed:@"xiala"] forState:0];
        [_channelTitleButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -_channelTitleButton.imageView.bounds.size.width, 0, _channelTitleButton.imageView.bounds.size.width)];
        [_channelTitleButton setImageEdgeInsets:UIEdgeInsetsMake(0, _channelTitleButton.titleLabel.bounds.size.width, 0, -_channelTitleButton.titleLabel.bounds.size.width)];
        
        ZXWeakSelf;
        [_channelTitleButton addAction:^(UIButton *btn) {
            NSArray *tttttt = @[@"进件",@"返点",@"预估",@"账单"];
            [weakself showBlurInView:weakself.view withArray:tttttt withTop:0 finishBlock:^(NSString *text, NSInteger row) {
                [btn setTitle:text forState:0];
                
                if ([text containsString:@"预估"]) {
                    [weakself.rightButton setHidden:NO];
                }else{
                    [weakself.rightButton setHidden:YES];
                }
                
                [weakself headerRefreshOfChannel];
            }];
        }];
    }
    return _channelTitleButton;
}

- (UITableView *)titleTableView
{
    if (!_titleTableView) {
        _titleTableView = [UITableView newAutoLayoutView];
        _titleTableView.delegate = self;
        _titleTableView.dataSource = self;
    }
    return _titleTableView;
}
- (ChannelCalendarView *)calendarView
{
    if (!_calendarView) {
        _calendarView = [ChannelCalendarView newAutoLayoutView];
        
        ZXWeakSelf;
        [_calendarView setDidSelectedBtn:^(UIButton *btn) {
            switch (btn.tag) {
                case 211:{//开始日期
                    weakself.tagFromOrTo = @"from";
                    [weakself showDatePickerView];
                }
                    break;
                case 212:{//结束日期
                    [weakself showDatePickerView];
                    weakself.tagFromOrTo = @"to";
                }
                    break;
                case 213:{//搜索
                    [weakself headerRefreshOfChannel];
                }
                    break;
                default:
                    break;
            }
        }];
    }
    return _calendarView;
}

- (UITableView *)channelTableView
{
    if (!_channelTableView) {
        _channelTableView = [UITableView newAutoLayoutView];
        _channelTableView.backgroundColor = kBackgroundColor;
        _channelTableView.delegate = self;
        _channelTableView.dataSource = self;
        [_channelTableView setSeparatorColor:[UIColor clearColor]];
        _channelTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kSmallPadding)];
        [_channelTableView addHeaderWithTarget:self action:@selector(headerRefreshOfChannel)];
        [_channelTableView addFooterWithTarget:self action:@selector(footerRefreshOfChannel)];
    }
    return _channelTableView;
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
            
            if ([weakself.tagFromOrTo isEqualToString:@"from"]) {
                [weakself.calendarView.fromDateButton setTitle:locationString forState:0];
                [weakself.billDic setValue:locationString forKey:@"start_date"];
            }else if ([weakself.tagFromOrTo isEqualToString:@"to"]){
                [weakself.calendarView.toDateButton setTitle:locationString forState:0];
                [weakself.billDic setValue:locationString forKey:@"end_date"];
            }
        }];
    }
    return _calendarKeyView;
}

- (NSMutableDictionary *)billDic
{
    if (!_billDic) {
        _billDic = [NSMutableDictionary dictionary];
    }
    return _billDic;
}

- (NSMutableArray *)billDataArray
{
    if (!_billDataArray) {
        _billDataArray = [NSMutableArray array];
    }
    return _billDataArray;
}

#pragma mark - tableview delegate and datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.billDataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *titleString = self.channelTitleButton.titleLabel.text;
    if ([titleString isEqualToString:@"账单"]) {
        return 135; //账单
    }else if ([titleString isEqualToString:@"返点"]){
        return 118;
    }else if ([titleString isEqualToString:@"进件"]){
        return 120;
    }else if ([titleString isEqualToString:@"预估"]){
        return 165;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //预估：yuguicon  进件：jinjianicon 返点：fandianicon 账单：zhangdanicon
    
    NSString *titleString = self.channelTitleButton.titleLabel.text;
    if ([titleString isEqualToString:@"账单"]) {
        //账单
        static NSString *identifier = @"zhangdanicon";
        ChannelCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[ChannelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = kBackgroundColor;
        
        BillModel *billModel = self.billDataArray[indexPath.row];
        
        [cell.chTimeButton setImage:[UIImage imageNamed:@"zhangdanicon"] forState:0];
        NSString *timem = [NSString stringWithFormat:@"  %@",billModel.yearmon];
        [cell.chTimeButton setTitle:timem forState:0];
        
        NSString *ll1 = [NSString stringWithFormat:@"评估笔数：%@\n",[NSString getValidStringFromString:billModel.estate_num]];
        NSString *ll2 = [NSString stringWithFormat:@"进件/笔：%@\n",[NSString getValidStringFromString:billModel.comeinpiece_num]];
        NSString *ll3 = [NSString stringWithFormat:@"通过金额/万：%@\n",[NSString getValidStringFromString:billModel.has_borrow]];
        NSString *ll4 = [NSString stringWithFormat:@"已返佣金/万：%@\n",[NSString getValidStringFromString:billModel.commission_yes]];
        NSString *ll5 = [NSString stringWithFormat:@"未返佣金/万：%@\n",[NSString getValidStringFromString:billModel.commission_no]];
        
        NSString *lllll = [NSString stringWithFormat:@"%@%@%@%@%@",ll1,ll2,ll3,ll4,ll5];
        NSMutableAttributedString *attributeLL = [[NSMutableAttributedString alloc] initWithString:lllll];
        [attributeLL setAttributes:@{NSFontAttributeName : font13,NSForegroundColorAttributeName:[UIColor darkGrayColor]} range:NSMakeRange(0, lllll.length)];
        NSMutableParagraphStyle *styple = [[NSMutableParagraphStyle alloc] init];
        [styple setParagraphSpacing:2];
        [attributeLL addAttribute:NSParagraphStyleAttributeName value:styple range:NSMakeRange(0, lllll.length)];
        [cell.chTextLabel setAttributedText:attributeLL];
        
        return cell;
        
    }else if ([titleString isEqualToString:@"返点"]){
        //返点
        static NSString *identifier = @"reback";
        ChannelCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[ChannelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = kBackgroundColor;
        
        BillModel *billModel = self.billDataArray[indexPath.row];
        
        [cell.chTimeButton setImage:[UIImage imageNamed:@"fandianicon"] forState:0];
        NSString *timem = [NSString stringWithFormat:@"  %@",[NSDate getYMDhmFormatterTime:billModel.add_time]];
        [cell.chTimeButton setTitle:timem forState:0];
        
        NSString *ll1 = [NSString stringWithFormat:@"类型：%@\n",[NSString getValidStringFromString:billModel.type]];
        NSString *ll2 = [NSString stringWithFormat:@"影响金额/元：%@\n",[NSString getValidStringFromString:billModel.affect_money]];
        NSString *ll3 = [NSString stringWithFormat:@"说明：%@\n",billModel.info];
        NSString *ll4 = [NSString stringWithFormat:@"可用余额/元：%@",[NSString getValidStringFromString:billModel.account_money]];
        
        NSString *lllll = [NSString stringWithFormat:@"%@%@%@%@",ll1,ll2,ll3,ll4];
        NSMutableAttributedString *attributeLL = [[NSMutableAttributedString alloc] initWithString:lllll];
        [attributeLL setAttributes:@{NSFontAttributeName : font13,NSForegroundColorAttributeName:[UIColor darkGrayColor]} range:NSMakeRange(0, lllll.length)];
        NSMutableParagraphStyle *styple = [[NSMutableParagraphStyle alloc] init];
        [styple setParagraphSpacing:2];
        [attributeLL addAttribute:NSParagraphStyleAttributeName value:styple range:NSMakeRange(0, lllll.length)];
        [cell.chTextLabel setAttributedText:attributeLL];
        
        return cell;
    }else if ([titleString isEqualToString:@"进件"]){
        static NSString *identifier = @"jinjian";
        ChannelBBCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[ChannelBBCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = kBackgroundColor;
        
        BillModel *billModel = self.billDataArray[indexPath.row];
        
        [cell.intoCodeButton setImage:[UIImage imageNamed:@"jinjianicon"] forState:0];
        NSString *code = [NSString stringWithFormat:@"  编号：%@",billModel.idString];
        [cell.intoCodeButton setTitle:code forState:0];
        cell.intoTimeLabel.text = [NSString stringWithFormat:@"申请时间：%@",billModel.apply_date];
        cell.intoUserLabel.text = [NSString getValidStringFromString:billModel.name toString:@"无"];
        cell.intoMoneyLabel.text = billModel.borrow_money;
        
        NSString *ll1 = [NSString stringWithFormat:@"期限：%@\n",billModel.duration_date];
        NSString *ll2 = [NSString stringWithFormat:@"经办人：%@",billModel.kfuid];
        NSString *lllll = [NSString stringWithFormat:@"%@%@",ll1,ll2];
        NSMutableAttributedString *attributeLL = [[NSMutableAttributedString alloc] initWithString:lllll];
        [attributeLL setAttributes:@{NSFontAttributeName : font13,NSForegroundColorAttributeName:kDarkGrayColor} range:NSMakeRange(0, lllll.length)];
        NSMutableParagraphStyle *styple = [[NSMutableParagraphStyle alloc] init];
        [styple setParagraphSpacing:4];
        [attributeLL addAttribute:NSParagraphStyleAttributeName value:styple range:NSMakeRange(0, lllll.length)];
        [cell.intoOperatorLabel setAttributedText:attributeLL];
        
        NSString *ww1 = [NSString stringWithFormat:@"业务类型：%@\n",billModel.business_type];
        NSString *ww2 = [NSString stringWithFormat:@"状态：%@",billModel.status];
        
        NSString *wwww = [NSString stringWithFormat:@"%@%@",ww1,ww2];
        NSMutableAttributedString *attributeWW = [[NSMutableAttributedString alloc] initWithString:wwww];
        [attributeWW setAttributes:@{NSFontAttributeName : font13,NSForegroundColorAttributeName:kDarkGrayColor} range:NSMakeRange(0, ww1.length)];
        [attributeWW setAttributes:@{NSFontAttributeName : font13,NSForegroundColorAttributeName:kNavigationColor} range:NSMakeRange(ww1.length, ww2.length)];
        NSMutableParagraphStyle *stypleww = [[NSMutableParagraphStyle alloc] init];
        [stypleww setParagraphSpacing:4];
        [attributeWW addAttribute:NSParagraphStyleAttributeName value:stypleww range:NSMakeRange(0, wwww.length)];
        [cell.intoStateLabel setAttributedText:attributeWW];
        
        return cell;
        
    }else if ([titleString isEqualToString:@"预估"]){
        static NSString *identifier = @"yugu";
        ChannelAACell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[ChannelAACell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = kBackgroundColor;
        
        BillModel *billModel = self.billDataArray[indexPath.row];
        
        [cell.evaCodeButton setImage:[UIImage imageNamed:@"yuguicon"] forState:0];
        NSString *titieString = [NSString stringWithFormat:@"  编号：%@",billModel.idString];
        [cell.evaCodeButton setTitle:titieString forState:0];
        cell.evaTimeLabel.text = [NSString stringWithFormat:@"申请时间：%@",billModel.add_time];
        cell.evaHomeLabel.text = billModel.address;
        
        NSString *ll1 = [NSString stringWithFormat:@"房产面积：%@m²\n",billModel.spare];
        NSString *ll2 = [NSString stringWithFormat:@"预估价格：%@",billModel.price];
        
        NSString *lllll = [NSString stringWithFormat:@"%@%@",ll1,ll2];
        NSMutableAttributedString *attributeLL = [[NSMutableAttributedString alloc] initWithString:lllll];
        [attributeLL setAttributes:@{NSFontAttributeName : font13,NSForegroundColorAttributeName:[UIColor darkGrayColor]} range:NSMakeRange(0, lllll.length)];
        NSMutableParagraphStyle *styple = [[NSMutableParagraphStyle alloc] init];
        [styple setParagraphSpacing:2];
        [attributeLL addAttribute:NSParagraphStyleAttributeName value:styple range:NSMakeRange(0, lllll.length)];
        [cell.evaContentLabel setAttributedText:attributeLL];
        
        cell.evaBackTimeLabel.text = [NSString stringWithFormat:@"回复时间：%@",billModel.update_time];
        [cell.evaModifyButton setHidden:YES];
        [cell.evaCheckButton setTitle:@"查看" forState:0];
        cell.evaCheckButton.userInteractionEnabled = NO;
        
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *titleString = self.channelTitleButton.titleLabel.text;
    if ([titleString isEqualToString:@"预估"]) {
        BillModel *estimateModel = self.billDataArray[indexPath.row];
        EstimateDetailViewController *estimateDetailsVC = [[EstimateDetailViewController alloc] init];
        estimateDetailsVC.estimateId = estimateModel.idString;
        [self.navigationController pushViewController:estimateDetailsVC animated:YES];
    }
}

#pragma mark - refresh
- (void)getListOfChannelWithPage:(NSString *)page
{
    NSString *channelStrig;
    
    NSString *titleString = self.channelTitleButton.titleLabel.text;
    if ([titleString isEqualToString:@"账单"]) {
        channelStrig = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFChannelOfBillString];
    }else if ([titleString isEqualToString:@"返点"]){
        channelStrig = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFChannelOfRebateString];
    }else if ([titleString isEqualToString:@"进件"]){
        channelStrig = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFChannelOfIntoPiecesString];
    }else if ([titleString isEqualToString:@"预估"]){
        channelStrig = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFChannelOfEstimateString];
    }
    self.billDic[@"start_date"] = self.billDic[@"start_date"]?self.billDic[@"start_date"]:@"";
    self.billDic[@"end_date"] = self.billDic[@"end_date"]?self.billDic[@"end_date"]:@"";
    [self.billDic setValue:page forKey:@"limit"];
    [self.billDic setValue:@"10" forKey:@"rows"];
    [self.billDic setValue:TOKEN forKey:@"token"];

    NSDictionary *params = self.billDic;
    
    ZXWeakSelf;
    [self requestDataGetWithUrlString:channelStrig paramter:params SucceccBlock:^(id responseObject) {
        
        if ([page integerValue] == 1) {
            [weakself.billDataArray removeAllObjects];
        }
        ChannelResponse *channelResponse = [ChannelResponse objectWithKeyValues:responseObject];
        
        if (channelResponse.list.count == 0) {
            _pageChannel--;
        }
        
        for (BillModel *billModel in channelResponse.list) {
            [weakself.billDataArray addObject:billModel];
        }
        
        if (weakself.billDataArray.count == 0) {
            [weakself.remindButton setHidden:NO];
            NSString *remindStr = [NSString stringWithFormat:@"对不起，暂时没有%@！",titleString];
            [weakself.remindButton.noTextButton setTitle:remindStr forState:0];
        }else{
            [weakself.remindButton setHidden:YES];
        }
        
        [weakself.channelTableView reloadData];
        
    } andFailedBlock:^{
        
    }];
}

- (void)headerRefreshOfChannel
{
    _pageChannel = 1;
    [self getListOfChannelWithPage:@"1"];
    ZXWeakSelf;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakself.channelTableView headerEndRefreshing];
    });
}

- (void)footerRefreshOfChannel
{
    _pageChannel++;
    NSString *page = [NSString stringWithFormat:@"%ld",(long)_pageChannel];
    [self getListOfChannelWithPage:page];
    
    ZXWeakSelf;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakself.channelTableView footerEndRefreshing];
    });
}

#pragma mark - method
- (void)rightAction
{
    EstimateViewController *estimateVC = [[EstimateViewController alloc] init];
    [self.navigationController pushViewController:estimateVC animated:YES];
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
