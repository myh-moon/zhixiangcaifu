//
//  DetailsInteViewController.m
//  zichanbao
//
//  Created by zhixiang on 15/11/2.
//  Copyright (c) 2015年 zhixiang. All rights reserved.
//

#import "DetailsInteViewController.h"

#import "NSDate+FormatterTime.h"
#import "BorrowBaseCell.h"

//model
#import "DetailInteList.h"
#import "DetailInteModel.h"

@interface DetailsInteViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,assign) BOOL didSetupConstraints;
@property (nonatomic,strong) UITableView *detailsInteTableView;
@property (nonatomic,strong) NSDictionary *detailsDict;
@property (nonatomic,strong) NSMutableArray *detailsArray;

@end

@implementation DetailsInteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = self.leftItem;
    self.navigationItem.title = @"积分明细";
    
    [self.view addSubview:self.detailsInteTableView];
    [self.view addSubview:self.remindButton];
    [self.remindButton.noImageButton setImage:[UIImage imageNamed:@"zanwujifenmingxi"] forState:0];
    [self.remindButton setHidden:YES];
    
    [self.view setNeedsUpdateConstraints];
    
    [self requestDataOfInteDetailsWithPage:@"1"];
}

- (void)updateViewConstraints
{
    if (!self.didSetupConstraints) {
        
        [self.detailsInteTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
        
        [self.remindButton autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [self.remindButton autoAlignAxisToSuperviewAxis:ALAxisHorizontal];

        self.didSetupConstraints = YES;
    }
    [super updateViewConstraints];
}

#pragma mark - request data
-(void)requestDataOfInteDetailsWithPage:(NSString *)page
{
    NSString *inteDetailString = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFscoreDetails];
    NSDictionary *param = @{@"token" : TOKEN};
    
    ZXWeakSelf;
    [self requestDataGetWithUrlString:inteDetailString paramter:param SucceccBlock:^(id responseObject){
        
        DetailInteList *list = [DetailInteList objectWithKeyValues:responseObject];
        
        for (DetailInteModel *detailInteModel in list.list) {
            [weakself.detailsArray addObject:detailInteModel];
        }
        
//        if (list.list.count <= 0) {
//            dPage--;
//        }
        
        if (weakself.detailsArray.count <= 0) {
            [weakself.remindButton setHidden:NO];
        }else{
            [weakself.remindButton setHidden:YES];
        }
        
        [weakself.detailsInteTableView reloadData];
        
    } andFailedBlock:^{
    }];
}
//
//int dPage = 1;
//-(void)footerRefresh
//{
//    dPage += 1;
//    NSString *page = [NSString stringWithFormat:@"%d",dPage];
//    [self requestDataOfInteDetailsWithPage:page];
//    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.detailsInteTableView footerEndRefreshing];
//    });
//}

#pragma mark - init detailsInteTableView
-(UITableView *)detailsInteTableView
{
    if (!_detailsInteTableView) {
        _detailsInteTableView = [UITableView newAutoLayoutView];
        _detailsInteTableView.dataSource = self;
        _detailsInteTableView.delegate = self;
        _detailsInteTableView.tableFooterView = [[UIView alloc] init];
        _detailsInteTableView.showsVerticalScrollIndicator = NO;
//        [_detailsInteTableView addFooterWithTarget:self action:@selector(footerRefresh)];
    }
    return _detailsInteTableView;
}

#pragma mark - init array and dic
-(NSDictionary *)detailsDict
{
    if (!_detailsDict) {
        _detailsDict = [NSDictionary dictionary];
    }
    return _detailsDict;
}

-(NSMutableArray *)detailsArray
{
    if (!_detailsArray) {
        _detailsArray = [NSMutableArray array];
    }
    return _detailsArray;
}


#pragma mark - detailsInteTableView delegate and dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.detailsArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"sss";
    BorrowBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[BorrowBaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = kBackgroundColor;
    cell.leftButton.titleLabel.numberOfLines = 0;
    [cell.rightButton setTitleColor:kYellowColor forState:0];
    
    DetailInteModel *model = self.detailsArray[indexPath.row];
    
    NSString *ww1 = [NSString stringWithFormat:@"%@\n",model.name];
    NSString *ww2 = [NSDate getYMDhmsFormatterTime:model.time];
    NSString *ww = [NSString stringWithFormat:@"%@%@",ww1,ww2];
    NSMutableAttributedString *attributeWW = [[NSMutableAttributedString alloc] initWithString:ww];
    [attributeWW addAttributes:@{NSFontAttributeName:font14,NSForegroundColorAttributeName:[UIColor blackColor]} range:NSMakeRange(0, ww1.length)];
    [attributeWW addAttributes:@{NSFontAttributeName:font12,NSForegroundColorAttributeName:[UIColor lightGrayColor]} range:NSMakeRange(ww1.length, ww2.length)];
    NSMutableParagraphStyle *stylee = [[NSMutableParagraphStyle alloc] init];
    [stylee setLineSpacing:6];
    [attributeWW addAttribute:NSParagraphStyleAttributeName value:stylee range:NSMakeRange(0, ww.length)];
    [cell.leftButton setAttributedTitle:attributeWW forState:0];
    
    NSString *sosos = [NSString stringWithFormat:@"+%@",model.score];
    [cell.rightButton setTitle:sosos forState:0];
    
    return cell;
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
