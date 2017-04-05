//
//  MainViewController.m
//  zichanbao
//
//  Created by zhixiang on 15/10/9.
//  Copyright (c) 2015年 zhixiang. All rights reserved.
//

#import "MainViewController.h"
#import "LoginViewController.h"
#import "InvestDetailsViewController.h"  //投资,预约详情
#import "InvestViewController.h"     //投资
#import "OrderViewController.h"  //预约
#import "NewsProViewController.h"  //新闻宣传
#import "ExhibiteViewController.h"


#import "Reachability.h"        //判断网络
#import "DataBase.h"       //数据库
#import "UIImageView+WebCache.h"   //加载图片
#import "UIButton+WebCache.h"
#import "JKCountDownButton.h"

#import "MainServiceCell.h"
#import "MainBidCell.h"
#import "BorrowBaseCell.h"

//json解析
#import "MainBidResponse.h"
#import "MainBidModel.h"
#import "ImageModel.h"
#import "InvestDetailCommitModel.h"
#import "InvestDetailCommitOrderModel.h"

@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (nonatomic,assign) BOOL didSetupConstraints;
@property (nonatomic,strong) UITableView *mainTableView;
@property (nonatomic,strong) UIScrollView *mainScrollView;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) NSMutableArray *adsArray;//广告图片
@property (nonatomic,strong) NSMutableArray *adsUrlArray; //广告地址

//投标tableView
@property (nonatomic,strong) NSMutableArray *bidDataArray; //推荐
@property (nonatomic,strong) UITableView *bidTableView;

@end

@implementation MainViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    
    self.navigationController.navigationBarHidden = YES;
    
    [self requestDataOfMainBid];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kBackgroundColor;
    self.navigationItem.title = @"首页";
  
    [self.view addSubview:self.mainTableView];
    
    [self.view setNeedsUpdateConstraints];
    
//    [self exhibiteBigImage];
    
    //检查更新
//    [self performSelector:@selector(chechNewApp) withObject:nil afterDelay:10];
}

- (void)updateViewConstraints
{
    if (!self.didSetupConstraints) {
        
        [self.mainTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
        
        self.didSetupConstraints = YES;
    }
    [super updateViewConstraints];
}

#pragma mark - init view
- (UITableView *)mainTableView
{
    if (!_mainTableView) {
        _mainTableView.translatesAutoresizingMaskIntoConstraints = NO;
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _mainTableView.backgroundColor = kBackgroundColor;
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kSmallPadding)];
    }
    return _mainTableView;
}

-(UIScrollView *)mainScrollView
{
    if (!_mainScrollView) {
        _mainScrollView = [UIScrollView newAutoLayoutView];
        _mainScrollView.contentSize = CGSizeMake(kScreenWidth*self.adsArray.count ,160);
        _mainScrollView.showsVerticalScrollIndicator = NO;
        _mainScrollView.backgroundColor = kDarkGrayColor;
        _mainScrollView.pagingEnabled = YES;
        _mainScrollView.delegate = self;
        _mainScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _mainScrollView;
}

-(UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [UIPageControl newAutoLayoutView];
        _pageControl.numberOfPages = self.adsArray.count;
        _pageControl.currentPageIndicatorTintColor = kNavigationColor;
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    }
    return _pageControl;
}

/*
//init mainScrollView
-(UIScrollView *)mainScrollView
{
    if (!_mainScrollView) {
        _mainScrollView = [UIScrollView newAutoLayoutView];
        _mainScrollView.contentSize = CGSizeMake(kScreenWidth*self.adsArray.count ,160);
        _mainScrollView.showsVerticalScrollIndicator = NO;
        _mainScrollView.backgroundColor = kDarkGrayColor;
        _mainScrollView.pagingEnabled = YES;
        
//        //顶部轮播图
//        [_mainScrollView addSubview:self.scrollView];
//        [_mainScrollView addSubview:self.pageControl];
//        [_mainScrollView addSubview:self.bidTableView];
//        [_mainScrollView addSubview:self.mainColletionView];
    }
    return _mainScrollView;
}

//header scrollView
-(UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.frame = CGRectMake(0,0, kScreenWidth, 160);
        _scrollView.delegate = self;
        
        //1.设置其他属性
        _scrollView.contentSize = CGSizeMake(self.adsArray.count * kScreenWidth, 0);
       _scrollView.pagingEnabled = YES;
       _scrollView.showsHorizontalScrollIndicator = NO;
        
        //2.添加图片
        CGFloat imageW = _scrollView.width;
        CGFloat imageH = _scrollView.height;
        
        for (int i = 0; i < self.adsArray.count; i++) {
            //创建UIImageView
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.frame = CGRectMake(imageW * i, 0, imageW, imageH);
            imageView.image = [UIImage imageNamed:self.adsArray[i]];
            [_scrollView addSubview:imageView];
            
            //添加手势
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
            [imageView addGestureRecognizer:tap];
            imageView.userInteractionEnabled = YES;
            [tap addTarget:self action:@selector(showNews)];
        }
        
        [self playOn];
    }
    return _scrollView;
}

-(UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [UIPageControl newAutoLayoutView];
        _pageControl.numberOfPages = self.adsArray.count;
//        _pageControl = pageControl;
//        _pageControl.center = CGPointMake(kScreenWidth * 0.5, self.scrollView.height - 10);
//        _pageControl.frame = CGRectMake((kScreenWidth-100)/2,self.scrollView.bottom-20, 100, 10);
        _pageControl.currentPageIndicatorTintColor = kNavigationColor;
        //RGBCOLOR1(48, 0, 106);
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        //RGBCOLOR1(189, 189, 189);
    }
    return _pageControl;
}

// init bidTableView
-(UITableView *)bidTableView
{
    if (!_bidTableView) {
        _bidTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,self.scrollView.bottom+10, kScreenWidth, 120) style:UITableViewStylePlain];
        _bidTableView.dataSource = self;
        _bidTableView.delegate = self;
        _bidTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _bidTableView;
}
 */

/*
//首页轮播图
-(void)setUpCyclePlayPictures
{
    //1.添加scrollView
//    [self.view addSubview:self.scrollView];
//    [self.mainScrollView addSubview:self.scrollView];

    //2.添加图片
    CGFloat imageW = self.scrollView.width;
    CGFloat imageH = self.scrollView.height;
    
    for (int i = 0; i < self.adsArray.count; i ++) {
        //创建UIImageView
        UIImageView *imageView = [[UIImageView alloc] init];
//        [imageView sd_setImageWithURL:self.adsArray[i]];
        imageView.image = self.adsArray[i];
        imageView.tag = i;
        imageView.userInteractionEnabled = YES;
//        imageView.backgroundColor = [UIColor redColor];
        [self.scrollView addSubview:imageView];
        //设置frame
//        imageView.left = i * imageW;
//        imageView.top = 0;
        imageView.frame = CGRectMake(i*imageW, 0, imageW, imageH);
//        imageView.width = imageW;
//        imageView.height = imageH;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
        tap.numberOfTapsRequired = 1;
        [imageView addGestureRecognizer:tap];
    }
    
    //3.设置其他属性
//    self.scrollView.contentSize = CGSizeMake(self.adsArray.count * imageW, 0);
//    self.scrollView.pagingEnabled = YES;
//    self.scrollView.showsHorizontalScrollIndicator = NO;
//    _scrollView = scrollView;
    
    //添加pageControl
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = self.adsArray.count;
    _pageControl = pageControl;
    
    _pageControl.center = CGPointMake(kScreenWidth * 0.5, self.scrollView.height - 10);
    
//    _pageControl.centerX = kScreenWidth * 0.5;
//    _pageControl.centerY = scrollView.height - 10 + 64;
    [self.mainScrollView addSubview:_pageControl];
    
    //设置圆点颜色
    _pageControl.currentPageIndicatorTintColor = RGBCOLOR1(48, 0, 106);
    _pageControl.pageIndicatorTintColor = RGBCOLOR1(189, 189, 189);
    
    [self playOn];
}
*/

/*
-(void)playOn{
    _timer=[NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
}

-(void)nextImage{
    int i=self.mainScrollView.contentOffset.x/self.mainScrollView.frame.size.width;
    if (i==self.adsArray.count-1) {
        i=-1;
    }
    i++;
    self.mainScrollView.contentOffset=CGPointMake(self.scrollView.frame.size.width*i, 0);
    self.pageControl.currentPage=i;
}
 */


#pragma mark - init array
-(NSMutableArray *)adsArray
{
    if (!_adsArray) {
        _adsArray = [NSMutableArray new];
    }
    return _adsArray;
}

- (NSMutableArray *)bidDataArray
{
    if (!_bidDataArray) {
        _bidDataArray = [NSMutableArray array];
    }
    return _bidDataArray;
}

/*
#pragma mark - UIScrollViewDelegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self playOff];
}

-(void)playOff{
    [_timer invalidate];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self playOn];
    _pageControl.currentPage = self.mainScrollView.contentSize.width/kScreenWidth;
}

-(void)tapGesture:(UITapGestureRecognizer *)tap
{
    HomeAdsLinkVC *homeAdsVC = [[HomeAdsLinkVC alloc] init];
    homeAdsVC.urlStr = self.adsUrlArray[tap.view.tag];
    homeAdsVC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:homeAdsVC animated:YES];
}
 */


#pragma mark - tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1+self.bidDataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0){
        return 195;
    }
    return 140;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier;
    if (indexPath.section == 0) {
        identifier = @"main0";
        MainServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[MainServiceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellStyleDefault;
        cell.backgroundColor = kBackgroundColor;
        [cell.serviceBigButton addAction:^(UIButton *btn) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"征信查询" object:nil];
            UITabBarController *tabbarController = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
            tabbarController.selectedViewController = tabbarController.viewControllers[3];
        }];
        [cell.serviceButton1 addAction:^(UIButton *btn) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"直e贷" object:nil];
            UITabBarController *tabbarController = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
            tabbarController.selectedViewController = tabbarController.viewControllers[1];
        }];
        [cell.serviceButton2 addAction:^(UIButton *btn) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"房抵贷" object:nil];
            UITabBarController *tabbarController = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
            tabbarController.selectedViewController = tabbarController.viewControllers[1];
        }];
        
        return cell;
    }else{
        identifier = @"main1";
        MainBidCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[MainBidCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        MainBidModel *bidModel = self.bidDataArray[indexPath.section-1];
        
        //code
        NSString *ttt = [NSString stringWithFormat:@" %@",bidModel.type_name];
        NSMutableAttributedString *codes = [NSString getStringFromFirstString:ttt andFirstColor:kDarkGrayColor andFirstFont:[UIFont fontWithName:@"Helvetica-Bold" size:14] ToSecondString:bidModel.borrow_name andSecondColor:kDarkGrayColor andSecondFont:font14];
        [cell.codeButton setAttributedTitle:codes forState:0];
        
        if ([bidModel.type_name isEqualToString:@"直e贷"]) {
            [cell.codeButton setImage:[UIImage imageNamed:@"e"] forState:0];//直e贷
        }else if ([bidModel.type_name isEqualToString:@"房抵贷"]){
            [cell.codeButton setImage:[UIImage imageNamed:@"f"] forState:0];//房抵贷
        }

        //typeImage
        if (indexPath.section == 1) {
            [cell.typeButton setImage:[UIImage imageNamed:@"remen"] forState:0];//热门
        }else{
            [cell.typeButton setImage:[UIImage imageNamed:@"tuijian"] forState:0];//推荐
        }
        
        //content1
        NSString *con1 = [bidModel.borrow_interest_rate substringToIndex:bidModel.borrow_interest_rate.length-1];
        NSString *con11 = [bidModel.borrow_interest_rate substringFromIndex:bidModel.borrow_interest_rate.length-1];
        NSString *con111 = @"\n收益";
        NSString *conss1 = [NSString stringWithFormat:@"%@%@%@",con1,con11,con111];
        NSMutableAttributedString *attributeCon1 = [[NSMutableAttributedString alloc] initWithString:conss1];
        [attributeCon1 setAttributes:@{NSFontAttributeName:font22,NSForegroundColorAttributeName:kPurpleColor} range:NSMakeRange(0, con1.length)];
        [attributeCon1 setAttributes:@{NSFontAttributeName:font12,NSForegroundColorAttributeName:kPurpleColor} range:NSMakeRange(con1.length, con11.length)];
        [attributeCon1 setAttributes:@{NSFontAttributeName:font14,NSForegroundColorAttributeName:kGrayColor} range:NSMakeRange(con1.length+con11.length, con111.length)];
        [cell.contenLabel1 setAttributedText:attributeCon1];
        
        //content2
        NSString *con2 = [bidModel.borrow_duration substringToIndex:bidModel.borrow_duration.length-2];
        NSString *con22 = [bidModel.borrow_duration substringFromIndex:bidModel.borrow_duration.length-2];
        NSString *con222 = @"\n期限";
        NSString *conss2 = [NSString stringWithFormat:@"%@%@%@",con2,con22,con222];
        NSMutableAttributedString *attributeCon2 = [[NSMutableAttributedString alloc] initWithString:conss2];
        [attributeCon2 setAttributes:@{NSFontAttributeName:font22,NSForegroundColorAttributeName:kNavigationColor} range:NSMakeRange(0, con2.length)];
        [attributeCon2 setAttributes:@{NSFontAttributeName:font12,NSForegroundColorAttributeName:kNavigationColor} range:NSMakeRange(con2.length, con22.length)];
        [attributeCon2 setAttributes:@{NSFontAttributeName:font14,NSForegroundColorAttributeName:kGrayColor} range:NSMakeRange(con2.length+con22.length, con222.length)];
        [cell.contenLabel2 setAttributedText:attributeCon2];
        
        
        //content3
        NSString *con3 = [bidModel.borrow_money substringToIndex:bidModel.borrow_money.length-1];
        NSString *con33 = [bidModel.borrow_money substringFromIndex:bidModel.borrow_money.length-1];
        NSString *con333 = @"\n金额";
        NSString *conss3 = [NSString stringWithFormat:@"%@%@%@",con3,con33,con333];
        NSMutableAttributedString *attributeCon3 = [[NSMutableAttributedString alloc] initWithString:conss3];
        [attributeCon3 setAttributes:@{NSFontAttributeName:font22,NSForegroundColorAttributeName:kNavigationColor} range:NSMakeRange(0, con3.length)];
        [attributeCon3 setAttributes:@{NSFontAttributeName:font12,NSForegroundColorAttributeName:kNavigationColor} range:NSMakeRange(con3.length, con33.length)];
        [attributeCon3 setAttributes:@{NSFontAttributeName:font14,NSForegroundColorAttributeName:kGrayColor} range:NSMakeRange(con3.length+con33.length, con333.length)];
        [cell.contenLabel3 setAttributedText:attributeCon3];
        
        //progressView
        cell.progressView.progress = [[NSString stringWithFormat:@"%@",bidModel.progress] floatValue]*0.01;
        
        //progressTagLabel
        cell.progressTagLabel.text = [NSString stringWithFormat:@"%@",bidModel.progress];
        
        [cell.actionButton setTitle:bidModel.type forState:0];
        if ([bidModel.type isEqualToString:@"售罄"]) {
        [cell.actionButton setBackgroundColor:kGrayColor];
        cell.actionButton.userInteractionEnabled = NO;
        }else{
            [cell.actionButton setBackgroundColor:kPurpleColor];
            cell.actionButton.userInteractionEnabled = YES;

            ZXWeakSelf;
            [cell.actionButton addAction:^(UIButton *btn) {

            [weakself requestDataOfCommitWithModel:bidModel];
        }];
        }
        
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 160;
    }
    
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        if (self.adsArray.count > 0) {
            UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 160)];
            
            [headerView addSubview:self.mainScrollView];
            [headerView addSubview:self.pageControl];
            
            [self.mainScrollView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:headerView];
            [self.mainScrollView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:headerView];
            [self.mainScrollView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:headerView];
            [self.mainScrollView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:headerView];
            
            for (int i = 0; i < self.adsArray.count; i++) {
                //创建UIImageView
                UIButton *imageButton = [[UIButton alloc] init];
                imageButton.frame = CGRectMake(kScreenWidth * i, 0, kScreenWidth, 160);
                ImageModel *imgModel = self.adsArray[i];
                [imageButton sd_setImageWithURL:[NSURL URLWithString:imgModel.img] forState:0];
                [self.mainScrollView addSubview:imageButton];
                ZXWeakSelf;
                [imageButton addAction:^(UIButton *btn) {
                    NewsProViewController *newsProVC = [[NewsProViewController alloc] init];
                    newsProVC.titleString = imgModel.title;
                    newsProVC.newsString = imgModel.url;
                    newsProVC.hidesBottomBarWhenPushed = YES;
                    [weakself.navigationController pushViewController:newsProVC animated:YES];
                }];
                
                [self.pageControl autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:headerView withOffset:-kSmallSpace];
                [self.pageControl autoAlignAxisToSuperviewAxis:ALAxisVertical];
                
            }
            
            return headerView;
        }else{
            return nil;
        }
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section > 0) {
        return 10;
    }
    return 0.1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MainBidModel *mainBidModel = self.bidDataArray[indexPath.section-1];
    
    InvestDetailsViewController *investDetailVC = [[InvestDetailsViewController alloc] init];
    investDetailVC.hidesBottomBarWhenPushed = YES;
    investDetailVC.borrowID = mainBidModel.ID;
    investDetailVC.borrowType = mainBidModel.type_name;
    investDetailVC.type = mainBidModel.type;
    [self.navigationController pushViewController:investDetailVC animated:YES];
}

#pragma mark - scrollView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.pageControl.currentPage = scrollView.contentOffset.x/kScreenWidth;
}

#pragma mark - request data
/*
 //request ads
 -(void)requestAds
 {
 if ([self isConnectionAvailable]) {
 AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
 manager.requestSerializer = [AFHTTPRequestSerializer serializer];
 manager.responseSerializer = [AFHTTPResponseSerializer serializer];
 
 NSString *receivableUrl = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFads];
 
 [manager GET:receivableUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
 
 NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
 
 NSArray *array = [dict allValues];
 NSArray *arrayKey = [dict allKeys];
 
 [DataBase saveDataWithArray:array identifier:@"scroll"];
 
 [self.adsArray addObjectsFromArray:array];
 [self.adsUrlArray addObjectsFromArray:arrayKey];
 
 //设置轮播图
 [self setUpCyclePlayPictures];
 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
 NSLog(@"%@",error);
 }];
 }else{
 NSArray *array = [DataBase cachesDataWithIdentifier:@"scroll"];        [self.adsArray addObjectsFromArray:array];
 //设置轮播图
 [self setUpCyclePlayPictures];
 }
 }
 */

//标数据
-(void)requestDataOfMainBid
{
    NSString *mainBidString = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFmainBid];
    
    ZXWeakSelf;
    [self requestDataGetWithUrlString:mainBidString paramter:nil SucceccBlock:^(id responseObject){
        [weakself.bidDataArray removeAllObjects];
        
        MainBidResponse *mainBidResponse = [MainBidResponse objectWithKeyValues:responseObject];
        
        for (ImageModel *imgModel in mainBidResponse.link) {
            [weakself.adsArray addObject:imgModel];
        }
        
        for (MainBidModel *mainBidModel in mainBidResponse.lists) {
            [weakself.bidDataArray addObject:mainBidModel];
        }
        
        [weakself.mainTableView reloadData];
    } andFailedBlock:^{
        
    }];
}
//确认投资或预约
-(void)requestDataOfCommitWithModel:(MainBidModel *)bidModel
{
    NSString *investCommitString = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFinvestCommit];
    NSDictionary *params = @{@"token" : TOKEN?TOKEN:@"",
                             @"id"    : bidModel.ID};
    
    ZXWeakSelf;
    [self requestDataGetWithUrlString:investCommitString paramter:params SucceccBlock:^(id responseObject){
        
        BaseModel *baseModel = [BaseModel objectWithKeyValues:responseObject];
        if (!baseModel.status || [baseModel.status integerValue] == 1) {
            if ([bidModel.type isEqualToString:@"预约"]) {
                InvestDetailCommitOrderModel *commitOrderModel = [InvestDetailCommitOrderModel objectWithKeyValues:responseObject];
                OrderViewController *orderVC = [[OrderViewController alloc] init];
                orderVC.borrowID = bidModel.ID;
                orderVC.orderModel = commitOrderModel;
                orderVC.borrowType = bidModel.borrow_type;
                orderVC.hidesBottomBarWhenPushed = YES;
                [weakself.navigationController pushViewController:orderVC animated:YES];
            }else if ([bidModel.type isEqualToString:@"投资"]){
                InvestDetailCommitModel *commitInvestModel = [InvestDetailCommitModel objectWithKeyValues:responseObject];
                InvestViewController *investVC = [[InvestViewController alloc] init];
                investVC.borrowID = bidModel.ID;
                investVC.investModel = commitInvestModel;
                investVC.borrowType = bidModel.borrow_type;
                investVC.hidesBottomBarWhenPushed = YES;
                [weakself.navigationController pushViewController:investVC animated:YES];
            }
        }else{
            [weakself showHint:@"请先登录"];
            LoginViewController *loginVC = [[LoginViewController alloc] init];
            loginVC.hidesBottomBarWhenPushed = YES;
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
            [weakself presentViewController:nav animated:YES completion:nil];
        }
        
    } andFailedBlock:^{
        
    }];
}

//-(UIView *)keyView
//{
//    if (!_keyView) {
//        _keyView = [UIView newAutoLayoutView];
//        _keyView.backgroundColor = [UIColor colorWithRed:0.0000 green:0.0000 blue:0.0000 alpha:0.6];
//        
//        UIButton *innerButton = [UIButton newAutoLayoutView];
//        [innerButton setImage:[UIImage imageNamed:@"inner.jpg"] forState:0];
//        [_keyView addSubview:innerButton];
//        innerButton.userInteractionEnabled = NO;
//        
//        JKCountDownButton *cancelButton = [JKCountDownButton newAutoLayoutView];
////        [cancelButton setImage:[UIImage imageNamed:@"cha"] forState:0];
//        [_keyView addSubview:cancelButton];
//        [cancelButton setTitle:@"5点击跳过" forState:0];
//        [cancelButton setTitleColor:kWhiteColor forState:0];
//        cancelButton.titleLabel.font = font14;
//        
//        [innerButton autoPinEdgeToSuperviewEdge:ALEdgeLeft];
//        [innerButton autoPinEdgeToSuperviewEdge:ALEdgeRight];
//        [innerButton autoPinEdgeToSuperviewEdge:ALEdgeTop];
//        [innerButton autoPinEdgeToSuperviewEdge:ALEdgeBottom];
//        
//        [cancelButton autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:innerButton withOffset:20];
//        [cancelButton autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:innerButton withOffset:-kSmallPadding];
//        
//        //    ZXWeakSelf;
//        //    [innerButton addAction:^(UIButton *btn) {
//        //        ExhibiteViewController *exhibiteVC= [[ExhibiteViewController alloc] init];
//        //        exhibiteVC.hidesBottomBarWhenPushed = YES;
//        //        [weakself.navigationController pushViewController:exhibiteVC animated:YES];
//        //        [keyView removeFromSuperview];
//        //    }];
//        
//        ZXWeakSelf;
//        [cancelButton addAction:^(UIButton *btn) {
//            [weakself.keyView removeFromSuperview];
//        }];
//        
//        [cancelButton startWithSecond:5];
//        [cancelButton didChange:^NSString *(JKCountDownButton *countDownButton, int second) {
//            NSString *title = [NSString stringWithFormat:@"%d点击跳过",second];
//            return title;
//        }];
//        [cancelButton didFinished:^NSString *(JKCountDownButton *countDownButton, int second) {
//            [weakself.keyView removeFromSuperview];
//            return nil;
//        }];
//        
//    }
//    return _keyView;
//}


//- (void)exhibiteBigImage
//{
//    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
//    [keyWindow addSubview:self.keyView];
//    
//    [self.keyView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
//}

#pragma mark - chechNewApp
-(void)chechNewApp
{
    //最新版本(仅在中国区的要添加/cn)
    NSString *urlStr = [NSString stringWithFormat:@"http://itunes.apple.com/cn/lookup?id=%@",AppleID];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *appInfoDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:nil];
    NSArray *resultArr = appInfoDic[@"results"];
    if (![resultArr count]) {
        return ;
    }
    
    NSDictionary *infoDic1 = resultArr[0];
    //需要version,trackViewUrl,trackName
    NSString *latestVersion = infoDic1[@"version"];
    NSString *trackName = infoDic1[@"trackName"];
    
    //当前版本
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDic objectForKey:@"CFBundleVersion"];//Bundle version
    
    
    NSArray *latestArray = [latestVersion componentsSeparatedByString:@"."];
    NSArray *currentArray = [currentVersion componentsSeparatedByString:@"."];
    
    NSString *cV1 = currentArray[0];
    NSString *lV1 = latestArray[0];
    
    if ([cV1 integerValue] == [lV1 integerValue]) {
        NSString *cV2 = currentArray[1];
        NSString *lV2 = latestArray[1];
        if ([cV2 integerValue] == [lV2 integerValue]) {
            
            NSString *cV3 = currentArray[2];
            NSString *lV3 = latestArray[2];
            
            if ([cV3 integerValue] < [lV3 integerValue]) {
                [self showAlertOfNewVersionWithTrackName:trackName andLatestVersion:latestVersion andTrackViewUrl:infoDic[@"trackViewUrl"]];
            }
        }else if ([cV2 integerValue] < [lV2 integerValue]){
            [self showAlertOfNewVersionWithTrackName:trackName andLatestVersion:latestVersion andTrackViewUrl:infoDic[@"trackViewUrl"]];
        }
    }else if([cV1 integerValue] < [lV1 integerValue]){
        [self showAlertOfNewVersionWithTrackName:trackName andLatestVersion:latestVersion andTrackViewUrl:infoDic[@"trackViewUrl"]];
    }
    
}

- (void)showAlertOfNewVersionWithTrackName:(NSString *)trackName andLatestVersion:(NSString *)latestVersion andTrackViewUrl:(NSString *)trackViewUrl
{
    NSString *titleStr = [NSString stringWithFormat:@"检查更新:%@",trackName];
    NSString *messageStr = [NSString stringWithFormat:@"发现新版本(%@),是否升级?",latestVersion];
    
    UIAlertController *alertcontrolle = [UIAlertController alertControllerWithTitle:titleStr message:messageStr preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *act0 = [UIAlertAction actionWithTitle:@"取消" style:0 handler:nil];
    UIAlertAction *act1 = [UIAlertAction actionWithTitle:@"确定" style:0 handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:trackViewUrl]];
    }];
    
    [alertcontrolle addAction:act0];
    [alertcontrolle addAction:act1];
    
    [self presentViewController:alertcontrolle animated:YES completion:nil];
}

#pragma mark - network
//判断网络状态
-(BOOL) isConnectionAvailable
{
    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = NO;
            //NSLog(@"notReachable");
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            //NSLog(@"WIFI");
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            //NSLog(@"3G");
            break;
    }
    if (!isExistenceNetwork) {
//        [self showNetHUD];
        return NO;
    }
    return isExistenceNetwork;
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
