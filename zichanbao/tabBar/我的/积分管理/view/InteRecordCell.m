//
//  InteRecordCell.m
//  zichanbao
//
//  Created by zhixiang on 16/11/8.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import "InteRecordCell.h"

@implementation InteRecordCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.recordImageView];
        [self.contentView addSubview:self.recordLabel];
        [self.contentView addSubview:self.recordButton];
        
        [self.contentView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 8, 8, 8)];
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        
        [self.recordImageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(kSmallPadding, 8, kSmallPadding, 0) excludingEdge:ALEdgeRight];
        [self.recordImageView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionHeight ofView:self.recordImageView];
        
        [self.recordLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.recordImageView withOffset:10];
        [self.recordLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.recordImageView];
        
        [self.recordButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
        [self.recordButton autoSetDimension:ALDimensionHeight toSize:26];
        [self.recordButton autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:8];

        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (UIImageView *)recordImageView
{
    if (!_recordImageView) {
        _recordImageView = [UIImageView newAutoLayoutView];
        _recordImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _recordImageView.layer.borderWidth = 0.5;
    }
    return _recordImageView;
}

- (UILabel *)recordLabel
{
    if (!_recordLabel) {
        _recordLabel = [UILabel newAutoLayoutView];
    }
    return _recordLabel;
}

- (UIButton *)recordButton
{
    if (!_recordButton) {
        _recordButton = [UIButton newAutoLayoutView];
        _recordButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _recordButton.layer.borderWidth = kBorderWidth;
        _recordButton.layer.cornerRadius = 2;
        [_recordButton setTitleColor:kNavigationColor forState:0];
        _recordButton.titleLabel.font = font14;
    }
    return _recordButton;
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
