//
//  LoginCodeCell.h
//  zichanbao
//
//  Created by zhixiang on 16/10/19.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKCountDownButton.h"

@interface LoginCodeCell : UITableViewCell<UITextFieldDelegate>

@property (nonatomic,strong) void (^didEndEditing)(NSString *);

@property (nonatomic,strong) UIButton *nameButton;
@property (nonatomic,strong) UITextField *nameTextField;
@property (nonatomic,strong) JKCountDownButton *codeButton;

@property (nonatomic,strong) NSLayoutConstraint *leftTextFieldConstraint;

@property (nonatomic,assign) BOOL didSetupConstraints;

@end
