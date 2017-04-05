//
//  InvestsCell.m
//  zichanbao
//
//  Created by zhixiang on 16/10/17.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import "InvestsCell.h"

@implementation InvestsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.coButton];
        [self.contentView addSubview:self.coTextField];
        [self.contentView addSubview:self.coActButton];
        
        self.leftTextFieldConstraint = [self.coTextField autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:90];
        ;
        
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        
        [self.coButton autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [self.coButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:kSmallPadding];
        
        [self.coTextField autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.coButton];
        
        [self.coActButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:kSmallPadding];
        [self.coActButton autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.coTextField];
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (UIButton *)coButton
{
    if (!_coButton) {
        _coButton = [UIButton newAutoLayoutView];
        [_coButton setTitleColor:kBlackColor forState:0];
        _coButton.titleLabel.font = font14;
    }
    return _coButton;
}

- (UITextField *)coTextField
{
    if (!_coTextField) {
        _coTextField = [UITextField newAutoLayoutView];
        _coTextField.delegate = self;
        _coTextField.textColor = kBlackColor;
        _coTextField.font = font14;
    }
    return _coTextField;
}

- (UIButton *)coActButton
{
    if (!_coActButton) {
        _coActButton = [UIButton newAutoLayoutView];
        [_coActButton setTitleColor:kBlackColor forState:0];
        _coActButton.titleLabel.font = font14;
    }
    return _coActButton;
}

#pragma mark - textField delagate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.didEndEditting) {
        self.didEndEditting(textField.text);
    }
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
