//
//  PayAddressCell.h
//  zichanbao
//
//  Created by zhixiang on 16/11/10.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayAddressCell : UITableViewCell

@property (nonatomic,assign) BOOL didSetupConstraints;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *phoneLabel;
@property (nonatomic,strong) UIImageView *addressImageView;
@property (nonatomic,strong) UIButton *addressButton;
@property (nonatomic,strong) UIImageView *actImageView;
@property (nonatomic,strong) UILabel *ideaLabel;
@property (nonatomic,strong) UIImageView *bottomImageView;

@end
