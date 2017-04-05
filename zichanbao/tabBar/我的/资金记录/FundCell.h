//
//  FundCell.h
//  zichanbao
//
//  Created by zhixiang on 15/10/14.
//  Copyright (c) 2015年 zhixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FundCell : UITableViewCell

@property (nonatomic,strong) UILabel *moneyLabel;
@property (nonatomic,strong) UILabel *timeLabel;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
