//
//  CreditAlertView.h
//  zichanbao
//
//  Created by zhixiang on 17/2/17.
//  Copyright © 2017年 zhixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreditAlertView : UIView
@property (nonatomic,strong) void (^didSelectedBtn)(NSInteger);
@property (nonatomic,assign) BOOL didSetupConstraints;
@property (nonatomic,strong) UIButton *titleButton;
@property (nonatomic,strong) UIButton *cancelButton;
@property (nonatomic,strong) UIButton *actButton1;
@property (nonatomic,strong) UIButton *actButton2;
@property (nonatomic,strong) UIButton *actButton3;

@end
