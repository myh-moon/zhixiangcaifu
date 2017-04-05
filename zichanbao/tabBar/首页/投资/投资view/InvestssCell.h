//
//  InvestssCell.h
//  zichanbao
//
//  Created by zhixiang on 16/10/17.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InvestssCell : UITableViewCell<UITextFieldDelegate>

@property (nonatomic,assign) BOOL didSetupConstraints;
@property (nonatomic,strong) UIButton *leftButton;
@property (nonatomic,strong) UITextField *inTextField;
@property (nonatomic,strong) UIButton *inRightButton1;
@property (nonatomic,strong) UIButton *inRightButton2;

@property (nonatomic,strong) void (^didEndEditting)(NSString *);


@end
