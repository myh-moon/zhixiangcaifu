//
//  ChannelCell.m
//  zichanbao
//
//  Created by zhixiang on 16/12/23.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import "ChannelCell.h"

@implementation ChannelCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
        self.contentView.backgroundColor = [UIColor whiteColor];
        
//        self.contentView.layer.contentsScale = [UIScreen mainScreen].scale;//大小
//        self.contentView.layer.shadowOpacity = 0.75f;//不透明度
//        self.contentView.layer.shadowRadius = 4.0f;
//        self.contentView.layer.shadowOffset = CGSizeMake(0,0);
//        self.contentView.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.contentView.bounds].CGPath;
//        //设置缓存
//        self.contentView.layer.shouldRasterize = YES;
//        //设置抗锯齿边缘
//        self.contentView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        
        [self.contentView addSubview:self.chTimeButton];
        [self.contentView addSubview:self.chLineLabel];
        [self.contentView addSubview:self.chTextLabel];
        
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        
        [self.chTimeButton autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:kSmallSpace];
        [self.chTimeButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
        
        [self.chLineLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.chTimeButton withOffset:kSmallSpace];
        [self.chLineLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:kSmallPadding];
        [self.chLineLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.chTimeButton];
        [self.chLineLabel autoSetDimension:ALDimensionHeight toSize:1];
        
        [self.chTextLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.chLineLabel withOffset:kSmallSpace];
        [self.chTextLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.chLineLabel];
        [self.chTextLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.chLineLabel];
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (UIButton *)chTimeButton
{
    if (!_chTimeButton) {
        _chTimeButton = [UIButton newAutoLayoutView];
        [_chTimeButton setTitleColor:kGrayColor forState:0];
        _chTimeButton.titleLabel.font = font13;
        [_chTimeButton setContentHorizontalAlignment:1];
    }
    return _chTimeButton;
}

- (UILabel *)chLineLabel
{
    if (!_chLineLabel) {
        _chLineLabel = [UILabel newAutoLayoutView];
        _chLineLabel.backgroundColor = [UIColor lightGrayColor];
    }
    return _chLineLabel;
}

- (UILabel *)chTextLabel
{
    if (!_chTextLabel) {
        _chTextLabel = [UILabel newAutoLayoutView];
        _chTextLabel.numberOfLines = 0;
        
    }
    return _chTextLabel;
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
