//
//  MineMoneyView.h
//  zichanbao
//
//  Created by zhixiang on 15/11/6.
//  Copyright © 2015年 zhixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineMoneyView : UIView

@property (nonatomic,strong) UIButton *userButton1;
@property (nonatomic,strong) UIButton *userButton2;
@property (nonatomic,strong) UIImageView *userImage;
@property (nonatomic,strong) UIButton *retainBtn;  //余额
//@property (nonatomic,strong) UILabel *redLabel;     //红包
@property (nonatomic,strong) UIButton *rechargeBtn;  //充值
@property (nonatomic,strong) UIButton *withdraBtn;    //提现

@property (nonatomic,strong) UIView *whiteView;
@property (nonatomic,strong) UILabel *allMoneyLabel;
@property (nonatomic,strong) UILabel *moneyLabel1;  //具体总资产
@property (nonatomic,strong) UILabel *moneyLabel2;  //待收收益
@property (nonatomic,strong) UILabel *moneyLabel3;  //累计收益
@property (nonatomic,strong) UILabel *moneyLabel4;  //待收本金
@property (nonatomic,strong) UILabel *moneyLabel5;  //冻结本金
- (instancetype)initWithFrame:(CGRect)frame andStyle:(NSNumber *)style;
@end
