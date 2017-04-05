//
//  PlanCell.m
//  zichanbao
//
//  Created by zhixiang on 15/10/15.
//  Copyright (c) 2015年 zhixiang. All rights reserved.
//

#import "PlanCell.h"

@implementation PlanCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
   self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    
        [self.contentView addSubview:self.whiteView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.lineLabel1];
        [self.contentView addSubview:self.dateLabel];
        [self.contentView addSubview:self.moneyLabel];
        [self.contentView addSubview:self.rateLabel];
        
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        
        [self.whiteView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 10, 10, 10)];
        
        [self.nameLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:kSpacePadding];
        [self.nameLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
        
        [self.lineLabel1 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.nameLabel withOffset:10];
        [self.lineLabel1 autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.whiteView];
        [self.lineLabel1 autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.whiteView];
        [self.lineLabel1 autoSetDimension:ALDimensionHeight toSize:1];
        
        [self.dateLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.nameLabel];
        [self.dateLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.lineLabel1 withOffset:10];
        [self.dateLabel autoSetDimension:ALDimensionWidth toSize:50];

        [self.moneyLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.dateLabel];
        [self.moneyLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.dateLabel withOffset:10];
        [self.moneyLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.rateLabel withOffset:-10];
        
        [self.rateLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.moneyLabel];
        [self.rateLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.whiteView withOffset:-10];
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

-(UIView *)whiteView
{
    if (!_whiteView) {
        _whiteView = [UIView newAutoLayoutView];
        _whiteView.backgroundColor = [UIColor whiteColor];
    }
    return _whiteView;
}

-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [UILabel newAutoLayoutView];
//        _nameLabel.text = @"直e贷－20151015002计划";
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.font = font14;
    }
    return _nameLabel;
}

-(UILabel *)lineLabel1
{
    if (!_lineLabel1) {
        _lineLabel1 = [UILabel newAutoLayoutView];
        _lineLabel1.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineLabel1;
}

-(UILabel *)dateLabel
{
    if (!_dateLabel) {
        _dateLabel = [UILabel newAutoLayoutView];
        _dateLabel.textColor = [UIColor blackColor];
        _dateLabel.font = font14;
//        _dateLabel.text = @"10月12日";
    }
    return _dateLabel;
}

-(UILabel *)moneyLabel
{
    if (!_moneyLabel) {
        _moneyLabel = [UILabel newAutoLayoutView];
        _moneyLabel.textColor = [UIColor blackColor];
        _moneyLabel.font = font14;
        _moneyLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _moneyLabel;
}

-(UILabel *)rateLabel
{
    if (!_rateLabel) {
        _rateLabel = [UILabel newAutoLayoutView];
        _rateLabel.textColor = [UIColor blackColor];
//        _rateLabel.text = @"利息 ：2.34元";
        _rateLabel.font = font14;
    }
    return _rateLabel;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
