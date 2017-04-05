//
//  RemindNoButton.h
//  zichanbao
//
//  Created by zhixiang on 17/1/5.
//  Copyright © 2017年 zhixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RemindNoButton : UIButton

@property (nonatomic,assign) BOOL didSetupConstraints;
@property (nonatomic,strong) UIButton *noImageButton;
@property (nonatomic,strong) UIButton *noTextButton;

@end
