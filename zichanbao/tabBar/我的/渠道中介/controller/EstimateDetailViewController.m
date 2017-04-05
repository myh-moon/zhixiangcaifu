//
//  EstimateDetailViewController.m
//  zichanbao
//
//  Created by zhixiang on 16/12/27.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import "EstimateDetailViewController.h"

#import "BorrowBaseCell.h"

#import "DetailEstimateResponse.h"
#import "BillModel.h"

@interface EstimateDetailViewController ()<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic,assign) BOOL didSetupConstraints;
@property (nonatomic,strong) UITableView *estimateTableView;

@property (nonatomic,strong) NSMutableArray *detailEstimateArray;


@end

@implementation EstimateDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"房产预估信息查看";
    self.navigationItem.leftBarButtonItem = self.leftItem;
    self.view.backgroundColor = kBackgroundColor;
    
    [self.view addSubview:self.estimateTableView];
    
    [self.view setNeedsUpdateConstraints];
    
    [self getDetailMessageOfEstimate];
}

- (void)updateViewConstraints
{
    if (!self.didSetupConstraints) {
        
        [self.estimateTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
        
        self.didSetupConstraints = YES;
    }
    [super updateViewConstraints];
}

- (UITableView *)estimateTableView
{
    if (!_estimateTableView) {
        _estimateTableView = [UITableView newAutoLayoutView];
        _estimateTableView.backgroundColor = [UIColor whiteColor];
        _estimateTableView.delegate = self;
        _estimateTableView.dataSource = self;
        _estimateTableView.tableFooterView = [[UIView alloc] init];
    }
    return _estimateTableView;
}

- (NSMutableArray *)detailEstimateArray
{
    if (!_detailEstimateArray) {
        _detailEstimateArray = [NSMutableArray array];
    }
    return _detailEstimateArray;
}

#pragma mark - delegate and datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.detailEstimateArray.count > 0) {
        return 14;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCellHeight1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"estimateDetail";
    
    BorrowBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[BorrowBaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.preservesSuperviewLayoutMargins = NO;
    cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
    
    BillModel *detailEstimateModel = self.detailEstimateArray[0];
    
    NSArray *leftArray = @[@"房产地址",@"房产面积",@"房产类型",@"地下面积",@"年租金",@"竣工日期",@"所在楼层／总层",@"分配销售",@"添加时间",@"评估单位",@"评估人",@"房产价格",@"评估时间",@"状态"];
    [cell.leftButton setTitleColor:kNavigationColor forState:0];
    cell.leftButton.titleLabel.font = font14;
    [cell.leftButton setTitle:leftArray[indexPath.row] forState:0];
    
    [cell.rightButton setTitleColor:kGrayColor forState:0];
    cell.rightButton.titleLabel.font = font14;
    
    switch (indexPath.row) {
        case 0:{
            [cell.rightButton setTitle:detailEstimateModel.address forState:0];
        }
            break;
        case 1:{
            NSString *spareStr = [NSString stringWithFormat:@"%@m²",detailEstimateModel.spare];
            [cell.rightButton setTitle:spareStr forState:0];
        }
            break;
        case 2:{
            [cell.rightButton setTitle:detailEstimateModel.type forState:0];
        }
            break;
        case 3:{
            NSString *nareaStr = [NSString stringWithFormat:@"%@m²",detailEstimateModel.narea];
            [cell.rightButton setTitle:nareaStr forState:0];
        }
            break;
        case 4:{
            NSString *rentStr = [NSString stringWithFormat:@"%@万",detailEstimateModel.rent];
            [cell.rightButton setTitle:rentStr forState:0];
        }
            break;
        case 5:{
            [cell.rightButton setTitle:detailEstimateModel.comple_date forState:0];
        }
            break;
        case 6:{
            NSString *layerStr = [NSString stringWithFormat:@"%@层",detailEstimateModel.layer];
            [cell.rightButton setTitle:layerStr forState:0];
        }
            break;
        case 7:{
            [cell.rightButton setTitle:detailEstimateModel.apply_id forState:0];
        }
            break;
        case 8:{
            [cell.rightButton setTitle:detailEstimateModel.add_time forState:0];
        }
            break;
        case 9:{
            [cell.rightButton setTitle:detailEstimateModel.unit forState:0];
        }
            break;
        case 10:{
            [cell.rightButton setTitle:detailEstimateModel.unit_id forState:0];
        }
            break;
        case 11:{
            [cell.rightButton setTitle:detailEstimateModel.price forState:0];
        }
            break;
        case 12:{
            [cell.rightButton setTitle:detailEstimateModel.update_time forState:0];
        }
            break;
        case 13:{
            [cell.rightButton setTitle:detailEstimateModel.status forState:0];
        }
            break;
  
        default:
            break;
    }
    
    return cell;
}

#pragma mark - method
- (void)getDetailMessageOfEstimate
{
    NSString *detailEstimateString = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFChannelOfEstimateDetailsString];
    NSDictionary *params = @{@"token" : TOKEN,
                             @"id" : self.estimateId};
    
    ZXWeakSelf;
    [self requestDataGetWithUrlString:detailEstimateString paramter:params SucceccBlock:^(id responseObject) {
        DetailEstimateResponse *response = [DetailEstimateResponse objectWithKeyValues:responseObject];
        if ([response.status integerValue] == 1) {
            [weakself.detailEstimateArray addObject:response.list];
        }else{
            [weakself showHint:response.info];
        }
        [weakself.estimateTableView reloadData];
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
