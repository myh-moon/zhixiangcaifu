//
//  AnotherAlertView.m
//  zichanbao
//
//  Created by zhixiang on 17/2/21.
//  Copyright © 2017年 zhixiang. All rights reserved.
//

#import "AnotherAlertView.h"

@implementation AnotherAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.aTitleButton];
        
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        
        [self.aTitleButton autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:kScreenHeight/4];
        [self.aTitleButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:50];
        [self.aTitleButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:50];
        [self.aTitleButton autoMatchDimension:ALDimensionHeight toDimension:ALDimensionWidth ofView:self.aTitleButton];
        
        [self.aTextField autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.aTitleButton withOffset:(kScreenWidth-100)/2+22];
        [self.aTextField autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.aTitleButton withOffset:10];
        [self.aTextField autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.aTitleButton withOffset:-10];
        [self.aTextField autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.aLeftButton withOffset:-10];
        
        [self.aLeftButton autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.aTitleButton];
        [self.aLeftButton autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.aTitleButton];
        [self.aLeftButton autoSetDimension:ALDimensionWidth toSize:(kScreenWidth-100)/2];
        [self.aLeftButton autoSetDimension:ALDimensionHeight toSize:60];
        
        [self.aRightButton autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.aLeftButton];
        [self.aRightButton autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.aTitleButton];
        [self.aRightButton autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.aLeftButton];
        [self.aRightButton autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.aLeftButton];
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}


- (UIButton *)aTitleButton
{
    if (!_aTitleButton) {
        _aTitleButton = [UIButton newAutoLayoutView];
        _aLeftButton.layer.cornerRadius = 10;
        _aLeftButton.layer.masksToBounds = YES;
        
        [_aTitleButton addSubview:self.aTextField];
        [_aTitleButton addSubview:self.aLeftButton];
        [_aTitleButton addSubview:self.aRightButton];
    }
    return _aTitleButton;
}

- (UITextField *)aTextField
{
    if (!_aTextField) {
        _aTextField = [UITextField newAutoLayoutView];
        _aTextField.textAlignment = 1;
        _aTextField.layer.borderWidth = kBorderWidth;
        _aTextField.layer.borderColor = kLightGrayColor.CGColor;
        _aTextField.layer.cornerRadius = 2;
        _aTextField.backgroundColor = kBackgroundColor;
        _aTextField.delegate = self;
    }
    return _aTextField;
}

- (UIButton *)aLeftButton
{
    if (!_aLeftButton) {
        _aLeftButton = [UIButton newAutoLayoutView];
        [_aLeftButton setTitleColor:kNavigationColor forState:0];
        _aLeftButton.titleLabel.font = font18;
        _aLeftButton.layer.masksToBounds = YES;
        _aLeftButton.clipsToBounds  = YES;
        [_aLeftButton setBackgroundImage:[UIImage imageNamed:@"le"] forState:0];
        
        ZXWeakSelf;
        [_aLeftButton addAction:^(UIButton *btn) {
            if (weakself.didSelectedBtn) {
                weakself.didSelectedBtn(67);
            }
        }];
    }
    return _aLeftButton;
}

- (UIButton *)aRightButton
{
    if (!_aRightButton) {
        _aRightButton  = [UIButton newAutoLayoutView];
        [_aRightButton setTitleColor:kNavigationColor forState:0];
        _aRightButton.titleLabel.font = font18;
        _aRightButton.layer.masksToBounds = YES;
        _aRightButton.clipsToBounds = YES;
        [_aRightButton setBackgroundImage:[UIImage imageNamed:@"ri"] forState:0];
        
        ZXWeakSelf;
        [_aRightButton addAction:^(UIButton *btn) {
            if (weakself.didSelectedBtn) {
                weakself.didSelectedBtn(68);
            }
        }];
    }
    return _aRightButton;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.didEndEditting) {
        self.didEndEditting(textField.text);
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
