//
//  BorrowBaseCell.m
//  zichanbao
//
//  Created by zhixiang on 16/10/19.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import "BorrowBaseCell.h"

@implementation BorrowBaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.leftButton];
        [self.contentView addSubview:self.rightButton];
        
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints
{
    if (!self.didSetupConstraint) {
        
        [self.leftButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:kSmallPadding];
        [self.leftButton autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        [self.rightButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:kSmallPadding];
        [self.rightButton autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.leftButton];

        self.didSetupConstraint = YES;
    }
    [super updateConstraints];
}

- (UIButton *)leftButton
{
    if (!_leftButton) {
        _leftButton = [UIButton newAutoLayoutView];
        [_leftButton setTitleColor:kBlackColor forState:0];
        _leftButton.titleLabel.font = font16;
        _leftButton.userInteractionEnabled = NO;
    }
    return _leftButton;
}

- (UIButton *)rightButton
{
    if (!_rightButton) {
        _rightButton = [UIButton newAutoLayoutView];
        [_rightButton setTitleColor:kBlackColor forState:0];
        _rightButton.titleLabel.font = font16;
        _rightButton.userInteractionEnabled = NO;
    }
    return _rightButton;
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
