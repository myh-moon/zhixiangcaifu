//
//  PayNumberCell.h
//  zichanbao
//
//  Created by zhixiang on 16/11/10.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddView.h"

@interface PayNumberCell : UITableViewCell

@property (nonatomic,assign) BOOL didSetupConstraints;
@property (nonatomic,strong) UIButton *ppButton;

@property (nonatomic,strong) AddView *addNumberView;

@end
