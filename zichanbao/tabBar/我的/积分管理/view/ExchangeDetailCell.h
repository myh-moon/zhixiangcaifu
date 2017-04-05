//
//  ExchangeDetailCell.h
//  zichanbao
//
//  Created by zhixiang on 16/11/9.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExchangeDetailCell : UITableViewCell

@property (nonatomic,assign) BOOL didSetupConstraints;
@property (nonatomic,strong) UILabel *exchangeLabel1;
@property (nonatomic,strong) UIButton *exchangeButton;
@property (nonatomic,strong) UILabel *exchangeLabel2;

@end
