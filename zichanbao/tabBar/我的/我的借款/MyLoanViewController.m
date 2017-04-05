//
//  MyLoanViewController.m
//  zichanbao
//
//  Created by zhixiang on 15/11/12.
//  Copyright © 2015年 zhixiang. All rights reserved.
//

#import "MyLoanViewController.h"
#import "InvestCell.h"  //自定义单元格

#import "MyLoanList.h"
#import "MyLoanModel.h"

@interface MyLoanViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,assign) BOOL didSetupConstraint;
@property (nonatomic,strong) UIView *headerViews;
@property (nonatomic,strong) UITableView *myLoanTableView;
@property (nonatomic,strong) UILabel *orangeLabel;
@property (nonatomic,strong) NSLayoutConstraint *leftOrangeLabelConstraints;

@property (nonatomic,assign) NSInteger tagOpen;  //分类标记

//传参
@property (nonatomic,strong) NSString *statusString;

//json解析
@property (nonatomic,strong) NSMutableArray *allLoanArray;

@end

@implementation MyLoanViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = self.leftItem;
    self.navigationItem.title = @"我的借款";
    self.view.backgroundColor = kBackgroundColor;
    
    _tagOpen = 0;
    self.statusString = @"";
    
    [self.view addSubview:self.headerViews];
    [self.view addSubview:self.orangeLabel];
    [self.view addSubview:self.myLoanTableView];
    [self.view addSubview:self.remindButton];
    [self.remindButton.noTextButton setTitle:@"亲，暂时没有！" forState:0];
    [self.remindButton setHidden:YES];
    
    self.leftOrangeLabelConstraints = [self.orangeLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    
    [self.view setNeedsUpdateConstraints];
    
    [self requestDataOfAllLoanWithPage:@"1"];
}

- (void)updateViewConstraints
{
    if (!self.didSetupConstraint) {
        [self.headerViews autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
        [self.headerViews autoSetDimension:ALDimensionHeight toSize:30];
        
        [self.orangeLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.headerViews];
        [self.orangeLabel autoSetDimension:ALDimensionHeight toSize:2];
        [self.orangeLabel autoSetDimension:ALDimensionWidth toSize:kScreenWidth/4];
        
        [self.myLoanTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
        [self.myLoanTableView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.headerViews];
        
        [self.remindButton autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [self.remindButton autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        self.didSetupConstraint = YES;
    }
    [super updateViewConstraints];
}

#pragma mark - init view
- (UIView *)headerViews
{
    if (!_headerViews) {
        _headerViews = [UIView newAutoLayoutView];
        NSArray*nameArray=@[@"全部",@"募集中",@"还款中",@"已结清"];
        for (int i=0; i<nameArray.count; i++) {
            UIButton*btn=[UIButton buttonWithType:0];
            btn.tag=i;
            btn.frame=CGRectMake((kScreenWidth/4)*i,0,kScreenWidth/4,30);
            btn.backgroundColor = [UIColor whiteColor];
            btn.titleLabel.font=[UIFont systemFontOfSize:14];
            [btn setTitle:nameArray[i] forState:0];
            [btn setTitleColor:[UIColor blackColor] forState:0];
            ZXWeakSelf;
            [btn addAction:^(UIButton *btn) {
                [weakself btnClick2324:btn];
            }];
            [_headerViews addSubview:btn];
        }
    }
    return _headerViews;
}

- (UILabel *)orangeLabel
{
    if (!_orangeLabel) {
        _orangeLabel = [UILabel newAutoLayoutView];
        _orangeLabel.backgroundColor = [UIColor orangeColor];
    }
    return _orangeLabel;
}

-(UITableView *)myLoanTableView
{
    if (!_myLoanTableView) {
        _myLoanTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, kScreenWidth, kScreenHeight-20-Navigationheight-30) style:UITableViewStylePlain];
        _myLoanTableView.dataSource = self;
        _myLoanTableView.delegate = self;
        _myLoanTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        [_myLoanTableView addFooterWithTarget:self action:@selector(footerOfAllLoanRefresh)];
    }
    return _myLoanTableView;
}

#pragma mark - init array
-(NSMutableArray *)allLoanArray
{
    if (!_allLoanArray) {
        _allLoanArray = [NSMutableArray array];
    }
    return _allLoanArray;
}

#pragma mark - tableView delegate and dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.allLoanArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, 10)];
    footerLabel.backgroundColor = kBackgroundColor;
    return footerLabel;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"loan";
    InvestCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[InvestCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    MyLoanModel *model = self.allLoanArray[indexPath.row];
    
    NSString *str = model.borrow_type;
    NSDictionary *attribute = @{NSFontAttributeName:font14};
    CGFloat length = [str boundingRectWithSize:CGSizeMake(kScreenWidth, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size.width;
    cell.typeBtn1.frame = CGRectMake(20, 15,20+length, 20);
    [cell.typeBtn1 setTitle:str forState:0];
    
    cell.nameLabel.frame = CGRectMake(cell.typeBtn1.right+5, cell.typeBtn1.top, 200, 20);
    cell.nameLabel.text = model.borrow_name;
    [cell.typeBtn2 setTitle:model.status forState:0];
    cell.moneyLabel.text = [NSString stringWithFormat:@"借款金额：%@元",model.borrow_money];
    cell.dateLabel.text = [NSString stringWithFormat:@"借款期限：%@",model.borrow_duration];
    cell.ProfitLabel.text = [NSString stringWithFormat:@"借款利率：%@",model.borrow_interest_rate];
    cell.wayLabel.text = model.repayment_type;
    [cell.rateLabel1 setHidden:YES];
    [cell.rateLabel2 setHidden:YES];
    
    return cell;
}

#pragma mark - target 全部，募集中中，还款中，已结清
#pragma mark - request data
-(void)requestDataOfAllLoanWithPage:(NSString *)page
{
    NSString *allLoanString = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFmyBorrow];
    NSDictionary *params = @{
                             @"token" :TOKEN,
                             @"p"     :page,
                             @"status" : self.statusString
                             };
    
    ZXWeakSelf;
    [self requestDataGetWithUrlString:allLoanString paramter:params SucceccBlock:^(id responseObject){
        
        if ([page integerValue] == 1) {
            [weakself.allLoanArray removeAllObjects];
        }
        
        MyLoanList *loanList = [MyLoanList objectWithKeyValues:responseObject];
        
        for (MyLoanModel *loanModel in loanList.list) {
            [weakself.allLoanArray addObject:loanModel];
        }
        
        if (loanList.list.count <= 0) {
            allPage--;
            [weakself showHint:@"没有更多了！"];
        }
        
        if (weakself.allLoanArray.count <= 0) {
            [weakself.remindButton setHidden:NO];
        }else{
            [weakself.remindButton setHidden:YES];
        }
        
        [weakself.myLoanTableView reloadData];
    } andFailedBlock:^{
        
    }];
}

#pragma mark - refresh
//-(void)headerOfAllLoanRefresh
//{
//    [self requestDataOfAllLoanWithPage:@"1"];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.myLoanTableView headerEndRefreshing];
//    });
//}
int allPage = 1;
-(void)footerOfAllLoanRefresh
{
    allPage += 1;
    NSString *aPage = [NSString stringWithFormat:@"%d",allPage];
    [self requestDataOfAllLoanWithPage:aPage];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.myLoanTableView footerEndRefreshing];
    });
}
-(void)btnClick2324:(UIButton *)button
{
    _tagOpen = button.tag;
    
    
    if (_tagOpen == 0) {//全部
        self.statusString = @"";
    }else if (_tagOpen == 1){//募集中
        self.statusString = @"1";
    }else if (_tagOpen == 2){//还款中
        self.statusString = @"2";
    }else if (_tagOpen == 3){//已结清
        self.statusString = @"3";
    }
    allPage = 1;
    [self requestDataOfAllLoanWithPage:@"1"];
    
    ZXWeakSelf;
    [UIView animateWithDuration:0.3 animations:^{
        weakself.leftOrangeLabelConstraints.constant = kScreenWidth/4*_tagOpen;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
