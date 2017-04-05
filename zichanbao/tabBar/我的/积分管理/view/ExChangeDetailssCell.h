//
//  ExChangeDetailssCell.h
//  zichanbao
//
//  Created by zhixiang on 16/11/9.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaceholderTextView.h"

@interface ExChangeDetailssCell : UITableViewCell<UITextViewDelegate>

@property (nonatomic,assign) BOOL didSetupConstraints;
@property (nonatomic,strong) UILabel *ssLabel;
@property (nonatomic,strong) PlaceholderTextView *ssTextView;

@property (nonatomic,strong) NSLayoutConstraint *lefTextViewConstraints;
@property (nonatomic,strong) void (^didEndEditting)(NSString *text);
@property (nonatomic,copy) void (^touchBeginPoint)(CGPoint);


@end
