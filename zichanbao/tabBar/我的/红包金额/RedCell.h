//
//  RedCell.h
//  zichanbao
//
//  Created by zhixiang on 15/10/19.
//  Copyright (c) 2015年 zhixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RedCell : UITableViewCell


@property (strong, nonatomic) UILabel *nameHongBao;
@property (strong, nonatomic) UILabel *getTimeLab;
@property (strong, nonatomic) UILabel *indataLab;
@property (strong,nonatomic) UIButton *moneyBtn;


+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
