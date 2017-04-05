//
//  EstimateCell.m
//  zichanbao
//
//  Created by zhixiang on 16/12/27.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import "EstimateCell.h"

@implementation EstimateCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.esNameButton];
        [self.contentView addSubview:self.esLineLabel];
        [self.contentView addSubview:self.esTextField];
        [self.contentView addSubview:self.esTypeButton];
        
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        
        [self.esNameButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:kSmallPadding];
        [self.esNameButton autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        [self.esLineLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
        [self.esLineLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
        [self.esLineLabel autoSetDimension:ALDimensionWidth toSize:1];
        [self.esLineLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:120];
        [self.esLineLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.esNameButton];
        [self.esLineLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.esNameButton];
        
        [self.esTextField autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.esNameButton];
        [self.esTextField autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.esLineLabel withOffset:kSmallPadding];
        [self.esTextField autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.esTypeButton];
        
        [self.esTypeButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:kSmallPadding];
        [self.esTypeButton autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.esTextField];
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (UIButton *)esNameButton
{
    if (!_esNameButton) {
        _esNameButton = [UIButton newAutoLayoutView];
        [_esNameButton setTitleColor:kNavigationColor forState:0];
        _esNameButton.titleLabel.font = font14;
    }
    return _esNameButton;
}

- (UILabel *)esLineLabel
{
    if (!_esLineLabel) {
        _esLineLabel = [UILabel newAutoLayoutView];
        _esLineLabel.backgroundColor = [UIColor lightGrayColor];
    }
    return _esLineLabel;
}

- (UITextField *)esTextField
{
    if (!_esTextField) {
        _esTextField = [UITextField newAutoLayoutView];
        _esTextField.font = font14;
        _esTextField.textColor = kGrayColor;
        _esTextField.delegate = self;
    }
    return _esTextField;
}

- (UIButton *)esTypeButton
{
    if (!_esTypeButton) {
        _esTypeButton  =[UIButton newAutoLayoutView];
        [_esTypeButton setTitleColor:kNavigationColor forState:0];
        _esTypeButton.titleLabel.font = font14;
    }
    return _esTypeButton;
}

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

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
