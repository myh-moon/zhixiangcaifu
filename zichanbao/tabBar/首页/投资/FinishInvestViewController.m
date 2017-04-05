//
//  FinishInvestViewController.m
//  zichanbao
//
//  Created by zhixiang on 15/10/23.
//  Copyright (c) 2015年 zhixiang. All rights reserved.
//

#import "FinishInvestViewController.h"
#import "UMSocialConfig.h"
#import "UMSocialSnsService.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSnsPlatformManager.h"
#import "UMSocial.h"

@interface FinishInvestViewController ()<UMSocialUIDelegate>

@property (nonatomic,strong) UIView *view1;
//@property (nonatomic,strong) UIWindow *window;
@property (nonatomic,strong) UIView *grayView;
@property (nonatomic,strong) UIImageView *imageView;

@end

@implementation FinishInvestViewController
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"投资成功";
    self.view.backgroundColor = kBackgroundColor;
    self.navigationItem.leftBarButtonItem = self.leftItem;
    
    [self.view addSubview:self.view1];
}

#pragma mark - 覆盖
//返回
-(void)back
{
    UINavigationController *nav = self.navigationController;
    [nav popViewControllerAnimated:NO];
    [nav popViewControllerAnimated:NO];
    [nav popViewControllerAnimated:NO];
}
////投资成功分享
//-(void)shareApp
//{
//    [UMSocialSnsService presentSnsIconSheetView:self appKey:ZXUmengAppKey shareText:nil shareImage:[UIImage imageNamed:@"elephant"] shareToSnsNames:@[UMShareToWechatTimeline,UMShareToWechatSession,UMShareToQQ,UMShareToQzone] delegate:self];
//    
//    NSString *shareTitle = @"直向财富：";
//    NSString *sharetext = [NSString stringWithFormat:@"%@\n%@",@"投资成功",@"您的收益将增加"];
//    NSString *shareUrl = self.finishModel.url;
//    
//    //wechatTimeline
//    [UMSocialData defaultData].extConfig.wechatTimelineData.title = [NSString stringWithFormat:@"%@\n%@",shareTitle,@"投资成功，您的收益将增加"];
//    [UMSocialData defaultData].extConfig.wechatTimelineData.url = shareUrl;
//    
//    //wechatSession
//    [UMSocialData defaultData].extConfig.wechatSessionData.title = shareTitle;
//    [UMSocialData defaultData].extConfig.wechatSessionData.shareText = sharetext;
//    [UMSocialData defaultData].extConfig.wechatSessionData.url = shareUrl;
//    
//    //QQ
//    [UMSocialData defaultData].extConfig.qqData.title = shareTitle;
//    [UMSocialData defaultData].extConfig.qqData.shareText = sharetext;
//    [UMSocialData defaultData].extConfig.qqData.url = shareUrl;
//    
//    //QQZone
//    [UMSocialData defaultData].extConfig.qzoneData.title = shareTitle;
//    [UMSocialData defaultData].extConfig.qzoneData.shareText = sharetext;
//    [UMSocialData defaultData].extConfig.qzoneData.url = shareUrl;
//}

#pragma mark - request data
//-(void)requestDataOfSendPacket
//{
//    NSString *sendPacketString = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFsendPacket];
//    NSDictionary *params = @{
//                             @"token" : TOKEN,
//                             @"id" : self.finishModel.pid
//                             };
//    [self requestDataGetWithUrlString:sendPacketString paramter:params SucceccBlock:^(id responseObject){
//        
//        InvestSuccessPacketModel *sendPacketModel = [InvestSuccessPacketModel objectWithKeyValues:responseObject];
//        
//        if ([sendPacketModel.status intValue] == 1) {//发送成功
//            [self sharePacketWithUrl:sendPacketModel.url];
//        }else{
//            [self showMBProgressHUDWithText:sendPacketModel.info];
//        }
//        
//    } andFailedBlock:^{
//        [self showNetHUD];
//
//    }];
//}

//-(void)sharePacketWithUrl:(NSString *)shareUrl
//{
//    NSLog(@"红包发送成功");
//    //分享红包
//    [UMSocialSnsService presentSnsIconSheetView:self appKey:ZXUmengAppKey shareText:nil shareImage:[UIImage imageNamed:@"elephant"] shareToSnsNames:@[UMShareToWechatTimeline,UMShareToWechatSession,UMShareToQQ,UMShareToQzone] delegate:self];
//    
//    NSString *shareTitle = @"直向财富：";
//    NSString *sharetext = [NSString stringWithFormat:@"%@\n%@",@"投资成功发红包啦",@"快来抢吧！"];
//    
//    //朋友圈
//    [UMSocialData defaultData].extConfig.wechatTimelineData.title = [NSString stringWithFormat:@"%@\n%@",shareTitle,@"投资成功发红包，快来抢！"];
//    [UMSocialData defaultData].extConfig.wechatTimelineData.url = shareUrl;
//    
//    //微信好友
//    [UMSocialData defaultData].extConfig.wechatSessionData.title = shareTitle;
//    [UMSocialData defaultData].extConfig.wechatSessionData.shareText = sharetext;
//    [UMSocialData defaultData].extConfig.wechatSessionData.url = shareUrl;
//    
//    //QQ
//    [UMSocialData defaultData].extConfig.qqData.title = shareTitle;
//    [UMSocialData defaultData].extConfig.qqData.shareText = sharetext;
//    [UMSocialData defaultData].extConfig.qqData.url = shareUrl;
//    
//    //QQZone
//    [UMSocialData defaultData].extConfig.qzoneData.title = shareTitle;
//    [UMSocialData defaultData].extConfig.qzoneData.shareText = sharetext;
//    [UMSocialData defaultData].extConfig.qzoneData.url = shareUrl;
//}

#pragma mark - init view
-(UIView *)view1
{
    if (!_view1) {
        _view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 210)];
        _view1.backgroundColor = [UIColor whiteColor];
        
        //image
        UIImageView *successImage = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth-60)/2, 30, 60, 60)];
        [successImage setImage:[UIImage imageNamed:@"dui"]];
        [_view1 addSubview:successImage];
        
        //投资成功
        UILabel *successLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, successImage.bottom+10, kScreenWidth, 20)];
        successLabel1.text = self.finishModel.info_1;
        //@"投 资 成 功";
        successLabel1.font = [UIFont systemFontOfSize:16];
        successLabel1.textColor = [UIColor blackColor];
        successLabel1.textAlignment = NSTextAlignmentCenter;
        [_view1 addSubview:successLabel1];
        
        //预计收益
        UILabel *successLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, successLabel1.bottom, kScreenWidth, 30)];
        successLabel2.text = self.finishModel.info_2;
        //@"预 计 收 益：10000元";
        successLabel2.font = font14;
        successLabel2.textColor = [UIColor blackColor];
        successLabel2.textAlignment = NSTextAlignmentCenter;
        [_view1 addSubview:successLabel2];
        
        //放款日期
        UILabel *successLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(0, successLabel2.bottom, kScreenWidth, 60)];
        successLabel3.text = [NSString stringWithFormat:@"%@\n\n%@",self.finishModel.info_3,self.finishModel.info_4];
        //@"放款日期：确认后放款\n\n计息日期：放款后T＋1计息";
        successLabel3.font = [UIFont systemFontOfSize:12];
        successLabel3.textColor = [UIColor blackColor];
        successLabel3.textAlignment = NSTextAlignmentCenter;
        successLabel3.numberOfLines = 0;
        [_view1 addSubview:successLabel3];
        
    }
    return _view1;
}

/*
-(void)successView
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    //background
    self.grayView = [[UIView alloc] initWithFrame:self.view.frame];
    [self.grayView setBackgroundColor:[UIColor blackColor]];
    self.grayView.alpha = 0.5;
    [window addSubview:self.grayView];
    
    //image
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth*0.1, kScreenHeight*0.3, kScreenWidth*0.8,kScreenWidth*0.82)];
    [self.imageView setImage:[UIImage imageNamed:@"hongbaobings"]];
    [window addSubview:self.imageView];
    self.imageView.userInteractionEnabled = YES;
    
    //gesture
    UITapGestureRecognizer *tapOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)];
    tapOne.numberOfTapsRequired = 1;
    [self.imageView addGestureRecognizer:tapOne];
}
//点击手势
-(void)click:(UITapGestureRecognizer *)tapGesture
{
    NSLog(@"点击发红包");
    [self.grayView removeFromSuperview];
    [self.imageView removeFromSuperview];
    
    [self requestDataOfSendPacket];
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
