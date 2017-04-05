//
//  MyShareViewController.m
//  zichanbao
//
//  Created by zhixiang on 15/10/16.
//  Copyright (c) 2015年 zhixiang. All rights reserved.
//

#import "MyShareViewController.h"
#import "MyShareRulesViewController.h"  //查看详细规则

//model
#import "MyShareModel.h"

#import "UMSocialConfig.h"
#import "UMSocialSnsService.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSnsPlatformManager.h"
#import "UMSocial.h"

@interface MyShareViewController ()<UIScrollViewDelegate,UMSocialUIDelegate>

@property (nonatomic,strong) UIScrollView *shareScrollView;
@property (nonatomic,strong) UILabel *shareLabel1;
@property (nonatomic,strong) UIImageView *shareImageView;
@property (nonatomic,strong) UILabel *sharelabel2;
//@property (nonatomic,strong) UILabel *shareLabel3;
//@property (nonatomic,strong) UIButton *shareBtn1;
//@property (nonatomic,strong) UIButton *shareBtn2;
//@property (nonatomic,strong) UILabel *shareLabel4;
//@property (nonatomic,strong) UILabel *sharelabel5;
//
//@property (nonatomic,strong) NSString *shareUrl;
//@property (nonatomic,strong) NSString *shareInfo;//规则

@end

@implementation MyShareViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = self.leftItem;
    self.navigationItem.title = @"我的分享";
    [self.view addSubview:self.shareScrollView];
    
    [self requestDataOfShare];
}

#pragma mark - request data
-(void)requestDataOfShare
{
    NSString *shareString = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFshare];
    NSDictionary *param = @{
                            @"token" : TOKEN
                            };
    
    ZXWeakSelf;
    [self requestDataGetWithUrlString:shareString paramter:param SucceccBlock:^(id responseObject){
               
        MyShareModel *model = [MyShareModel objectWithKeyValues:responseObject];
        
        if (!model.status) {//正常
            //分享码
            weakself.sharelabel2.text = [NSString stringWithFormat:@"您的分享码：%@",model.code];
//            //返利
//            self.shareLabel3.text = [NSString stringWithFormat:@"好友获得%@，您可以获得%@",model.rate,model.rate];
//            //分享地址
//            _shareUrl = model.url;
//            _shareInfo = model.info;
        }
    } andFailedBlock:^{

    }];
}

/*
//分享
-(void)shareCode
{
    [UMSocialSnsService presentSnsIconSheetView:self appKey:ZXUmengAppKey shareText:nil shareImage:[UIImage imageNamed:@"elephant"] shareToSnsNames:@[UMShareToWechatTimeline,UMShareToWechatSession,UMShareToQQ,UMShareToQzone] delegate:self];
    
    NSString *shareText = [NSString stringWithFormat:@"%@\n%@",self.sharelabel2.text,self.shareLabel3.text];
    NSString *shareUrl = _shareUrl;
    
    //wechatTimeline
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = shareText;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = shareUrl;
    
    //wechat
    [UMSocialData defaultData].extConfig.wechatSessionData.title = @"直向财富：";
    [UMSocialData defaultData].extConfig.wechatSessionData.shareText = shareText;
    [UMSocialData defaultData].extConfig.wechatSessionData.url = shareUrl;
    
    //QQ
    [UMSocialData defaultData].extConfig.qqData.title = @"直向财富：";
    [UMSocialData defaultData].extConfig.qqData.shareText = shareText;
    [UMSocialData defaultData].extConfig.qqData.url = shareUrl;
    
    //Qone
    [UMSocialData defaultData].extConfig.qzoneData.title = @"直向财富：";
    [UMSocialData defaultData].extConfig.qzoneData.shareText = shareText;
    [UMSocialData defaultData].extConfig.qzoneData.url = shareUrl;
}
 */

#pragma mark - init view
-(UIScrollView *)shareScrollView
{
    if (!_shareScrollView) {
        _shareScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)];
        _shareScrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight);
        _shareScrollView.showsVerticalScrollIndicator = NO;
        
        [_shareScrollView addSubview:self.shareLabel1];
        [_shareScrollView addSubview:self.shareImageView];
        [_shareScrollView addSubview:self.sharelabel2];
//        [_shareScrollView addSubview:self.shareLabel3];
//        [_shareScrollView addSubview:self.shareBtn1];
//        [_shareScrollView addSubview:self.shareBtn2];
//        [_shareScrollView addSubview:self.shareLabel4];
//        [_shareScrollView addSubview:self.sharelabel5];
        
    }
    return _shareScrollView;
}

-(UILabel *)shareLabel1
{
    if (!_shareLabel1) {
        _shareLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, 40)];
        _shareLabel1.text = @"悦 分 享，越 收 益";
        [_shareLabel1 setFont:[UIFont fontWithName:@"Helvetica-Bold" size:22]];
        _shareLabel1.textColor = kNavigationColor;
        _shareLabel1.textAlignment = NSTextAlignmentCenter;
    }
    return _shareLabel1;
}

-(UIImageView *)shareImageView
{
    if (!_shareImageView) {
        _shareImageView = [[UIImageView alloc] initWithFrame:CGRectMake(80, self.shareLabel1.bottom+10, kScreenWidth-80*2, kScreenWidth-80*2)];
        _shareImageView.image = [UIImage imageNamed:@"fenxiangma"];
    }
    return _shareImageView;
}

-(UILabel *)sharelabel2
{
    if (!_sharelabel2) {
        _sharelabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, self.shareImageView.bottom+20, kScreenWidth, 20)];
        _sharelabel2.textColor = [UIColor blackColor];
//        _sharelabel2.text = @"您 的 分 享 码 ：M34343454";
        _sharelabel2.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
        _sharelabel2.textAlignment = NSTextAlignmentCenter;
    }
    return _sharelabel2;
}

//-(UILabel *)shareLabel3
//{
//    if (!_shareLabel3) {
//        
//        _shareLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(0, self.sharelabel2.bottom+5, kScreenWidth, 20)];
//        _shareLabel3.text = @"好 友 获 得 0.1%，您 可 以 获 得0.1%";
//        _shareLabel3.textColor = [UIColor grayColor];
//        _shareLabel3.textAlignment = NSTextAlignmentCenter;
//        _shareLabel3.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
//    }
//    return _shareLabel3;
//}
//
//-(UIButton *)shareBtn1
//{
//    if (!_shareBtn1) {
//        _shareBtn1 = [UIButton buttonWithType:0];
//        _shareBtn1.frame = CGRectMake((kScreenWidth-100)/2, self.shareLabel3.bottom+10, 100, 40);
//        [_shareBtn1 setBackgroundColor:kNavigationColor];
//        _shareBtn1.layer.cornerRadius = 2;
//        [_shareBtn1 setTitle:@"分 享" forState:0];
//        [_shareBtn1 setTitleColor:[UIColor whiteColor] forState:0];
//        
//        ZXWeakSelf;
//        [_shareBtn1 addAction:^(UIButton *btn) {
//            [weakself shareCode];
//        }];
//    }
//    return _shareBtn1;
//}
//
//-(UIButton *)shareBtn2
//{
//    if (!_shareBtn2) {
//        _shareBtn2 = [UIButton buttonWithType:0];
//        _shareBtn2.frame = CGRectMake(kScreenWidth-160, self.shareBtn1.bottom+30,120,20);
//        [_shareBtn2 setTitle:@"查 看 详 细 规 则" forState:0];
//        _shareBtn2.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
//        [_shareBtn2 setTitleColor:kNavigationColor forState:0];
//        ZXWeakSelf;
//        [_shareBtn2 addAction:^(UIButton *btn) {
//            MyShareRulesViewController *myShareRulesVC = [[MyShareRulesViewController alloc] init];
//            myShareRulesVC.info = weakself.shareInfo;
//            [weakself.navigationController pushViewController:myShareRulesVC animated:YES];
//        }];
//    }
//    return _shareBtn2;
//}
//
//-(UILabel *)shareLabel4
//{
//    if (!_shareLabel4) {
//        _shareLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(0, self.shareBtn2.bottom+10, kScreenWidth, 40)];
//        _shareLabel4.textAlignment = NSTextAlignmentCenter;
//        _shareLabel4.text = @"*被邀请人输入邀请码成功投资后，投资人\n和您共同收益，不限次数";
//        _shareLabel4.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
//        _shareLabel4.numberOfLines = 0;
//        _shareLabel4.textColor = [UIColor lightGrayColor];
//    }
//    return _shareLabel4;
//}
//
//-(UILabel *)sharelabel5
//{
//    if (!_sharelabel5) {
//        _sharelabel5 = [[UILabel alloc] initWithFrame:CGRectMake(0, self.shareLabel4.bottom+10, kScreenWidth, 20)];
//        _sharelabel5.textColor = [UIColor lightGrayColor];
//        _sharelabel5.text = @"*返利将在每月您收到投资收益的同时进入双方本站账户";
//        _sharelabel5.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
//        _sharelabel5.textAlignment = NSTextAlignmentCenter;
//    }
//    return _sharelabel5;
//}

#pragma mark - share
/*
-(void)shareMyCode
{
    [UMSocialSnsService presentSnsIconSheetView:self appKey:ZXUmengAppKey shareText:@"我的分享码" shareImage:[UIImage imageNamed:@"elephant"] shareToSnsNames:@[UMShareToLWTimeline,UMShareToWechatSession,UMShareToQQ,UMShareToQzone] delegate:self];
    
    //朋友圈
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = @"直向财富";
    [UMSocialData defaultData].extConfig.wechatTimelineData.shareText = @"放心无忧";
    
    //微信
    [UMSocialData defaultData].extConfig.wechatSessionData.title = @"直向财富";
    [UMSocialData defaultData].extConfig.wechatSessionData.shareText = @"放心无忧";
    
    //QQ
    [UMSocialData defaultData].extConfig.qqData.title = @"直向财富";
    [UMSocialData defaultData].extConfig.qqData.shareText = @"放心无忧";
    
    //QZone
    [UMSocialData defaultData].extConfig.qzoneData.title = @"直向财富";
    [UMSocialData defaultData].extConfig.qzoneData.shareText = @"放心无忧";
}
 */

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
