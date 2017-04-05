//
//  ChannelBBCell.h
//  zichanbao
//
//  Created by zhixiang on 16/12/27.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChannelBBCell : UITableViewCell

@property (nonatomic,assign) BOOL didSetupConstraints;
@property (nonatomic,strong) UIButton *intoCodeButton;
@property (nonatomic,strong) UILabel *intoTimeLabel;
@property (nonatomic,strong) UILabel *intoLineLabel;
@property (nonatomic,strong) UILabel *intoUserLabel;
@property (nonatomic,strong) UILabel *intoMoneyLabel;
@property (nonatomic,strong) UILabel *intoOperatorLabel;
@property (nonatomic,strong) UILabel *intoStateLabel;

@end
