//
//  InvestssCell.m
//  zichanbao
//
//  Created by zhixiang on 16/10/17.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import "InvestssCell.h"

@implementation InvestssCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.leftButton];
        [self.contentView addSubview:self.inTextField];
        [self.contentView addSubview:self.inRightButton1];
        [self.contentView addSubview:self.inRightButton2];
        
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        
        [self.leftButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:kSmallPadding];
        [self.leftButton autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        [self.inTextField autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:80];
        [self.inTextField autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.leftButton];
        
        [self.inRightButton1 autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.inRightButton2 withOffset:-10];
        [self.inRightButton1 autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.inTextField];
        [self.inRightButton1 autoSetDimension:ALDimensionHeight toSize:25];
        [self.inRightButton1 autoSetDimension:ALDimensionWidth toSize:40];

        [self.inRightButton2 autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:kSmallPadding];
        [self.inRightButton2 autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.inRightButton1];
        [self.inRightButton2 autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self.inRightButton1];
        [self.inRightButton2 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.inRightButton1];

        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (UIButton *)leftButton
{
    if (!_leftButton) {
        _leftButton = [UIButton newAutoLayoutView];
        [_leftButton setTitleColor:kBlackColor forState:0];
        _leftButton.titleLabel.font = font14;
    }
    return _leftButton;
}

- (UITextField *)inTextField
{
    if (!_inTextField) {
        _inTextField = [UITextField newAutoLayoutView];
        _inTextField.delegate = self;
        _inTextField.textColor = kBlackColor;
        _inTextField.font = font14;
    }
    return _inTextField;
}

- (UIButton *)inRightButton1
{
    if (!_inRightButton1) {
        _inRightButton1 = [UIButton newAutoLayoutView];
        [_inRightButton1 setTitleColor:[UIColor whiteColor] forState:0];
        _inRightButton1.titleLabel.font = font14;
        _inRightButton1.backgroundColor = kNavigationColor;
        _inRightButton1.layer.cornerRadius = 2;
        [_inRightButton1 setTitle:@"充值" forState:0];
    }
    return _inRightButton1;
}

- (UIButton *)inRightButton2
{
    if (!_inRightButton2) {
        _inRightButton2 = [UIButton newAutoLayoutView];
        [_inRightButton2 setTitleColor:[UIColor whiteColor] forState:0];
        _inRightButton2.titleLabel.font = font14;
        _inRightButton2.backgroundColor = kNavigationColor;
        _inRightButton2.layer.cornerRadius = 2;
        [_inRightButton2 setTitle:@"全投" forState:0];
    }
    return _inRightButton2;
}

#pragma mark - textField delagate
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
