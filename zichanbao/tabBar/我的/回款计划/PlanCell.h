//
//  PlanCell.h
//  zichanbao
//
//  Created by zhixiang on 15/10/15.
//  Copyright (c) 2015年 zhixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlanCell : UITableViewCell

@property (nonatomic,assign) BOOL didSetupConstraints;
@property (nonatomic,strong) UIView *whiteView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *lineLabel1;
@property (nonatomic,strong) UILabel *dateLabel;
@property (nonatomic,strong) UILabel *moneyLabel;
@property (nonatomic,strong) UILabel *rateLabel;

@end
