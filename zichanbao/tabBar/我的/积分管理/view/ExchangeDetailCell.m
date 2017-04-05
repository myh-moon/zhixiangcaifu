//
//  ExchangeDetailCell.m
//  zichanbao
//
//  Created by zhixiang on 16/11/9.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import "ExchangeDetailCell.h"

@implementation ExchangeDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.exchangeLabel1];
        [self.contentView addSubview:self.exchangeButton];
        [self.contentView addSubview:self.exchangeLabel2];
        
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        
        [self.exchangeLabel1 autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:kSmallPadding];
        [self.exchangeLabel1 autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
        [self.exchangeLabel1 autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:kSmallPadding];
        
        [self.exchangeButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.exchangeLabel1 withOffset:6];
        [self.exchangeButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:kSmallPadding];
        
        [self.exchangeLabel2 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.exchangeButton withOffset:6];
        [self.exchangeLabel2 autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:kSmallPadding];
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (UILabel *)exchangeLabel1
{
    if (!_exchangeLabel1) {
        _exchangeLabel1 = [UILabel newAutoLayoutView];
        _exchangeLabel1.textColor = [UIColor grayColor];
        _exchangeLabel1.font = font14;
    }
    return _exchangeLabel1;
}

- (UIButton *)exchangeButton
{
    if (!_exchangeButton) {
        _exchangeButton = [UIButton newAutoLayoutView];
        [_exchangeButton setTitleColor:[UIColor grayColor] forState:0];
    }
    return _exchangeButton;
}

- (UILabel *)exchangeLabel2
{
    if (!_exchangeLabel2) {
        _exchangeLabel2 = [UILabel newAutoLayoutView];
        _exchangeLabel2.textColor = [UIColor grayColor];
        _exchangeLabel2.font = font14;
        _exchangeLabel2.numberOfLines = 0;
    }
    return _exchangeLabel2;
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
