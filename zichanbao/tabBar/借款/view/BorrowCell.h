//
//  BorrowCell.h
//  zichanbao
//
//  Created by zhixiang on 16/9/27.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BorrowCell : UITableViewCell<UITextFieldDelegate>

@property (nonatomic,strong) void (^didEndEditing)(NSString *text);

@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UITextField *nameTextField;
@property (nonatomic,strong) UIButton *nameButton;
@property (nonatomic,strong) NSLayoutConstraint *leftTextFieldConstraint;

@property (nonatomic,assign) BOOL didSetupConstraints;

@end
