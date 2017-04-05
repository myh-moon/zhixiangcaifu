//
//  StepView.h
//  zichanbao
//
//  Created by zhixiang on 17/2/15.
//  Copyright © 2017年 zhixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StepView : UIButton

@property (nonatomic,assign) BOOL didSetupConstraints;
@property (nonatomic,strong) UIButton *stepButton1;
@property (nonatomic,strong) UIButton *stepButton2;
@property (nonatomic,strong) UIButton *stepButton3;
@property (nonatomic,strong) UIButton *stepButton4;
@property (nonatomic,strong) UILabel *stepLabel1;
@property (nonatomic,strong) UILabel *stepLabel2;
@property (nonatomic,strong) UILabel *stepLabel3;
@property (nonatomic,strong) UILabel *stepLabel4;
@property (nonatomic,strong) UILabel *stepLine1;
@property (nonatomic,strong) UILabel *stepLine2;
@property (nonatomic,strong) UILabel *stepLine3;

@end
