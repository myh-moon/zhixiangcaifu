//
//  MyFinancialView.m
//  zichanbao
//
//  Created by zhixiang on 15/11/14.
//  Copyright © 2015年 zhixiang. All rights reserved.
//

#import "MyFinancialView.h"
#import "MineMoneyView.h"
@interface MyFinancialView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,copy) NSArray *dataList2;
@property (nonatomic,strong) NSArray *imageList;
@end
@implementation MyFinancialView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.tableView];
    }
    return self;
}
#pragma mark - getter
- (NSArray *)dataList2
{
    if (!_dataList2) {
        _dataList2 = [NSArray arrayWithObjects:@"我的投资",@"我的预约",@"资金记录",@"渠道中介",@"征信查询",@"回款计划",@"积分商城",@"认证管理",@"我的分享码",@"客服电话",@"退出登录", nil];
    }
    return _dataList2;
}
- (NSArray *)imageList
{
    if (!_imageList) {
        _imageList = [NSArray arrayWithObjects:@"namea",@"yuyue",@"namepricetagsa",@"qudaozhongjie",@"qudaozhongjie",@"namerefresh",@"jifenduihuan",@"namecard",@"nameshare",@"namephone",@"namehelp",@"bended-arrow-right", nil];
    }
    return _imageList;
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.fMoneyView;
        _tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}
-(MineMoneyView *)fMoneyView
{
    if (!_fMoneyView) {
        _fMoneyView = [[MineMoneyView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 360) andStyle:@1];
        
        //显示信息
        [_fMoneyView.userButton1 setTitle:@"理财账户" forState:0];
        [_fMoneyView.userButton2 setTitle:@"借款账户" forState:0];
        
        ZXWeakSelf;
        [_fMoneyView.userButton2 addAction:^(UIButton *btn) {
            if (weakself.btnClickAction) {
                weakself.btnClickAction(@3);
            }
        }];
        
        [_fMoneyView.retainBtn addAction:^(UIButton *btn) {
            if (weakself.btnClickAction) {
                weakself.btnClickAction(@2);
            }
        }];
        
        [_fMoneyView.rechargeBtn setTitle:@"充值" forState:0];
        [_fMoneyView.rechargeBtn setBackgroundColor:[UIColor whiteColor]];
        _fMoneyView.rechargeBtn.layer.borderColor = kNavigationColor.CGColor;
        _fMoneyView.rechargeBtn.layer.borderWidth = 1;
        [_fMoneyView.rechargeBtn addAction:^(UIButton *btn) {
            if (weakself.btnClickAction) {
                weakself.btnClickAction(@0);
            }
        }];
        
        [_fMoneyView.withdraBtn setTitle:@"提现" forState:0];
        [_fMoneyView.withdraBtn setBackgroundColor:kNavigationColor];
        [_fMoneyView.withdraBtn addAction:^(UIButton *btn) {
            if (weakself.btnClickAction) {
                weakself.btnClickAction(@1);
            }
        }];
        
        _fMoneyView.allMoneyLabel.text = @"总资产";
        _fMoneyView.moneyLabel1.text = @"0元";
        _fMoneyView.moneyLabel2.text = @"待收收益\n0元";
        _fMoneyView.moneyLabel3.text = @"累计收益\n0元";
        _fMoneyView.moneyLabel4.text = @"待收本金\n0元";
        _fMoneyView.moneyLabel5.text = @"冻结本金\n0元";
    }
    return _fMoneyView;
}
#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList2.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier1 = @"finance";
    UITableViewCell *fCell = [tableView dequeueReusableCellWithIdentifier:identifier1];
    if (fCell == nil) {
        fCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier1];
    }
    fCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
   
    fCell.textLabel.text = self.dataList2[indexPath.row];
    fCell.imageView.image = [UIImage imageNamed:self.imageList[indexPath.row]];
    fCell.imageView.bounds = CGRectMake(0, 0, 50, 40);
    
    return fCell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.didSelectedRow) {
        self.didSelectedRow(indexPath);
    }
}

@end
