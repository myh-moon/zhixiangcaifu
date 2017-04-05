//
//  LoginCodeCell.m
//  zichanbao
//
//  Created by zhixiang on 16/10/19.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import "LoginCodeCell.h"

@implementation LoginCodeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.nameButton];
        [self.contentView addSubview:self.nameTextField];
        [self.contentView addSubview:self.codeButton];
        
        self.leftTextFieldConstraint = [self.nameTextField autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:90];
        
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        
        [self.nameButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:kSmallPadding];
        [self.nameButton autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        [self.nameTextField autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.nameButton];
        
        [self.codeButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:kSmallPadding];
        [self.codeButton autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.nameTextField];
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (UIButton *)nameButton
{
    if (!_nameButton) {
        _nameButton = [UIButton newAutoLayoutView];
        _nameButton.titleLabel.font = font14;
        [_nameButton setTitleColor:kBlackColor forState:0];
    }
    return _nameButton;
}

- (UITextField *)nameTextField
{
    if (!_nameTextField) {
        _nameTextField = [UITextField newAutoLayoutView];
        _nameTextField.textColor = kGrayColor;
        _nameTextField.font = font14;
        _nameTextField.delegate = self;
        _nameTextField.returnKeyType = UIReturnKeyDone;
    }
    return _nameTextField;
}

- (JKCountDownButton *)codeButton
{
    if (!_codeButton) {
        _codeButton = [JKCountDownButton newAutoLayoutView];
        _codeButton.titleLabel.font = font14;
        [_codeButton setTitleColor:kBlackColor forState:0];
    }
    return _codeButton;
}

#pragma mark - textfield delegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.didEndEditing) {
        self.didEndEditing(textField.text);
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
