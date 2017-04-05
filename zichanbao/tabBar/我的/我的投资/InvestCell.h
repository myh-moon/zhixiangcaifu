//
//  InvestCell.h
//  zichanbao
//
//  Created by zhixiang on 15/10/14.
//  Copyright (c) 2015年 zhixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InvestCell : UITableViewCell

@property (nonatomic,assign) BOOL didSetupConstraints;
@property (nonatomic,strong) UILabel *headerLabel;  //头部分割线
@property (nonatomic,strong) UIButton *typeBtn1;  //类型
@property (nonatomic,strong) UILabel *nameLabel;  //标名
@property (nonatomic,strong) UILabel *lineLabel;  //分割线
@property (nonatomic,strong) UIButton *typeBtn2; //投资类型
@property (nonatomic,strong) UILabel *moneyLabel; //投资金额
@property (nonatomic,strong) UILabel *dateLabel; //投资期限
@property (nonatomic,strong) UILabel *ProfitLabel;  //预期收益
@property (nonatomic,strong) UILabel *wayLabel;  //还款方式
@property (nonatomic,strong) UILabel *rateLabel1; //年化率
@property (nonatomic,strong) UILabel *rateLabel2;//具体年化率

@end
