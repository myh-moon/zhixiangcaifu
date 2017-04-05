//
//  CreditListView.h
//  zichanbao
//
//  Created by zhixiang on 17/2/16.
//  Copyright © 2017年 zhixiang. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CreditListView : UIView

@property (nonatomic,assign) BOOL didSetupConstraints;
@property (nonatomic,strong) UIButton *creditButton;
@property (nonatomic,strong) UIButton *creditNameButton;
@property (nonatomic,strong) UIButton *creditSearchButton;

@property (nonatomic,strong) void (^didSelectedBtn)(NSInteger);

@end
