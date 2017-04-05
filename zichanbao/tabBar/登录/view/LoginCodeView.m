//
//  LoginCodeView.m
//  zichanbao
//
//  Created by zhixiang on 16/12/22.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import "LoginCodeView.h"

@implementation LoginCodeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.imageButton];
        [self addSubview:self.contentTextField];
        [self addSubview:self.getCodeButton];
        [self addSubview:self.seperateLabel];
        
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        
        [self.imageButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:kSmallPadding];
        [self.imageButton autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
        
        [self.contentTextField autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.imageButton withOffset:kSmallPadding];
        [self.contentTextField autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.imageButton];
        [self.contentTextField autoSetDimension:ALDimensionWidth toSize:200];
        
        [self.getCodeButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:kSmallPadding];
        [self.getCodeButton autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.contentTextField];
        [self.getCodeButton autoSetDimension:ALDimensionWidth toSize:90];
        
        [self.seperateLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:kSmallPadding];
        [self.seperateLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:kSmallPadding];
        [self.seperateLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [self.seperateLabel autoSetDimension:ALDimensionHeight toSize:1];
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (UIButton *)imageButton
{
    if (!_imageButton) {
        _imageButton = [UIButton newAutoLayoutView];
    }
    return _imageButton;
}

- (UITextField *)contentTextField
{
    if (!_contentTextField) {
        _contentTextField = [UITextField newAutoLayoutView];
        _contentTextField.textColor = [UIColor whiteColor];
        _contentTextField.font = font14;
        _contentTextField.delegate = self;
    }
    return _contentTextField;
}

- (JKCountDownButton *)getCodeButton
{
    if (!_getCodeButton) {
        _getCodeButton = [JKCountDownButton newAutoLayoutView];
        _getCodeButton.layer.borderColor = kNavigationColor.CGColor;
        _getCodeButton.layer.borderWidth = kBorderWidth;
        _getCodeButton.layer.cornerRadius = 15;
        _getCodeButton.titleLabel.font = font14;
        [_getCodeButton setTitleColor:kNavigationColor forState:0];
    }
    return _getCodeButton;
}

- (UILabel *)seperateLabel
{
    if (!_seperateLabel) {
        _seperateLabel = [UILabel newAutoLayoutView];
        _seperateLabel.backgroundColor = [UIColor grayColor];
    }
    return _seperateLabel;
}

#pragma mark - delegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.didEndEditting) {
        self.didEndEditting(textField.text);
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
