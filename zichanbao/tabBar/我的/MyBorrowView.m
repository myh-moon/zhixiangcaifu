//
//  MyBorrowView.m
//  zichanbao
//
//  Created by zhixiang on 15/11/14.
//  Copyright © 2015年 zhixiang. All rights reserved.
//

#import "MyBorrowView.h"
#import "MineMoneyView.h"
@interface MyBorrowView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *borrowList1;
@property (nonatomic,strong) NSArray *borrowImageList1;
@end
@implementation MyBorrowView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.tableView];
    }
    return self;
}
#pragma mark - getter
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableHeaderView = self.bMoneyView;
    }
    return _tableView;
}
-(MineMoneyView *)bMoneyView
{
    if (!_bMoneyView) {
        _bMoneyView = [[MineMoneyView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 330) andStyle:@2];
        [_bMoneyView.userButton1 setTitle:@"借款账户" forState:0];
        [_bMoneyView.userButton2 setTitle:@"理财账户" forState:0];
        ZXWeakSelf;
        [_bMoneyView.userButton2 addAction:^(UIButton *btn) {
            if (weakself.btnClickAction) {
                weakself.btnClickAction(@3);
            }
        }];
        
//        NSString *s1 = @"0";
//        NSString *s2 = @"0";
//        NSString *s3 = @"0";
//        
//        NSString *string1 = [NSString stringWithFormat:@"当前借款笔数：%@笔",s1];
//        NSString *string2 = [NSString stringWithFormat:@"累计借款笔数：%@笔",s2];
//        NSString *string3 = [NSString stringWithFormat:@"累计利息：%@元",s3];
//        
//        NSString *string = [NSString stringWithFormat:@"%@\n%@\n%@",string1,string2,string3];
//        
//        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:string];
//        [attributeString addAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} range:NSMakeRange(0, 7)];
//        [attributeString addAttributes:@{NSForegroundColorAttributeName:kNavigationColor} range:NSMakeRange(7, s1.length)];
//        [attributeString addAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} range:NSMakeRange(7+s1.length, 2+7)];
//        [attributeString addAttributes:@{NSForegroundColorAttributeName:kNavigationColor} range:NSMakeRange(7+s1.length+2+7, s2.length)];
//        [attributeString addAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} range:NSMakeRange(7+s1.length+2+7+s2.length, 2+5)];
//        [attributeString addAttributes:@{NSForegroundColorAttributeName:kNavigationColor} range:NSMakeRange(7+s1.length+2+7+s2.length+2+5, s3.length)];
//        [attributeString addAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} range:NSMakeRange(string.length-1, 1)];
//        
//        [_bMoneyView.retainBtn setAttributedTitle:attributeString forState:0];
//
//        _bMoneyView.allMoneyLabel.text = @"借款总额";
//        _bMoneyView.moneyLabel1.text = @"0元";
//        _bMoneyView.moneyLabel2.text = @"待还本金\n0元";
//        _bMoneyView.moneyLabel3.text = @"待还利息\n0元";
//        _bMoneyView.moneyLabel4.text = @"已还本金\n0元";
//        _bMoneyView.moneyLabel5.text = @"已还利息\n0元";
    }
    return _bMoneyView;
}

-(NSArray *)borrowList1
{
    if (!_borrowList1) {
//        _borrowList1 = @[@"我的借款",@"资金记录",@"还款计划",@"认证管理",@"客服电话",@"帮助中心",@"退出登录"];
        _borrowList1 = @[@"我的借款",@"资金记录",@"还款计划",@"认证管理",@"客服电话",@"退出登录"];

    }
    return _borrowList1;
}

-(NSArray *)borrowImageList1
{
    if (!_borrowImageList1) {
        _borrowImageList1 = @[@"namea",@"namepricetagsa",@"namerefresh",@"namecard",@"namephone",@"namehelp",@"bended-arrow-right"];
    }
    
    return _borrowImageList1;
}
#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.borrowList1.count;
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
    static NSString *identifier2 = @"borrow";
    UITableViewCell *bCell = [tableView dequeueReusableCellWithIdentifier:identifier2];
    if (bCell == nil) {
        bCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier2];
    }
    bCell.textLabel.text = self.borrowList1[indexPath.row];
    bCell.imageView.image = [UIImage imageNamed:self.borrowImageList1[indexPath.row]];
    return bCell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    return self.bMoneyView;
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.didSelectedRow) {
        self.didSelectedRow(indexPath.row);
    }
}

@end
