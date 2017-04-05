//
//  HomeCell.h
//  zichanbao
//
//  Created by zhixiang on 15/10/12.
//  Copyright (c) 2015年 zhixiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UAProgressView.h"

@interface HomeCell : UITableViewCell

@property (nonatomic,retain) UAProgressView *progressView;
@property (nonatomic,strong) UILabel *innnerLabel;  //进度条内部
@property (strong, nonatomic) UILabel *borrowName;  //名称
@property (nonatomic,strong) UIButton *rateBtn;  //收益
@property (nonatomic,strong) UIButton *dateBtn;  //期限
@property (nonatomic,strong) UIButton *moneyBtn; //金额
@property (nonatomic,strong) UIButton *signBtn;  //状态按钮
@property (nonatomic,strong) UILabel *rateLabel;   //具体收益
@property (nonatomic,strong) UILabel *dateLabel; //具体期限
@property (nonatomic,strong) UILabel *moneyLabel; //具体金额

@end
