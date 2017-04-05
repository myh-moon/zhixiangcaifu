//
//  CreditListViewController.m
//  zichanbao
//
//  Created by zhixiang on 17/2/15.
//  Copyright © 2017年 zhixiang. All rights reserved.
//

#import "CreditListViewController.h"
#import "CreditListView.h"
#import "DetailsCell.h"

#import "UIViewController+BlurView.h"

@interface CreditListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,assign) BOOL didSetupConstraints;
@property (nonatomic,strong) CreditListView *creditChooseView;
@property (nonatomic,strong) UITableView *creditListTableView;

//json
@property (nonatomic,strong)NSMutableArray *creditArray;
//params
@property (nonatomic,strong) NSMutableDictionary *creditListDic;
@end

@implementation CreditListViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;

    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg"]forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"征信报告";
    self.navigationItem.leftBarButtonItem = self.leftItem;
    self.view.backgroundColor = kBackgroundColor;
    
    [self.creditListDic setValue:@"姓名" forKey:@"params"];
    
    [self.view addSubview:self.creditChooseView];
    [self.view addSubview:self.creditListTableView];
    
    [self.view setNeedsUpdateConstraints];
}

- (void)updateViewConstraints
{
    if (!self.didSetupConstraints) {
        
        [self.creditChooseView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
        [self.creditChooseView autoSetDimension:ALDimensionHeight toSize:40];
        
        [self.creditListTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 5, 0, 5) excludingEdge:ALEdgeTop];
        [self.creditListTableView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.creditChooseView withOffset:5];
        
        self.didSetupConstraints = YES;
    }
    [super updateViewConstraints];
}

- (CreditListView *)creditChooseView
{
    if (!_creditChooseView) {
        _creditChooseView = [CreditListView newAutoLayoutView];
        _creditChooseView.backgroundColor = kWhiteColor;
        
        //选择类别
        ZXWeakSelf;
        [_creditChooseView.creditButton addAction:^(UIButton *btn) {
            NSArray *sososo = @[@"姓名",@"身份证",@"手机号"];
            [weakself showBlurInView:weakself.view withArray:sososo withTop:btn.height finishBlock:^(NSString *text, NSInteger row) {
                [btn setTitle:text forState:0];
                [weakself.creditListDic setValue:text forKey:@"params"];
            }];
        }];
        //搜索
        [_creditChooseView.creditSearchButton addAction:^(UIButton *btn) {
            [weakself searchCreditListWithType:weakself.creditListDic[@"params"]];
        }];
        
    }
    return _creditChooseView;
}

- (UITableView *)creditListTableView
{
    if (!_creditListTableView) {
        _creditListTableView = [UITableView newAutoLayoutView];
        _creditListTableView.delegate = self;
        _creditListTableView.dataSource = self;
        _creditListTableView.tableFooterView = [[UIView alloc] init];
    }
    return _creditListTableView;
}

- (NSMutableArray *)creditArray
{
    if (!_creditArray) {
        _creditArray = [NSMutableArray array];
    }
    return _creditArray;
}

- (NSMutableDictionary *)creditListDic
{
    if (!_creditListDic) {
        _creditListDic = [NSMutableDictionary dictionary];
    }
    return _creditListDic;
}

#pragma mark - tableview delegate and datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.creditArray.count + 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier;
    if (indexPath.row == 0) {
        identifier = @"credit0";
        DetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell  =[[DetailsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.lineLable1 setHidden:YES];
        [cell.lineLable2 setHidden:YES];
        cell.topLabel1.textColor = kNavigationColor;
        cell.topLabel2.textColor = kNavigationColor;
        [cell.topButton3 setTitleColor:kNavigationColor forState:0];
        cell.topLabel1.text = @"时间";
        cell.topLabel2.text = self.creditListDic[@"params"];
        [cell.topButton3 setTitle:@"查看／下载" forState:0];
        return cell;
    }
    identifier = @"credit1";
    DetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell  =[[DetailsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.lineLable1 setHidden:YES];
    [cell.lineLable2 setHidden:YES];
    cell.topLabel1.textColor = kDarkGrayColor;
    cell.topLabel2.textColor = kDarkGrayColor;
    cell.topButton3.userInteractionEnabled = NO;
    cell.topLabel1.text = @"2017-09-09";
    cell.topLabel2.text = @"李某某";
    [cell.topButton3 setImage:[UIImage imageNamed:@"pdf"] forState:0];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self showHint:@"查看pdf"];
    //初始化进度条
    MBProgressHUD *HUD = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.tag=1000;
    HUD.mode = MBProgressHUDModeDeterminate;
    HUD.labelText = @"Downloading...";
    HUD.square = YES;
    [HUD show:YES];
    //初始化队列
    NSOperationQueue *queue = [[NSOperationQueue alloc ]init];
    //下载地址
    NSURL *url = [NSURL URLWithString:@"http://help.adobe.com/archive/en/photoshop/cs6/photoshop_reference.pdf"];
    //保存路径
    NSString *rootPath = [self dirDoc];
    NSString *filePath= [rootPath  stringByAppendingPathComponent:@"file.pdf"];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc]initWithRequest:[NSURLRequest requestWithURL:url]];
    op.outputStream = [NSOutputStream outputStreamToFileAtPath:filePath append:NO];
    // 根据下载量设置进度条的百分比
    [op setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        CGFloat precent = (CGFloat)totalBytesRead / totalBytesExpectedToRead;
        HUD.progress = precent;
    }];
    
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"下载成功");
        [HUD removeFromSuperview];
        [self performSegueWithIdentifier:@"showDetail" sender:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"下载失败");
        [HUD removeFromSuperview];
    }];
    //开始下载
    [queue addOperation:op];
}

//获取Documents目录
-(NSString *)dirDoc{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}

#pragma mark - method
- (void)searchCreditListWithType:(NSString *)type
{
    NSString *searchString = [NSString stringWithFormat:@"%@%@",@"",@""];
    NSDictionary *params = @{@"token": TOKEN,
                                           @"params" : type};
    
    ZXWeakSelf;
    [self requestDataGetWithUrlString:searchString paramter:params SucceccBlock:^(id responseObject) {
        [weakself.creditListTableView reloadData];
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
