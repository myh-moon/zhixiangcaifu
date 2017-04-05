//
//  RedPacketViewController.m
//  zichanbao
//
//  Created by zhixiang on 15/10/19.
//  Copyright (c) 2015年 zhixiang. All rights reserved.
//

#import "RedPacketViewController.h"
#import "RedCell.h"

#import "NYSegmentedControl.h"
#import "NSDate+FormatterTime.h"

#import "RedPacketDetailViewController.h"

//红包
#import "RedModel.h"
#import "RedPacketModel.h"

//分享
#import "UMSocialConfig.h"
#import "UMSocialSnsService.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSnsPlatformManager.h"
#import "UMSocial.h"

@interface RedPacketViewController ()<UITableViewDataSource,UITableViewDelegate,UMSocialUIDelegate>

@property (nonatomic,strong) UIView *topView1;

@property (nonatomic,strong) NYSegmentedControl *redSegmentController; //发出的，收到的
@property (nonatomic,strong) UIView *whiteViewR;  //选择框－未使用，已使用，已过期
@property (nonatomic,strong) UILabel *orangeLabel1;
@property (nonatomic,strong) UITableView *getTableView;
@property (nonatomic,strong) UITableView *sendTableView;

//json解析数组
@property (nonatomic,copy)NSMutableArray *getRedArr;

@property (nonatomic,copy)NSMutableArray *sendRedArr;

@property (nonatomic,assign)NSInteger tagOpen;  //标记－未使用，已使用，已过期

//传参
@property (nonatomic,strong) NSString *typeString;

@end

@implementation RedPacketViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBackgroundColor;
    self.navigationItem.title = @"红包金额";
    self.navigationItem.leftBarButtonItem = self.leftItem;
    
    _tagOpen=0;//三个点击按钮进来选择
    self.typeString = @"1";
    
    [self.view addSubview:self.topView1];
    [self.view addSubview:self.sendTableView];
    [self.view addSubview:self.whiteViewR];
    [self.view addSubview:self.getTableView];
    [self.view addSubview:self.remindButton];
    [self.remindButton setHidden:YES];
    [self.remindButton setTitle:@"亲，您目前尚没有哦！" forState:0];
    
    [self requestGetRedPacketDataNoWithPage:@"1"];
    [self.getTableView addFooterWithTarget:self action:@selector(nofooterRefrresh)];
}

#pragma mark - request data
//我收到的
-(void)requestGetRedPacketDataNoWithPage:(NSString *)page
{
    NSString *redPacketUrl = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFpacketGet];
    NSDictionary *params = @{
                             @"token" : TOKEN,
                             @"type"  : self.typeString,
                             @"p"     : page
                             };
    
    ZXWeakSelf;
    [self requestDataGetWithUrlString:redPacketUrl paramter:params SucceccBlock:^(id responseObject){
        
        RedModel *listModel = [RedModel objectWithKeyValues:responseObject];
        
        for (RedPacketModel *getRedModel in listModel.list) {
            [weakself.getRedArr addObject:getRedModel];
        }
        
        if (listModel.list.count <= 0) {
            getRedPage--;
        }
        
        //显示提示语
        if (weakself.getRedArr.count <= 0) {
            [weakself.remindButton setHidden:NO];
        }else{
            [weakself.remindButton setHidden:YES];
        }
        
        [weakself.getTableView reloadData];
        
    } andFailedBlock:^{

    }];
}

//我收到的红包头部刷新
-(void)noHeaderRefresh
{
    if (_tagOpen == 0) {//未使用
        self.typeString = @"1";
    }else if (_tagOpen == 1){//已使用
        self.typeString = @"2";
    }else if (_tagOpen == 2){//已过期
        self.typeString = @"3";
    }
    
    [self.getRedArr removeAllObjects];
    getRedPage = 1;
    [self requestGetRedPacketDataNoWithPage:@"1"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.getTableView headerEndRefreshing];
    });
}

int getRedPage = 1;
-(void)nofooterRefrresh
{
    getRedPage += 1;
    NSString *page = [NSString stringWithFormat:@"%d",getRedPage];
    
    if (_tagOpen == 0) {//未使用
        self.typeString = @"1";
    }else if (_tagOpen == 1){//已使用
        self.typeString = @"2";
    }else if (_tagOpen == 2){//已过期
        self.typeString = @"3";
    }
    
    [self requestGetRedPacketDataNoWithPage:page];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.getTableView footerEndRefreshing];
    });
}

//我发出的
-(void)requestSendRedPacketDataWithPage:(NSString *)page
{
    NSString *sendRedPacketUrl = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFpacketSend];
    NSDictionary *params = @{
                             @"token" : TOKEN,
                             @"p"     : page
                             };
    
    ZXWeakSelf;
    [self requestDataGetWithUrlString:sendRedPacketUrl paramter:params SucceccBlock:^(id responseObject){
        
        RedModel *listModel = [RedModel objectWithKeyValues:responseObject];
        
        for (RedPacketModel *sendRedModel in listModel.list) {
            [weakself.sendRedArr addObject:sendRedModel];
        }
        
        if (listModel.list.count <= 0) {
            sendRedPage--;
        }
        
        //显示提示语
        if (weakself.sendRedArr.count <= 0) {
            
            [weakself.remindButton setHidden:NO];
        }else{
            [weakself.remindButton setHidden:YES];
        }
        
        [weakself.sendTableView reloadData];
    } andFailedBlock:^{

    }];
}

//我发出的红包头部底部刷新
-(void)sendHeaderRefresh
{
    [self.sendRedArr removeAllObjects];
    sendRedPage = 1;
    [self requestGetRedPacketDataNoWithPage:@"1"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.sendTableView headerEndRefreshing];
    });
}
int sendRedPage = 1;
-(void)sendfooterRefrresh
{
    sendRedPage += 1;
    NSString *page = [NSString stringWithFormat:@"%d",sendRedPage];
    [self requestSendRedPacketDataWithPage:page];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.sendTableView footerEndRefreshing];
    });
}

//share
-(void)shareRedPacketWithUrl:(NSString *)shareUrl
{
    [UMSocialSnsService presentSnsIconSheetView:self appKey:ZXUmengAppKey shareText:nil shareImage:[UIImage imageNamed:@"elephant"] shareToSnsNames:@[UMShareToWechatTimeline,UMShareToWechatSession,UMShareToQQ,UMShareToQzone] delegate:self];
    
    NSString *shareTitle = @"直向财富";
    NSString *shareText = @"红包滚滚来";
    
    //朋友圈
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = shareTitle;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = shareUrl;
    
    //微信
    [UMSocialData defaultData].extConfig.wechatSessionData.title = shareTitle;
    [UMSocialData defaultData].extConfig.wechatSessionData.shareText = shareText;
    [UMSocialData defaultData].extConfig.wechatSessionData.url = shareUrl;
    
    //QQ
    [UMSocialData defaultData].extConfig.qqData.title = shareTitle;
    [UMSocialData defaultData].extConfig.qqData.shareText = shareText;
    [UMSocialData defaultData].extConfig.qqData.url = shareUrl;
    
    //QZone
    [UMSocialData defaultData].extConfig.qzoneData.title = shareTitle;
    [UMSocialData defaultData].extConfig.qzoneData.shareText = shareText;
    [UMSocialData defaultData].extConfig.qzoneData.url = shareUrl;
}

#pragma mark - segment target
-(void)touchBtnClick1:(NYSegmentedControl *)segment
{
    //点击不同按钮请求数据
    if (segment.selectedSegmentIndex == 0) {
        
        self.whiteViewR.hidden = NO;
        [self.view bringSubviewToFront:self.getTableView];
        [self.view sendSubviewToBack:self.sendTableView];
        [self.getTableView addFooterWithTarget:self action:@selector(nofooterRefrresh)];
        
        [self noHeaderRefresh];
        
    }else{
        
        self.whiteViewR.hidden = YES;
        [self.view bringSubviewToFront:self.sendTableView];
        [self.view sendSubviewToBack:self.getTableView];
        [self.sendTableView addFooterWithTarget:self action:@selector(sendfooterRefrresh)];
        
        [self sendHeaderRefresh];
        
    }
}

#pragma  mark - button Click events
-(void)getPacket:(UIButton *)button
{
    _tagOpen = button.tag;
    [self noHeaderRefresh];
    
    [UIView animateWithDuration:0.5 animations:^{
        _orangeLabel1.frame=CGRectMake(button.left+20,28,button.width-40,2);
    }];
}

#pragma mark - tableView delegate and dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 500) {
        return self.getRedArr.count;
    }else if (tableView.tag == 501){
        return self.sendRedArr.count;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RedCell *cell = [RedCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (tableView.tag == 500) {//我收到的
        
        RedPacketModel *getModel = self.getRedArr[indexPath.row];
        
        cell.nameHongBao.text = [NSString stringWithFormat:@"收到了%@的红包",getModel.phone];
        cell.getTimeLab.text = [NSString stringWithFormat:@"获得时间:%@",[NSDate getYMDhmsFormatterTime:getModel.atime]];
        cell.indataLab.text = [NSString stringWithFormat:@"有效期限:%@",[NSDate getYMDhmsFormatterTime:getModel.exp_time]];
        [cell.moneyBtn setTitle:[NSString stringWithFormat:@"¥%@",getModel.umoney] forState:0];
        
        if ([self.typeString intValue] == 1) {//未使用
            [cell.moneyBtn setBackgroundColor:kNavigationColor];
        }else if ([self.typeString intValue] == 2){//已使用
            [cell.moneyBtn setBackgroundColor:[UIColor grayColor]];

        }else if ([self.typeString intValue] == 3){//已过期
            [cell.moneyBtn setBackgroundColor:[UIColor grayColor]];
        }
        
    }else if (tableView.tag == 501){//我发出的
        
        RedPacketModel *sendModel = self.sendRedArr[indexPath.row];
        
        NSInteger remainder = [sendModel.number intValue] - [sendModel.c intValue];
        cell.nameHongBao.text = [NSString stringWithFormat:@"%@个已拆开，还剩%ld个",sendModel.c,(long)remainder];
        
        cell.getTimeLab.text = [NSString stringWithFormat:@"获得时间:%@",[NSDate getYMDhmsFormatterTime:sendModel.addtime]];
        cell.indataLab.text = [NSString stringWithFormat:@"有效期限:%@",[NSDate getYMDhmsFormatterTime:sendModel.exp_time]];
        
        //状态
        //1.获取红包过期时间
        NSString *string1 = [NSDate getOtherYMDhmsFormatterTime:sendModel.exp_time];
        float float1 = [string1 floatValue];
        
        //2.获取系统当前时间
        NSDate *currentDate = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"YYYYMMDDHHMMSS"];
        NSString *locationString = [dateFormatter stringFromDate:currentDate];
        
        float float2 = [locationString floatValue];
        
        //3.得到时间差值
        float float3 = float2 - float1;
        
        //比较大小
        if (float3 < 0 && remainder > 0) {
            [cell.moneyBtn setTitle:@"发红包" forState:0];
            [cell.moneyBtn setBackgroundColor:kNavigationColor];
            ZXWeakSelf;
            [cell.moneyBtn addAction:^(UIButton *btn) {
                [weakself shareRedPacketWithUrl:sendModel.url];
            }];
        }else{
            [cell.moneyBtn setTitle:@"不能发" forState:0];
            [cell.moneyBtn setBackgroundColor:[UIColor grayColor]];
            cell.moneyBtn.userInteractionEnabled = NO;
        }
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    if (tableView.tag == 501) {
//        
//        RedPacketModel *model = self.sendRedArr[indexPath.row];
//        
//        RedPacketDetailViewController *redPacketDetailVC = [[RedPacketDetailViewController alloc] init];
//        redPacketDetailVC.redModel = model;
//        [self.navigationController pushViewController:redPacketDetailVC animated:YES];
//    }
}

#pragma mark - init view
-(UIView *)topView1
{
    if (!_topView1) {
        _topView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
        _topView1.backgroundColor = RGBCOLOR(0.4275, 0.2588, 0.3686);
        [_topView1 addSubview:self.redSegmentController];
    }
    return _topView1;
}

-(NYSegmentedControl *)redSegmentController
{
    if (!_redSegmentController) {
        _redSegmentController = [[NYSegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"我收到的",@"我发出的", nil]];
        _redSegmentController.frame = CGRectMake(20, 10, (kScreenWidth-20*2), 30);
        _redSegmentController.backgroundColor = kNavigationColor;
        _redSegmentController.titleTextColor = [UIColor whiteColor];
        _redSegmentController.selectedTitleTextColor = [UIColor whiteColor];
        _redSegmentController.cornerRadius = 15;
        _redSegmentController.borderColor = kNavigationColor;
        _redSegmentController.borderWidth = 1;
        _redSegmentController.segmentIndicatorBackgroundColor = RGBCOLOR(0.4275, 0.2588, 0.3686);
        _redSegmentController.segmentIndicatorBorderColor = RGBCOLOR(0.4275, 0.2588, 0.3686);
        _redSegmentController.selectedSegmentIndex = 0;
//        _redSegmentController.ta
        [_redSegmentController addTarget:self action:@selector(touchBtnClick1:) forControlEvents:UIControlEventValueChanged];
    }
    return _redSegmentController;
}

-(UIView *)whiteViewR
{
    if (!_whiteViewR) {
        _whiteViewR = [[UIView alloc] initWithFrame:CGRectMake(0, self.topView1.bottom, kScreenWidth, 30)];
        
        NSArray *renArray = [NSArray arrayWithObjects:@"未使用",@"已使用",@"已过期", nil];
        for (int j=0; j<renArray.count; j++) {
            UIButton *btn=[UIButton buttonWithType:0];
            btn.tag=j;
            btn.frame=CGRectMake((kScreenWidth/3)*j,0,kScreenWidth/3,30);
            btn.backgroundColor = [UIColor whiteColor];
            btn.titleLabel.font=[UIFont systemFontOfSize:14];
            [btn setTitle:renArray[j] forState:0];
            [btn setTitleColor:[UIColor blackColor] forState:0];
            [btn addTarget:self action:@selector(getPacket:) forControlEvents:UIControlEventTouchUpInside];
            [_whiteViewR addSubview:btn];
        }
        _orangeLabel1=[[UILabel alloc]initWithFrame:
                      CGRectMake(20,28,kScreenWidth/3-40,2)];
        _orangeLabel1.backgroundColor=[UIColor orangeColor];
        [_whiteViewR addSubview:_orangeLabel1];
    }
    
    return _whiteViewR;
}

//我收到的
-(UITableView *)getTableView
{
    if (!_getTableView) {
        _getTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, self.whiteViewR.bottom, kScreenWidth-10*2, kScreenHeight-self.topView1.height-self.whiteViewR.height-10-64) style:UITableViewStylePlain];
        _getTableView.delegate = self;
        _getTableView.dataSource = self;
        _getTableView.tag = 500;
        _getTableView.backgroundColor = kBackgroundColor;
        _getTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _getTableView.showsVerticalScrollIndicator = NO;
    }
    return _getTableView;
}

-(UITableView *)sendTableView
{
    if (!_sendTableView) {
        _sendTableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 64, kScreenWidth - 20, kScreenHeight-self.topView1.height-10-64) style:UITableViewStylePlain];
        _sendTableView.backgroundColor = kBackgroundColor;
        _sendTableView.delegate = self;
        _sendTableView.dataSource = self;
        _sendTableView.tag = 501;
        _sendTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _sendTableView.tableFooterView = [[UIView alloc] init];
        _sendTableView.showsVerticalScrollIndicator = NO;
    }
    return _sendTableView;
}

#pragma mark - init array
-(NSMutableArray *)getRedArr
{
    if (!_getRedArr) {
        _getRedArr = [NSMutableArray array];
    }
    return _getRedArr;
}

-(NSMutableArray *)sendRedArr
{
    if (!_sendRedArr) {
        _sendRedArr = [NSMutableArray array];
    }
    return _sendRedArr;
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
