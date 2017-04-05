//
//  ChannelBBCell.m
//  zichanbao
//
//  Created by zhixiang on 16/12/27.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import "ChannelBBCell.h"

@implementation ChannelBBCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self.contentView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.intoCodeButton];
        [self.contentView addSubview:self.intoTimeLabel];
        [self.contentView addSubview:self.intoLineLabel];
        [self.contentView addSubview:self.intoUserLabel];
        [self.contentView addSubview:self.intoMoneyLabel];
        [self.contentView addSubview:self.intoOperatorLabel];
        [self.contentView addSubview:self.intoStateLabel];
        
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        
        [self.intoCodeButton autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:kSmallSpace];
        [self.intoCodeButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
        
        [self.intoTimeLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
        [self.intoTimeLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.intoCodeButton];
        
        [self.intoLineLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.intoCodeButton withOffset:kSmallSpace];
        [self.intoLineLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.intoCodeButton];
        [self.intoLineLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.intoTimeLabel];
        [self.intoLineLabel autoSetDimension:ALDimensionHeight toSize:1];
        
        [self.intoUserLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.intoLineLabel];
        [self.intoUserLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.intoLineLabel withOffset:10];
        
        [self.intoMoneyLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.intoLineLabel];
        [self.intoMoneyLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.intoUserLabel];
        
        [self.intoOperatorLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.intoUserLabel withOffset:10];
        [self.intoOperatorLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.intoUserLabel];
        
        [self.intoStateLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.intoMoneyLabel];
        [self.intoStateLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.intoOperatorLabel];
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (UIButton *)intoCodeButton
{
    if (!_intoCodeButton) {
        _intoCodeButton = [UIButton newAutoLayoutView];
        [_intoCodeButton setTitleColor:kDarkGrayColor forState:0];
        _intoCodeButton.titleLabel.font = font13;
    }
    return _intoCodeButton;
}

- (UILabel *)intoTimeLabel
{
    if (!_intoTimeLabel) {
        _intoTimeLabel = [UILabel newAutoLayoutView];
        _intoTimeLabel.textColor = kNavigationColor;
        _intoTimeLabel.font = font13;
    }
    return _intoTimeLabel;
}

- (UILabel *)intoLineLabel
{
    if (!_intoLineLabel) {
        _intoLineLabel = [UILabel newAutoLayoutView];
        _intoLineLabel.backgroundColor = [UIColor lightGrayColor];
    }
    return _intoLineLabel;
}

- (UILabel *)intoUserLabel
{
    if (!_intoUserLabel) {
        _intoUserLabel = [UILabel newAutoLayoutView];
        _intoUserLabel.textColor = kBlackColor;
        _intoUserLabel.font = font16;
    }
    return _intoUserLabel;
}

- (UILabel *)intoMoneyLabel
{
    if (!_intoMoneyLabel) {
        _intoMoneyLabel = [UILabel newAutoLayoutView];
        _intoMoneyLabel.textColor = kBlackColor;
        _intoMoneyLabel.font = font18;
    }
    return _intoMoneyLabel;
}

- (UILabel *)intoOperatorLabel
{
    if (!_intoOperatorLabel) {
        _intoOperatorLabel = [UILabel newAutoLayoutView];
        _intoOperatorLabel.numberOfLines = 0;
    }
    return _intoOperatorLabel;
}

- (UILabel *)intoStateLabel
{
    if (!_intoStateLabel) {
        _intoStateLabel = [UILabel newAutoLayoutView];
        _intoStateLabel.numberOfLines = 0;
    }
    return _intoStateLabel;
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
