//
//  BlurTableView.m
//  zichanbao
//
//  Created by zhixiang on 16/12/28.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import "BlurTableView.h"
#import "BorrowBaseCell.h"

@implementation BlurTableView


- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = kBackgroundColor;
        self.tableFooterView = [[UIView alloc] init];
        
//        if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
//            [self setSeparatorInset:UIEdgeInsetsZero];
//        }
//        if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
//            [self setLayoutMargins:UIEdgeInsetsZero];
//        }
    }
    return self;
}

- (NSArray *)blurDataList
{
    if (!_blurDataList) {
        _blurDataList = [NSArray array];
    }
    return _blurDataList;
}

- (NSLayoutConstraint *)heightTableConstraints
{
    if (!_heightTableConstraints) {
        _heightTableConstraints = [self autoSetDimension:ALDimensionHeight toSize:0];
    }
    return _heightTableConstraints;
}

#pragma mark - delegate and datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.tableType isEqualToString:@"有"]) {
        return self.blurDataList.count+1;
    }
    return self.blurDataList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier;
    
    if ([self.tableType isEqualToString:@"有"]) {//有title
        
        identifier = @"upward0";
        BorrowBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[BorrowBaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.row == 0) {
            cell.backgroundColor = kBackgroundColor;
            [cell.leftButton setTitleColor:kBlackColor forState:0];
            [cell.leftButton setTitle:@"取消" forState:0];
            cell.leftButton.userInteractionEnabled = YES;
//            [cell.oneButton setTitleColor:kBlackColor forState:0];
//            [cell.oneButton setTitle:self.upwardTitleString forState:0];
            
            ZXWeakSelf;
            [cell.leftButton addAction:^(UIButton *btn) {
                if (weakself.didSelectedButton) {
                    weakself.didSelectedButton(99);
                }
            }];
        }else{
            cell.backgroundColor = kWhiteColor;
            cell.leftButton.userInteractionEnabled = NO;
            [cell.leftButton setTitleColor:kBlackColor forState:0];
            [cell.leftButton setTitle:self.blurDataList[indexPath.row-1] forState:0];
        }
        
        return cell;
    }
    
    //无title（产品页面的状态、金额选择）
    identifier = @"upward1";
    BorrowBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[BorrowBaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.selectedBackgroundView = [[UIView alloc] init];
    
    cell.leftButton.userInteractionEnabled = NO;
    [cell.leftButton setTitle:self.blurDataList[indexPath.row] forState:0];
    [cell.leftButton setTitleColor:kBlackColor forState:0];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.tableType isEqualToString:@"有"]) {
        if (indexPath.row > 0) {
            if (self.didSelectedRow) {
                self.didSelectedRow(self.blurDataList[indexPath.row-1],indexPath.row);
            }
        }
    }else{//无title
        if (self.didSelectedRow) {
            self.didSelectedRow(self.blurDataList[indexPath.row],indexPath.row);
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
