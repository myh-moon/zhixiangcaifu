//
//  ChannelAACell.m
//  zichanbao
//
//  Created by zhixiang on 16/12/27.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import "ChannelAACell.h"

@implementation ChannelAACell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.evaCodeButton];
        [self.contentView addSubview:self.evaTimeLabel];
        
        [self.contentView addSubview:self.evaLineLabel];
        [self.contentView addSubview:self.evaHomeLabel];
        [self.contentView addSubview:self.evaContentLabel];
        [self.contentView addSubview:self.evaBackTimeLabel];
        [self.contentView addSubview:self.evaModifyButton];
        [self.contentView addSubview:self.evaCheckButton];
        
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        
        [self.evaCodeButton autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:kSmallSpace];
        [self.evaCodeButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
        
        [self.evaTimeLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
        [self.evaTimeLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.evaCodeButton];
        
        [self.evaLineLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.evaCodeButton withOffset:kSmallSpace];
        [self.evaLineLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.evaCodeButton];
        [self.evaLineLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.evaTimeLabel];
        [self.evaLineLabel autoSetDimension:ALDimensionHeight toSize:1];
        
        [self.evaHomeLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.evaLineLabel withOffset:10];
        [self.evaHomeLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.evaLineLabel];
        
        [self.evaContentLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.evaHomeLabel withOffset:6];
        [self.evaContentLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.evaHomeLabel];
        
        [self.evaBackTimeLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.evaContentLabel withOffset:6];
        [self.evaBackTimeLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.evaContentLabel];
        
        [self.evaModifyButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.evaBackTimeLabel];
        [self.evaModifyButton autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.evaCheckButton withOffset:-10];
        [self.evaModifyButton autoSetDimensionsToSize:CGSizeMake(60, 24)];
        
        [self.evaCheckButton autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.evaTimeLabel];
        [self.evaCheckButton autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.evaModifyButton];
        [self.evaCheckButton autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.evaModifyButton];
        [self.evaCheckButton autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self.evaModifyButton];
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (UIButton *)evaCodeButton
{
    if (!_evaCodeButton) {
        _evaCodeButton = [UIButton newAutoLayoutView];
        [_evaCodeButton setTitleColor:kDarkGrayColor forState:0];
        _evaCodeButton.titleLabel.font = font13;
        [_evaCodeButton setContentHorizontalAlignment:1];
    }
    return _evaCodeButton;
}

- (UILabel *)evaTimeLabel
{
    if (!_evaTimeLabel) {
        _evaTimeLabel = [UILabel newAutoLayoutView];
        _evaTimeLabel.textColor = kNavigationColor;
        _evaTimeLabel.font = font13;
    }
    return _evaTimeLabel;
}

- (UILabel *)evaLineLabel
{
    if (!_evaLineLabel) {
        _evaLineLabel = [UILabel newAutoLayoutView];
        _evaLineLabel.backgroundColor = [UIColor lightGrayColor];
    }
    return _evaLineLabel;
}

- (UILabel *)evaHomeLabel
{
    if (!_evaHomeLabel) {
        _evaHomeLabel = [UILabel newAutoLayoutView];
        _evaHomeLabel.textColor = kBlackColor;
        _evaHomeLabel.font = font16;
    }
    return _evaHomeLabel;
}

- (UILabel *)evaContentLabel
{
    if (!_evaContentLabel) {
        _evaContentLabel = [UILabel newAutoLayoutView];
        _evaContentLabel.numberOfLines = 0;
    }
    return _evaContentLabel;
}

- (UILabel *)evaBackTimeLabel
{
    if (!_evaBackTimeLabel) {
        _evaBackTimeLabel = [UILabel newAutoLayoutView];
        _evaBackTimeLabel.textColor = kDarkGrayColor;
        _evaBackTimeLabel.font = font13;
    }
    return _evaBackTimeLabel;
}

- (UIButton *)evaModifyButton
{
    if (!_evaModifyButton) {
        _evaModifyButton = [UIButton newAutoLayoutView];
        [_evaModifyButton setTitleColor:kNavigationColor forState:0];
        _evaModifyButton.titleLabel.font = font13;
        _evaModifyButton.layer.borderColor = kGrayColor.CGColor;
        _evaModifyButton.layer.borderWidth = kBorderWidth;
    }
    return _evaModifyButton;
}

- (UIButton *)evaCheckButton
{
    if (!_evaCheckButton) {
        _evaCheckButton = [UIButton newAutoLayoutView];
        [_evaCheckButton setTitleColor:kNavigationColor forState:0];
        _evaCheckButton.titleLabel.font = font13;
        _evaCheckButton.layer.borderColor = kGrayColor.CGColor;
        _evaCheckButton.layer.borderWidth = kBorderWidth;
    }
    return _evaCheckButton;
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
