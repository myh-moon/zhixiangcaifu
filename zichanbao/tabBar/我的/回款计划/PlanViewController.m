//
//  PlanViewController.m
//  zichanbao
//
//  Created by zhixiang on 15/10/15.
//  Copyright (c) 2015年 zhixiang. All rights reserved.
//

#import "PlanViewController.h"
#import "NYSegmentedControl.h"   //自定义segment
#import "PlanCell.h"  //自定义单元格

#import "PlanResponse.h"
#import "PlanResponseModel.h"
#import "PlanModel.h"


#import "NSDate+FormatterTime.h"

@interface PlanViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,assign) BOOL didSetupConstraints;
@property (nonatomic,strong) UIView *topView;
@property (nonatomic,strong) NYSegmentedControl *segmentController;
@property (nonatomic,strong) UITableView *planTableView;
@property (nonatomic,strong) NSMutableDictionary *dic;

//json解析
@property (nonatomic,strong) NSMutableArray *planArray;

@property (nonatomic,assign) BOOL type; //标记未还已还
@property (nonatomic,strong) NSString *statusStr;

@end

@implementation PlanViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = self.leftItem;
    self.view.backgroundColor = kBackgroundColor;
    
    if ([self.planType integerValue] == 1) {
        self.navigationItem.title = @"回款计划";
    }else if ([self.planType integerValue] == 2){
        self.navigationItem.title = @"还款计划";
    }

    //默认是未还
    _type = NO;
    self.statusStr = @"";
    
    [self.view addSubview:self.topView];
    [self.view addSubview:self.planTableView];
    [self.view addSubview:self.remindButton];
    [self.remindButton.noTextButton setTitle:@"亲，您暂时没有！" forState:0];
    [self.remindButton setHidden:YES];
    
    [self.view setNeedsUpdateConstraints];
    
    [self requestDataOfPlansWithPage:@"1"];
}

- (void)updateViewConstraints
{
    if (!self.didSetupConstraints) {
        
        [self.topView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
        [self.topView autoSetDimension:ALDimensionHeight toSize:50];
        
        [self.planTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
        [self.planTableView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.topView];
        
        [self.remindButton autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [self.remindButton autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        self.didSetupConstraints = YES;
    }
    [super updateViewConstraints];
}

#pragma mark - init view
-(UIView *)topView
{
    if (!_topView) {
        _topView = [UIView newAutoLayoutView];
//        [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
        _topView.backgroundColor = RGBCOLOR(0.4275, 0.2588, 0.3686);
        
        [_topView addSubview:self.segmentController];
        
        [self.segmentController autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_topView withOffset:20];
        [self.segmentController autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:_topView withOffset:-20];
        [self.segmentController autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_topView withOffset:10];
        [self.segmentController autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_topView withOffset:-10];
    }
    return _topView;
}

-(NYSegmentedControl *)segmentController
{
    if (!_segmentController) {
        _segmentController = [NYSegmentedControl newAutoLayoutView];
//        [[NYSegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"未还",@"已还", nil]];
//        _segmentController.frame = CGRectMake(20, 10, (kScreenWidth-20*2), 30);
        [_segmentController insertSegmentWithTitle:@"未还" atIndex:0];
        [_segmentController insertSegmentWithTitle:@"已还" atIndex:1];
        _segmentController.backgroundColor = kNavigationColor;
        _segmentController.titleTextColor = [UIColor whiteColor];
        _segmentController.selectedTitleTextColor = [UIColor whiteColor];
        _segmentController.cornerRadius = 15;
        _segmentController.borderColor = kNavigationColor;
        _segmentController.borderWidth = 1;
        _segmentController.segmentIndicatorBackgroundColor = RGBCOLOR(0.4275, 0.2588, 0.3686);
        _segmentController.segmentIndicatorBorderColor = RGBCOLOR(0.4275, 0.2588, 0.3686);
        _segmentController.selectedSegmentIndex = 0;
        [_segmentController addTarget:self action:@selector(moneyType:) forControlEvents:UIControlEventValueChanged];
    }
    return _segmentController;
}

//add tableView
-(UITableView *)planTableView
{
    if (!_planTableView) {
        _planTableView.translatesAutoresizingMaskIntoConstraints = NO;
        _planTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
//        [[UITableView alloc] initWithFrame:CGRectMake(0, self.topView.bottom, kScreenWidth, kScreenHeight-self.topView.height-64) style:UITableViewStyleGrouped];
        _planTableView.delegate = self;
        _planTableView.dataSource = self;
        _planTableView.tableFooterView = [[UIView alloc] init];
        _planTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_planTableView addFooterWithTarget:self action:@selector(planFooterRefresh)];
    }
    return _planTableView;
}

#pragma mark - init array and dic 

-(NSMutableArray *)planArray
{
    if (!_planArray) {
        _planArray = [NSMutableArray array];
    }
    return _planArray;
}

-(NSMutableDictionary *)dic
{
    if (!_dic) {
        _dic = [NSMutableDictionary dictionary];
    }
    return _dic;
}

#pragma mark - tableView dataSource and deegate/*
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.planArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //是否收缩
    NSString *key = [NSString stringWithFormat:@"1_%ld",section];
    if (!self.dic[key]) {
        return 0;
    }
    
    PlanResponseModel *planReponseModel = self.planArray[section];
    return planReponseModel.l.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"plan";
    PlanCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell =[[PlanCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = kBackgroundColor;
    
    //获取mdoel
    PlanResponseModel *planResponseModel = self.planArray[indexPath.section];
    PlanModel *planModel = planResponseModel.l[indexPath.row];
    cell.nameLabel.text = planModel.title;
    cell.dateLabel.text = [NSDate getMDFormatterTime:planModel.time];
    cell.moneyLabel.text = [NSString stringWithFormat:@"本金：%@元",planModel.capital];
    cell.rateLabel.text = [NSString stringWithFormat:@"利息：%@元",planModel.interest];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = [NSString stringWithFormat:@"1_%ld",indexPath.section];
    
    if (self.dic[key]) {
        return 90;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIButton *headerButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, 40)];
    headerButton.backgroundColor = kBackgroundColor;
    headerButton.tag = section;
    ZXWeakSelf;
    [headerButton addAction:^(UIButton *btn) {
        
        btn.selected = !btn.selected;
        NSInteger didSection = btn.tag;
        
        NSString *key = [NSString stringWithFormat:@"1_%ld",didSection];
        
        if (![weakself.dic objectForKey:key]) {
            [weakself.dic setObject:@"section" forKey:key];
        }else{
            [weakself.dic removeObjectForKey:key];
        }
        
        [weakself.planTableView reloadSections:[NSIndexSet indexSetWithIndex:didSection] withRowAnimation:UITableViewRowAnimationFade];
    }];
    
    PlanResponseModel *planResonseModel = self.planArray[section];
    
    //时间
    UILabel *timeLabel = [UILabel newAutoLayoutView];
    timeLabel.text = planResonseModel.k;
    timeLabel.textColor = [UIColor blackColor];
    timeLabel.font = [UIFont systemFontOfSize:18];
    [headerButton addSubview:timeLabel];
    
    //待收本息
    UILabel *moneyLabel = [UILabel newAutoLayoutView];
    moneyLabel.textAlignment = NSTextAlignmentRight;
    moneyLabel.textColor = [UIColor blackColor];
    moneyLabel.font = font14;
    
    moneyLabel.text = [NSString stringWithFormat:@"待收本息 ：%@元",planResonseModel.dsbx];
    [headerButton addSubview:moneyLabel];
    
    //按钮
    UIButton *bb = [UIButton newAutoLayoutView];
    [bb setImage:[UIImage imageNamed:@"arro"] forState:0];
//    bb.tag = section;
    bb.userInteractionEnabled = NO;
    [headerButton addSubview:bb];
    
    [timeLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:kSpacePadding];
    [timeLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    
    [moneyLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:timeLabel withOffset:kSpacePadding];
    [moneyLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:bb withOffset:-5];
    [moneyLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:timeLabel];
    
    [bb autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:kSpacePadding];
    [bb autoAlignAxis:ALAxisHorizontal toSameAxisOfView:timeLabel];
    
    return headerButton;
}

#pragma mark - method
#pragma mark - request data
-(void)requestDataOfPlansWithPage:(NSString *)page
{
    NSString *planString;
    //    = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFplans];
    if ([self.planType integerValue] == 1) {
        planString = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFplans];
    }else if ([self.planType integerValue] == 2){
        planString = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFrepayment];
    }
    NSDictionary *params = @{
                             @"token"  : TOKEN,
                             @"p"      : page,
                             @"status" : self.statusStr
                             };
    
    ZXWeakSelf;
    [self requestDataGetWithUrlString:planString paramter:params SucceccBlock:^(id responseObject){
        
        PlanResponse *respnse = [PlanResponse objectWithKeyValues:responseObject];
        for (PlanResponseModel *planResponserModel in respnse.list) {
            [weakself.planArray addObject:planResponserModel];
        }
        
        if (respnse.list == 0) {
            planPage--;
            [weakself showHint:@"没有更多了"];
        }
        
        if (weakself.planArray.count == 0) {
            [weakself.remindButton setHidden:NO];
        }else{
            [weakself.remindButton setHidden:YES];
        }
        
        [weakself.planTableView reloadData];
    } andFailedBlock:^{
    }];
}

-(void)planHeaderRefresh
{
    [self.planArray removeAllObjects];
    [self.dic removeAllObjects];
    
    planPage = 1;
    [self requestDataOfPlansWithPage:@"1"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.planTableView headerEndRefreshing];
    });
}
int planPage = 1;
-(void)planFooterRefresh
{
    planPage += 1;
    NSString *page = [NSString stringWithFormat:@"%d",planPage];
    [self requestDataOfPlansWithPage:page];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.planTableView footerEndRefreshing];
    });
}

#pragma mark - segment target
-(void)moneyType:(UISegmentedControl *)segment
{
    if (segment.selectedSegmentIndex == 0) {//未还
        _type = NO;
        self.statusStr = @"";
    }else{//已还
        _type = YES;
        self.statusStr = @"1";
    }
    
    [self.planTableView addFooterWithTarget:self action:@selector(planFooterRefresh)];
    
    [self planHeaderRefresh];
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
