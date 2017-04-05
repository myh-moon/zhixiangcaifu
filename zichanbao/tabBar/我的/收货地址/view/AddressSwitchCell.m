//
//  AddressSwitchCell.m
//  zichanbao
//
//  Created by zhixiang on 16/11/21.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import "AddressSwitchCell.h"

@implementation AddressSwitchCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.aaLabel];
        [self.contentView addSubview:self.aaSwitch];
        
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        
        [self.aaLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [self.aaLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:kSmallPadding];
        
        [self.aaSwitch autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:kSmallPadding];
        [self.aaSwitch autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.aaLabel];
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (UILabel *)aaLabel
{
    if (!_aaLabel) {
        _aaLabel = [UILabel newAutoLayoutView];
        _aaLabel.textColor = kBlackColor;
        _aaLabel.font = font14;
        _aaLabel.text = @"设为默认";
    }
    return _aaLabel;
}

- (UISwitch *)aaSwitch
{
    if (!_aaSwitch) {
        _aaSwitch = [UISwitch newAutoLayoutView];
        _aaSwitch.onTintColor = kNavigationColor;
        [_aaSwitch addTarget:self action:@selector(changeValuesOfSwitch:) forControlEvents:UIControlEventValueChanged];
    }
    return _aaSwitch;
}

- (void)changeValuesOfSwitch:(UISwitch *)sender
{
    if (self.didSelestedSwitch) {
        self.didSelestedSwitch(sender.isOn);
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
