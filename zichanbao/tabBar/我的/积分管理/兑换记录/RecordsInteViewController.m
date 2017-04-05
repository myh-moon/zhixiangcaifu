//
//  RecordsInteViewController.m
//  zichanbao
//
//  Created by zhixiang on 15/11/2.
//  Copyright (c) 2015年 zhixiang. All rights reserved.
//

#import "RecordsInteViewController.h"
#import "RecordsInteDetailViewController.h"  //详情

#import "InteRecordCell.h"
#import "NSDate+FormatterTime.h"

#import "IntegrationList.h"
#import "IntegrationModel.h"

#import "UIImageView+WebCache.h"

@interface RecordsInteViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,assign) BOOL didSetupConstarints;
@property (nonatomic,strong) UITableView *recordInteTableView;


@property (nonatomic,strong) NSMutableArray *recordListArray;
@property (nonatomic,strong) NSMutableSet *recordSet;

@end

@implementation RecordsInteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"兑换记录";
    self.navigationItem.leftBarButtonItem = self.leftItem;
    
    [self.view addSubview:self.recordInteTableView];
    [self.view addSubview:self.remindButton];
    [self.remindButton setImage:[UIImage imageNamed:@"zanwuduihuan"] forState:0];
    [self.remindButton setHidden:YES];
    
    [self.view setNeedsUpdateConstraints];
    
    [self requestDataOfRecordsWithPage:@"0"];
}

- (void)updateViewConstraints
{
    if (!self.didSetupConstarints) {
        
        [self.recordInteTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
        
        [self.remindButton autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [self.remindButton autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        self.didSetupConstarints = YES;
    }
    [super updateViewConstraints];
}

#pragma mark - init recordInteTableView
-(UITableView *)recordInteTableView
{
    if (!_recordInteTableView) {
        _recordInteTableView = [UITableView newAutoLayoutView];
        _recordInteTableView.dataSource = self;
        _recordInteTableView.delegate = self;
        _recordInteTableView.tableFooterView = [[UIView alloc] init];
        _recordInteTableView.showsVerticalScrollIndicator = NO;
//        [_recordInteTableView addFooterWithTarget:self action:@selector(recordFooterRefresh)];
        _recordInteTableView.backgroundColor = kBackgroundColor;
    }
    return _recordInteTableView;
}

#pragma mark - init array and dictionary
-(NSMutableArray *)recordListArray
{
    if (!_recordListArray) {
        _recordListArray = [NSMutableArray array];
    }
    return _recordListArray;
}

-(NSMutableSet *)recordSet
{
    if (_recordSet) {
        _recordSet = [NSMutableSet set];
    }
    return _recordSet;
}

#pragma mark - detailsInteTableView delegate and dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.recordListArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"records";
    InteRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[InteRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = kBackgroundColor;
    cell.separatorInset = UIEdgeInsetsMake(0, kScreenWidth, 0, 0);
    cell.recordLabel.numberOfLines = 0;
    
    IntegrationModel *integrationModel = self.recordListArray[indexPath.row];
    
    [cell.recordImageView sd_setImageWithURL:[NSURL URLWithString:integrationModel.simg] placeholderImage:nil];

    NSString *name1 = [NSString stringWithFormat:@"%@\n",integrationModel.sname];
    NSString *inte1 = [NSString stringWithFormat:@"扣除%@积分",integrationModel.score];
    NSString *inte2 = [NSString stringWithFormat:@"＋%@元\n",integrationModel.money];
    NSString *price1 = [NSDate getYMDhmsFormatterTime:integrationModel.time];
    
    NSString *contentString = [NSString stringWithFormat:@"%@%@%@%@",name1,inte1,inte2,price1];
    NSMutableAttributedString *attributeContent = [[NSMutableAttributedString alloc] initWithString:contentString];
    [attributeContent addAttributes:@{NSFontAttributeName:font14,NSForegroundColorAttributeName:[UIColor blackColor]} range:NSMakeRange(0, name1.length)];
    [attributeContent addAttributes:@{NSFontAttributeName:font16,NSForegroundColorAttributeName:[UIColor redColor]} range:NSMakeRange(name1.length, inte1.length)];
    [attributeContent addAttributes:@{NSFontAttributeName:font16,NSForegroundColorAttributeName:[UIColor redColor]} range:NSMakeRange(name1.length+inte1.length, inte2.length)];
    [attributeContent addAttributes:@{NSFontAttributeName:font12,NSForegroundColorAttributeName:[UIColor lightGrayColor]} range:NSMakeRange(name1.length+inte1.length+inte2.length, price1.length)];
    NSMutableParagraphStyle *styler = [[NSMutableParagraphStyle alloc] init];
    styler.lineSpacing = 12;
    [attributeContent addAttribute:NSParagraphStyleAttributeName value:styler range:NSMakeRange(0, contentString.length)];
    
    [cell.recordLabel setAttributedText:attributeContent];
    
//    IntegrationModel *inteRecordModel = self.recordListArray[indexPath.row];
//    cell.bigLabel.text = inteRecordModel.score;
//    cell.smallLabel.text = [NSDate getYMDhmFormatterTime:inteRecordModel.atime];
//    cell.endLabel.text = inteRecordModel.umoney;
    
    cell.recordButton.userInteractionEnabled = NO;
    [cell.recordButton setTitle:@" 查看详情 " forState:0];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    IntegrationModel *integrationModel = self.recordListArray[indexPath.row];
    
    RecordsInteDetailViewController *recordsInteDetailVC = [[RecordsInteDetailViewController alloc] init];
    recordsInteDetailVC.recordID = integrationModel.ID;
    [self.navigationController pushViewController:recordsInteDetailVC animated:YES];
}

#pragma mark - request data
-(void)requestDataOfRecordsWithPage:(NSString *)page
{
    NSString *recordString = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFscoresRecods];
    NSDictionary *params = @{@"token" : TOKEN};
    
    ZXWeakSelf;
    [self requestDataGetWithUrlString:recordString paramter:params SucceccBlock:^(id responseObject){
                
        IntegrationList *list = [IntegrationList objectWithKeyValues:responseObject];
        
        for (IntegrationModel *recordModel in list.list) {
            [weakself.recordListArray addObject:recordModel];
        }
        
//        if (list.list.count <= 0) {
//            recordPage--;
//        }
        
        if (weakself.recordListArray.count <= 0) {
            [weakself.remindButton setHidden:NO];
        }else{
            [weakself.remindButton setHidden:YES];
        }
        
        [weakself.recordInteTableView reloadData];
        
    } andFailedBlock:^{
        
    }];
}
////底部刷新
//int recordPage = 1;
//-(void)recordFooterRefresh
//{
//    recordPage += 1;
//    NSString *page = [NSString stringWithFormat:@"%d",recordPage];
//    
//    [self requestDataOfRecordsWithPage:page];
//    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.recordInteTableView footerEndRefreshing];
//    });
//}


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
