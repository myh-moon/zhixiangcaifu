//
//  FundRecordViewController.m
//  zichanbao
//
//  Created by zhixiang on 15/10/14.
//  Copyright (c) 2015年 zhixiang. All rights reserved.
//

#import "FundRecordViewController.h"
#import "FundCell.h"  //自定义单元格
#import "FundModel.h"

#import "NSDate+FormatterTime.h"

@interface FundRecordViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,assign) BOOL didSetupConstraints;
@property (nonatomic,strong) UITableView *fundTableView;

//json
@property (nonatomic,strong) NSMutableDictionary *listDic;
@property (nonatomic,strong) NSMutableArray *listKeyArray;
@property (nonatomic,strong) NSMutableArray *listValueArray;

@end

@implementation FundRecordViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"资金记录";
    self.navigationItem.leftBarButtonItem = self.leftItem;
    
    [self.view addSubview:self.fundTableView];
    [self.view addSubview:self.remindButton];
    [self.remindButton setTitle:@"亲，您目前尚没有资金记录哦！" forState:0];
    [self.remindButton setHidden:YES];
    
    [self.view setNeedsUpdateConstraints];
    
    [self requestDataOfFundRecordWithPage:@"1"];
}

- (void)updateViewConstraints
{
    if (!self.didSetupConstraints) {
        
        [self.fundTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
        
        [self.remindButton autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [self.remindButton autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        self.didSetupConstraints = YES;
    }
    [super updateViewConstraints];
}

#pragma mark - init tableView
-(UITableView *)fundTableView
{
    if (!_fundTableView) {
        _fundTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-48) style:UITableViewStyleGrouped];
        _fundTableView.dataSource = self;
        _fundTableView.delegate = self;
        _fundTableView.showsVerticalScrollIndicator = NO;
        [_fundTableView addFooterWithTarget:self action:@selector(fundFooterRefresh)];
    }
    return _fundTableView;
}

#pragma mark - init array and dic
-(NSMutableDictionary *)listDic
{
    if (!_listDic) {
        _listDic = [NSMutableDictionary dictionary];
    }
    return _listDic;
}
-(NSMutableArray *)listKeyArray
{
    if (!_listKeyArray) {
        _listKeyArray = [NSMutableArray array];
    }
    return _listKeyArray;
}

-(NSMutableArray *)listValueArray
{
    if (!_listValueArray) {
        _listValueArray = [NSMutableArray array];
    }
    return _listValueArray;
}

#pragma mark - tableView delegate and dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.listDic[self.listKeyArray[section]] count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.listKeyArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 30.f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    
    UILabel *dateLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 30)];
    [headerView1 addSubview:dateLabel1];
    dateLabel1.text = self.listKeyArray[section];
    dateLabel1.textColor = [UIColor grayColor];
    dateLabel1.font = font14;
    
    UILabel *dateLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-110, 0, 100, 30)];
    [headerView1 addSubview:dateLabel2];
    dateLabel2.textColor = [UIColor grayColor];
    dateLabel2.text= @"金额（元）";
    dateLabel2.textAlignment = NSTextAlignmentRight;
    dateLabel2.font = font14;
    
    return headerView1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FundCell *cell = [FundCell cellWithTableView:tableView];
    
    NSString *sectionStr = self.listKeyArray[indexPath.section];
    
    NSDictionary *model = [self getModelOfRowWithSection:sectionStr row:indexPath.row];
    
    cell.textLabel.text = model[@"type"];
    
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    
    cell.detailTextLabel.text = model[@"info"];
   
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];

    //金额
    cell.moneyLabel.text = model[@"affect_money"];
    
    //时间
    cell.timeLabel.text = [NSDate getMDhmFormatterTime:model[@"add_time"]];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - request fund data
-(void)requestDataOfFundRecordWithPage:(NSString *)page
{
    NSString *fundString = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFfundRecord];
    
    NSDictionary *params = @{
                             @"token" : TOKEN,
                             @"p" : page
                             };
    
    ZXWeakSelf;
    [self requestDataGetWithUrlString:fundString paramter:params SucceccBlock:^(id responseObject){
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSArray *a1 = weakself.listDic.allKeys;
        NSArray *a2 = [dic[@"list"] allKeys];
        
        BOOL sa = false;
        for (int k=0; k<a2.count; k++) {
            sa = [a1 containsObject:a2[k]];
        }
        
        if (sa) {//包含，则将model添加进数组,section不变
            
            NSArray *aaa = dic[@"list"][a2[a2.count-1]];
            
            NSMutableArray *bbb = [[NSMutableArray alloc] initWithArray:weakself.listDic[a1[a1.count-1]]];
            
            for (int p=0; p<aaa.count; p++) {
                
                [bbb addObject:aaa[p]];
            }
            
            self.listDic[a1[0]] = bbb;
            
        }else{//不包含，则添加key，row不变
            
            int max = (int)[dic[@"list"] count] - 1;
            
            for (int i = max ; i >= 0; i--) {
                
                [weakself.listKeyArray addObject:a2[i]];
            }
            
            [weakself.listDic addEntriesFromDictionary:dic[@"list"]];
        }
        
        if (a2.count <= 0) {
            fundPage--;
        }
        
        //数据为空的提示信息
        if (weakself.listDic.allKeys.count <= 0) {
            [weakself.remindButton setHidden:NO];
        }else{
            [weakself.remindButton setHidden:YES];
        }
        
        [weakself.fundTableView reloadData];
        
    } andFailedBlock:^{
        
    }];
}

int fundPage = 1;
-(void)fundFooterRefresh
{
    fundPage += 1;
    NSString *page = [NSString stringWithFormat:@"%d",fundPage];
    
    [self requestDataOfFundRecordWithPage:page];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.fundTableView footerEndRefreshing];
    });
}

//获取每行的model
-(NSDictionary *)getModelOfRowWithSection:(NSString *)sectionText row:(NSInteger)row
{
    NSDictionary *model = self.listDic[sectionText][row];
    
    return model;
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
