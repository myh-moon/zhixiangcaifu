//
//  InvestsCell.h
//  zichanbao
//
//  Created by zhixiang on 16/10/17.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InvestsCell : UITableViewCell<UITextFieldDelegate>

@property (nonatomic,assign) BOOL didSetupConstraints;
@property (nonatomic,strong) UIButton *coButton;
@property (nonatomic,strong) UITextField *coTextField;
@property (nonatomic,strong) UIButton *coActButton;
@property (nonatomic,strong) NSLayoutConstraint *leftTextFieldConstraint;

@property (nonatomic,strong) void (^didEndEditting)(NSString *);

@end
