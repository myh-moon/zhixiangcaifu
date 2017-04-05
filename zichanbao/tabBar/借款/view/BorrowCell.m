//
//  BorrowCell.m
//  zichanbao
//
//  Created by zhixiang on 16/9/27.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import "BorrowCell.h"

@implementation BorrowCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.nameTextField];
        [self.contentView addSubview:self.nameButton];
        
        self.leftTextFieldConstraint = [self.nameTextField autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:90];

        
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        
        [self.nameLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:kSmallPadding];
        [self.nameLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        [self.nameTextField autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.nameLabel];
        
        [self.nameButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:kSmallPadding];
        [self.nameButton autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.nameLabel];
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [UILabel newAutoLayoutView];
        _nameLabel.font = font14;
        _nameLabel.textColor = kBlackColor;
    }
    return _nameLabel;
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

- (UIButton *)nameButton
{
    if (!_nameButton) {
        _nameButton = [UIButton newAutoLayoutView];
        _nameButton.titleLabel.font = font14;
        [_nameButton setTitleColor:kBlackColor forState:0];
    }
    return _nameButton;
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
