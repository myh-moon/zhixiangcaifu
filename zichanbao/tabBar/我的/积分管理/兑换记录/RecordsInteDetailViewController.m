//
//  RecordsInteDetailViewController.m
//  zichanbao
//
//  Created by zhixiang on 16/11/8.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import "RecordsInteDetailViewController.h"
#import "IntermAgreementsViewController.h" //快递信息

#import "BorrowBaseCell.h"

#import "IntegrationDetailModel.h"
#import "IntegrationModel.h"
#import "PayAddressCell.h"

#import "UIButton+WebCache.h"
#import "NSDate+FormatterTime.h"

@interface RecordsInteDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,assign) BOOL didSetupConstraints;
@property (nonatomic,strong) UITableView *recordDetailTableView;

//json
@property (nonatomic,strong) NSMutableArray *recordDetailArray;

@end

@implementation RecordsInteDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"兑换详情";
    self.navigationItem.leftBarButtonItem = self.leftItem;
    
    [self.view addSubview:self.recordDetailTableView];
    
    [self.view setNeedsUpdateConstraints];
    
    [self getDetailsOfRecordsInte];
}

- (void)updateViewConstraints
{
    if (!self.didSetupConstraints) {
        
        [self.recordDetailTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
        
        self.didSetupConstraints = YES;
    }
    [super updateViewConstraints];
}

- (UITableView *)recordDetailTableView
{
    if (!_recordDetailTableView) {
        _recordDetailTableView.translatesAutoresizingMaskIntoConstraints = NO;
        _recordDetailTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _recordDetailTableView.backgroundColor = kBackgroundColor;
        _recordDetailTableView.delegate = self;
        _recordDetailTableView.dataSource = self;
    }
    return _recordDetailTableView;
}

- (NSMutableArray *)recordDetailArray
{
    if (!_recordDetailArray) {
        _recordDetailArray = [NSMutableArray array];
    }
    return _recordDetailArray;
}

#pragma mark -delegate and datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.recordDetailArray.count > 0) {
        return 4;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return 3;
    }else if (section == 2){
        return 3;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        IntegrationDetailModel *response = self.recordDetailArray[0];
        IntegrationModel *integrationModel = response.list;
        UIButton *view1 = [UIButton new];
        [view1 sd_setImageWithURL:[NSURL URLWithString:integrationModel.bimg] forState:0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            view1.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        }];
        
        return view1.height;
        
    }else if (indexPath.section == 3){
        return 80;
    }
    return 35;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier;
    
    IntegrationDetailModel *response = self.recordDetailArray[0];
    IntegrationModel *integrationModel = response.list;
    
    if (indexPath.section == 0) {
        identifier = @"recordDetail0";
        BorrowBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[BorrowBaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.rightButton setHidden:YES];
        [cell.leftButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
        [cell.leftButton autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        
        [cell.leftButton sd_setImageWithURL:[NSURL URLWithString:integrationModel.bimg] forState:0 placeholderImage:nil];
        
        return cell;
        
    }else if (indexPath.section == 1){
        identifier = @"recordDetail1";
        BorrowBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[BorrowBaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        [cell.leftButton setTitleColor:[UIColor darkGrayColor] forState:0];
        cell.leftButton.titleLabel.font = font14;
        [cell.rightButton setTitleColor:[UIColor grayColor] forState:0];
        cell.rightButton.titleLabel.font = font12;
        
        if (indexPath.row == 0) {//商品名称
            [cell.leftButton setTitle:integrationModel.sname forState:0];
            NSString *numbet = [NSString stringWithFormat:@"X %@份",integrationModel.number];
            [cell.rightButton setTitle:numbet forState:0];
        }else if (indexPath.row == 1){//商品描述
            [cell.leftButton setTitle:@"商品描述" forState:0];
            
            NSString *mon1 = integrationModel.score;
            NSString *mon2 = @"积分＋";
            NSString *mon3 = integrationModel.money;
            NSString *mon4 = @"余额";
            NSString *money = [NSString stringWithFormat:@"%@%@%@%@",mon1,mon2,mon3,mon4];
            NSMutableAttributedString *attributeMon = [[NSMutableAttributedString alloc] initWithString:money];
            [attributeMon addAttributes:@{NSFontAttributeName:font12,NSForegroundColorAttributeName:kRedColor} range:NSMakeRange(0, mon1.length)];
            [attributeMon addAttributes:@{NSFontAttributeName:font12,NSForegroundColorAttributeName:kGrayColor} range:NSMakeRange(mon1.length, mon2.length)];
            [attributeMon addAttributes:@{NSFontAttributeName:font12,NSForegroundColorAttributeName:kRedColor} range:NSMakeRange(mon1.length+mon2.length, mon3.length)];
            [attributeMon addAttributes:@{NSFontAttributeName:font12,NSForegroundColorAttributeName:kGrayColor} range:NSMakeRange(mon1.length+mon2.length+mon3.length, mon4.length)];
            [cell.rightButton setAttributedTitle:attributeMon forState:0];
            
        }else{//兑换时间
            [cell.leftButton setTitle:@"兑换时间" forState:0];
            [cell.rightButton setTitle:[NSDate getYMDhmsFormatterTime:integrationModel.time] forState:0];
        }

        return cell;
    }else if (indexPath.section == 2){
        identifier = @"recordDetail2";
        BorrowBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[BorrowBaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        [cell.leftButton setTitleColor:[UIColor darkGrayColor] forState:0];
        cell.leftButton.titleLabel.font = font14;
        cell.rightButton.titleLabel.font = font12;
        
        if (indexPath.row == 0) {
            [cell.leftButton setTitle:@"发货状态" forState:0];
            [cell.rightButton setTitleColor:[UIColor grayColor] forState:0];
            [cell.rightButton setTitle:integrationModel.status forState:0];
        }else if (indexPath.row == 1) {//商品名称
            [cell.leftButton setTitle:@"快递公司" forState:0];
            [cell.rightButton setTitleColor:[UIColor grayColor] forState:0];
            
            if ([integrationModel.status isEqualToString:@"未发货"]) {
                [cell.rightButton setTitle:@"无快递公司" forState:0];
            }else{
                [cell.rightButton setTitle:integrationModel.company forState:0];
            }
            
        }else if (indexPath.row == 2){//商品描述
            [cell.leftButton setTitle:@"快递单号" forState:0];
            if ([integrationModel.status isEqualToString:@"未发货"]) {
                [cell.rightButton setTitleColor:[UIColor grayColor] forState:0];
                [cell.rightButton setTitle:@"无快递单号" forState:0];
            }else{
                [cell.rightButton setTitleColor:[UIColor redColor] forState:0];
                [cell.rightButton setTitle:integrationModel.express forState:0];
            }
        }
        
        return cell;
    }else{
        identifier = @"recordDetail3";
        PayAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[PayAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.nameLabel.text = [NSString stringWithFormat:@"收货人：%@",integrationModel.name];
        cell.phoneLabel.text = integrationModel.tel;
        [cell.addressButton setImage:[UIImage imageNamed:@"querddaddicon"] forState:0];
        cell.addressButton.titleLabel.numberOfLines = 0;
        
        [cell.addressButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        NSString *address = [NSString stringWithFormat:@"收货地址：%@",integrationModel.address];
        [cell.addressButton setTitle:address forState:0];
        
        return cell;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 2 && indexPath.row == 1) {
        IntegrationDetailModel *response = self.recordDetailArray[0];
        IntegrationModel *integrationModel = response.list;
        IntermAgreementsViewController *expressMessageVC = [[IntermAgreementsViewController alloc] init];
        expressMessageVC.urlString = integrationModel.url;
        expressMessageVC.titleStr = @"查询快递信息";
        [self.navigationController pushViewController:expressMessageVC animated:YES];
    }
}

#pragma mark - method
- (void)getDetailsOfRecordsInte
{
    NSString *recordDetailString = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFScoresRecodsOfDetails];
    NSDictionary *params = @{@"token" : TOKEN,
                             @"id" : self.recordID
                             };
    
    ZXWeakSelf;
    [self requestDataGetWithUrlString:recordDetailString paramter:params SucceccBlock:^(id responseObject) {
        
        IntegrationDetailModel *inteDetailModel = [IntegrationDetailModel objectWithKeyValues:responseObject];
        
        [weakself.recordDetailArray addObject:inteDetailModel];
        
        [weakself.recordDetailTableView reloadData];
        
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
