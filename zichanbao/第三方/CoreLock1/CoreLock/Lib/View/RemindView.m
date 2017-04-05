//
//  RemindView.m
//  zichanbao
//
//  Created by zhixiang on 15/12/2.
//  Copyright © 2015年 zhixiang. All rights reserved.
//

#import "RemindView.h"


@implementation RemindView

-(instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.zsdLabel];
        [self addSubview:self.zsdTextField];
        [self addSubview:self.zsdLeftButton];
        [self addSubview:self.zsdRightButton];
        
    }
    return self;
}

-(UILabel *)zsdLabel
{
    if (!_zsdLabel) {
        _zsdLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, self.width, 20)];
        _zsdLabel.textColor = [UIColor blackColor];
        _zsdLabel.text = @"请输入登录密码";
        _zsdLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _zsdLabel;
}

-(UITextField *)zsdTextField
{
    if (!_zsdTextField) {
        _zsdTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, self.zsdLabel.bottom+20, self.width-10*2, 40)];
        _zsdTextField.placeholder = @"登录密码";
        _zsdTextField.borderStyle = UITextBorderStyleRoundedRect;
    }
    return _zsdTextField;
}

-(UIButton *)zsdLeftButton
{
    if (!_zsdLeftButton) {
        _zsdLeftButton = [UIButton buttonWithType:0];
        _zsdLeftButton.frame = CGRectMake(self.zsdTextField.left, self.zsdTextField.bottom+10,self.zsdTextField.width/2, self.zsdTextField.height);
        [_zsdLeftButton setTitle:@"取消" forState:0];
        [_zsdLeftButton setTitleColor:[UIColor darkGrayColor] forState:0];
        [_zsdLeftButton setBackgroundColor:RGBCOLOR(0.9804, 0.9843, 0.9882)];
        ZXWeakSelf;
        [_zsdLeftButton addAction:^(UIButton *btn) {
            if (weakself.btnAction) {
                weakself.btnAction(@0);
            }
        }];
    }
    return _zsdLeftButton;
}

-(UIButton *)zsdRightButton
{
    if (!_zsdRightButton) {
        _zsdRightButton = [UIButton buttonWithType:0];
        _zsdRightButton.frame = CGRectMake(self.zsdLeftButton.right, self.zsdLeftButton.top, self.zsdLeftButton.width, self.zsdLeftButton.height);
        [_zsdRightButton setTitleColor:[UIColor lightGrayColor] forState:0];
        [_zsdRightButton setTitle:@"确定" forState:0];
        [_zsdRightButton setBackgroundColor:[UIColor clearColor]];
        ZXWeakSelf;
        [_zsdRightButton addAction:^(UIButton *btn) {
            if (weakself.btnAction) {
                weakself.btnAction(@1);
            }
        }];
    }
    return _zsdRightButton;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
