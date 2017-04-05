//
//  ChannelAACell.h
//  zichanbao
//
//  Created by zhixiang on 16/12/27.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChannelAACell : UITableViewCell

@property (nonatomic,assign) BOOL didSetupConstraints;
@property (nonatomic,strong) UIButton *evaCodeButton; //编号
@property (nonatomic,strong) UILabel *evaTimeLabel;//申请时间
@property (nonatomic,strong) UILabel *evaLineLabel;//分割线
@property (nonatomic,strong) UILabel *evaHomeLabel;//地址
@property (nonatomic,strong) UILabel *evaContentLabel;//房产面积＋预估价格
@property (nonatomic,strong) UILabel *evaBackTimeLabel;//回复时间
@property (nonatomic,strong) UIButton *evaModifyButton;//修改
@property (nonatomic,strong) UIButton *evaCheckButton;  //查看

@end
