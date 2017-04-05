//
//  LoginCodeView.h
//  zichanbao
//
//  Created by zhixiang on 16/12/22.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKCountDownButton.h"

@interface LoginCodeView : UIView<UITextFieldDelegate>

@property (nonatomic,strong) void (^didEndEditting)(NSString *);

@property (nonatomic,assign) BOOL didSetupConstraints;
@property (nonatomic,strong) UIButton *imageButton;
@property (nonatomic,strong) UITextField *contentTextField;
@property (nonatomic,strong) JKCountDownButton *getCodeButton;
@property (nonatomic,strong) UILabel *seperateLabel;

@end
