//
//  LoginSwitchView.h
//  zichanbao
//
//  Created by zhixiang on 16/12/22.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginSwitchView : UIView

@property (nonatomic,strong) void (^didSelectedButton)(UIButton *);
@property (nonatomic,assign) BOOL didSetupConstraints;
@property (nonatomic,strong) UIButton *firstButton;
@property (nonatomic,strong) UIButton *secondButton;
@property (nonatomic,strong) UILabel *lineLabel;  //分割线

@property (nonatomic,strong) NSLayoutConstraint *leftLineConstraints;

@end
