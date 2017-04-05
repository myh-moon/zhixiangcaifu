//
//  EstimateCell.h
//  zichanbao
//
//  Created by zhixiang on 16/12/27.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EstimateCell : UITableViewCell<UITextFieldDelegate>

@property (nonatomic,strong) void (^didEndEditting)(NSString *);

@property (nonatomic,assign) BOOL didSetupConstraints;
@property (nonatomic,strong) UIButton *esNameButton;
@property (nonatomic,strong) UILabel *esLineLabel;
@property (nonatomic,strong) UITextField *esTextField;
@property (nonatomic,strong) UIButton *esTypeButton;

@end
