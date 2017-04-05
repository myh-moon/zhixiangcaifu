//
//  InteExchangeCell.m
//  zichanbao
//
//  Created by zhixiang on 16/11/8.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import "InteExchangeCell.h"

@implementation InteExchangeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.inteImageView];
        [self.contentView addSubview:self.inteLabel];
        
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints
{
    if (!self.didSetupConstarints) {
        
        [self.inteImageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(kSmallPadding, kSmallPadding, kSmallPadding, 0) excludingEdge:ALEdgeRight];
        [self.inteImageView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionHeight ofView:self.inteImageView];
         
        [self.inteLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.inteImageView withOffset:kSmallPadding];
        [self.inteLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.inteImageView];
        [self.inteLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:kSmallPadding];
        
        self.didSetupConstarints = YES;
    }
    [super updateConstraints];
}

- (UIImageView *)inteImageView
{
    if (!_inteImageView) {
        _inteImageView = [UIImageView newAutoLayoutView];
        _inteImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _inteImageView.layer.borderWidth = 0.5;
    }
    return _inteImageView;
}

- (UILabel *)inteLabel
{
    if (!_inteLabel) {
        _inteLabel = [UILabel newAutoLayoutView];
    }
    return _inteLabel;
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
