//
//  PayCell.m
//  zichanbao
//
//  Created by zhixiang on 16/11/9.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import "PayCell.h"

@implementation PayCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.payLabel1];
        [self.contentView addSubview:self.payLabel2];
        [self.contentView addSubview:self.payLabel3];

        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        
        [self.payLabel1 autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:kSmallPadding];
        [self.payLabel1 autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        [self.payLabel2 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.payLabel1];
        [self.payLabel2 autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.payLabel1];
        [self.payLabel2 autoSetDimension:ALDimensionWidth toSize:80];
        [self.payLabel2 autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5];
        [self.payLabel2 autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:5];

        [self.payLabel3 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.payLabel2];
        [self.payLabel3 autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.payLabel2];
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (UILabel *)payLabel1
{
    if (!_payLabel1) {
        _payLabel1 = [UILabel newAutoLayoutView];
        _payLabel1.textColor = [UIColor blackColor];
        _payLabel1.font = font14;
    }
    return _payLabel1;
}

- (UILabel *)payLabel2
{
    if (!_payLabel2) {
        _payLabel2 = [UILabel newAutoLayoutView];
        _payLabel2.textColor = [UIColor lightGrayColor];
        _payLabel2.font = font14;
        _payLabel2.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _payLabel2.layer.borderWidth = kBorderWidth;
        _payLabel2.textAlignment = NSTextAlignmentCenter;
    }
    return _payLabel2;
}

- (UILabel *)payLabel3
{
    if (!_payLabel3) {
        _payLabel3 = [UILabel newAutoLayoutView];
        _payLabel3.textColor = [UIColor lightGrayColor];
        _payLabel3.font = font14;
    }
    return _payLabel3;
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
