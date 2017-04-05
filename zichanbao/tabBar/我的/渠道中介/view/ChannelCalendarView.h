//
//  ChannelCalendarView.h
//  zichanbao
//
//  Created by zhixiang on 16/12/26.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+Addition.h"

@interface ChannelCalendarView : UIView

@property (nonatomic,assign) BOOL didSetupConstraints;
@property (nonatomic,strong) UIButton *fromDateButton;
@property (nonatomic,strong) UILabel *daoLabel;
@property (nonatomic,strong) UIButton *toDateButton;
@property (nonatomic,strong) UIButton *dateSearchButton;

@property (nonatomic,strong) UIImageView *fromImageView;
@property (nonatomic,strong) UIImageView *toImageView;

@property (nonatomic,strong) void (^didSelectedBtn)(UIButton *);

@end
