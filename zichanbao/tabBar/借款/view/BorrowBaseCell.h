//
//  BorrowBaseCell.h
//  zichanbao
//
//  Created by zhixiang on 16/10/19.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BorrowBaseCell : UITableViewCell

@property (nonatomic,assign) BOOL didSetupConstraint;
@property (nonatomic,strong) UIButton *leftButton;
@property (nonatomic,strong) UIButton *rightButton;

@end
