//
//  AddView.h
//  zichanbao
//
//  Created by zhixiang on 16/11/10.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddView : UIView
@property (nonatomic,strong) void (^didSelected)(NSInteger);

@property (nonatomic,strong) UIButton *downButton;
@property (nonatomic,strong) UILabel *numberLabel;
@property (nonatomic,strong) UIButton *upButton;

@property (nonatomic,assign) BOOL didSetupConstraint;

@end
