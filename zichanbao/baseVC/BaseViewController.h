//
//  BaseViewController.h
//  zcb
//
//  Created by zhixiang on 15/10/8.
//  Copyright (c) 2015年 zhixiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountModel.h"
#import "RemindNoButton.h"

@interface BaseViewController : UIViewController

@property (nonatomic,strong) RemindNoButton *remindButton;
@property (nonatomic,strong) UIBarButtonItem *leftItem;
@property (nonatomic,strong) UIButton *rightButton;

- (void)back;
- (void)rightAction;

-(AccountModel *)checkMyAccount;

@end
