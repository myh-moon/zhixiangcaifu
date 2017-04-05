//
//  AnotherAlertView.h
//  zichanbao
//
//  Created by zhixiang on 17/2/21.
//  Copyright © 2017年 zhixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnotherAlertView : UIView<UITextFieldDelegate>

@property (nonatomic,assign) BOOL didSetupConstraints;
@property (nonatomic,strong) UIButton *aTitleButton;
@property (nonatomic,strong) UITextField *aTextField;
@property (nonatomic,strong) UIButton *aLeftButton;
@property (nonatomic,strong) UIButton *aRightButton;

@property (nonatomic,strong) void (^didSelectedBtn)(NSInteger);
@property (nonatomic,strong) void (^didEndEditting)(NSString *);

@end
