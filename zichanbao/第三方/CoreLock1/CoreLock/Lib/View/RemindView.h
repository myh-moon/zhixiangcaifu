//
//  RemindView.h
//  zichanbao
//
//  Created by zhixiang on 15/12/2.
//  Copyright © 2015年 zhixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RemindView : UIView

@property (nonatomic,strong) UILabel *zsdLabel;
@property (nonatomic,strong) UITextField *zsdTextField;
@property (nonatomic,strong) UIButton *zsdLeftButton;
@property (nonatomic,strong) UIButton *zsdRightButton;

@property (nonatomic,strong) void (^btnAction)(NSNumber *);

- (instancetype)initWithFrame:(CGRect)frame;

@end
