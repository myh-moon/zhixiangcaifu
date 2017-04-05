//
//  ChannelCell.h
//  zichanbao
//
//  Created by zhixiang on 16/12/23.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChannelCell : UITableViewCell

@property (nonatomic,assign) BOOL didSetupConstraints;
@property (nonatomic,strong) UIButton *chTimeButton;
@property (nonatomic,strong) UILabel *chLineLabel;
@property (nonatomic,strong) UILabel *chTextLabel;

@end
