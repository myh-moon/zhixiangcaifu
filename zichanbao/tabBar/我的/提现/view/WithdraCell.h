//
//  WithdraCell.h
//  zichanbao
//
//  Created by zhixiang on 16/9/8.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WithdraCell : UITableViewCell<UITextFieldDelegate>

@property (nonatomic,strong) void (^didEndEditing)(NSString *);

@property (nonatomic,strong) UIView *whiteView;
@property (nonatomic,strong) UIButton *cardButton;
@property (nonatomic,strong) UILabel *moneyLabel1;
@property (nonatomic,strong) UILabel *moneyLabel2;
@property (nonatomic,strong) UITextField *moneyTextField;
@property (nonatomic,strong) UILabel *lineLabel;
@property (nonatomic,strong) UIButton *allMoneyButton;

@property (nonatomic,assign) BOOL didSetupConstraints;



@end
