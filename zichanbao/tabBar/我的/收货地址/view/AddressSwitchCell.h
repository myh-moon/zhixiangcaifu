//
//  AddressSwitchCell.h
//  zichanbao
//
//  Created by zhixiang on 16/11/21.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressSwitchCell : UITableViewCell

@property (nonatomic,strong) void (^didSelestedSwitch)(BOOL);

@property (nonatomic,assign) BOOL didSetupConstraints;
@property (nonatomic,strong) UILabel *aaLabel;
@property (nonatomic,strong) UISwitch *aaSwitch;


@end
