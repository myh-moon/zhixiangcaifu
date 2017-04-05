//
//  PayAddressCell.m
//  zichanbao
//
//  Created by zhixiang on 16/11/10.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import "PayAddressCell.h"

@implementation PayAddressCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.addressImageView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.phoneLabel];
        [self.contentView addSubview:self.addressButton];
        [self.contentView addSubview:self.actImageView];
        [self.contentView addSubview:self.ideaLabel];
        [self.contentView addSubview:self.bottomImageView];

        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        
        [self.addressImageView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [self.addressImageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:kSmallPadding];
        
        [self.nameLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:40];
        [self.nameLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.addressButton withOffset:-6];
        
        [self.phoneLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.actImageView withOffset:-4];
        [self.phoneLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.nameLabel];
        
        [self.addressButton autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.nameLabel];
        [self.addressButton autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.phoneLabel];
        [self.addressButton autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.addressImageView];
        
        [self.actImageView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
        [self.actImageView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [self.actImageView autoSetDimensionsToSize:CGSizeMake(15, 15)];
        
        [self.ideaLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.nameLabel];
        [self.ideaLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.addressButton withOffset:kSmallSpace];
        
        [self.bottomImageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (UIImageView *)addressImageView
{
    if (!_addressImageView) {
        _addressImageView = [UIImageView newAutoLayoutView];
    }
    return _addressImageView;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [UILabel newAutoLayoutView];
        _nameLabel.font = font14;
        _nameLabel.textColor = [UIColor blackColor];
    }
    return _nameLabel;
}

- (UILabel *)phoneLabel
{
    if (!_phoneLabel) {
        _phoneLabel = [UILabel newAutoLayoutView];
        _phoneLabel.font = font12;
        _phoneLabel.textColor = [UIColor grayColor];
    }
    return _phoneLabel;
}

- (UIButton *)addressButton
{
    if (!_addressButton) {
        _addressButton = [UIButton newAutoLayoutView];
        [_addressButton setTitleColor:[UIColor blackColor] forState:0];
        _addressButton.titleLabel.font = font12;
        [_addressButton setContentHorizontalAlignment:1];
        _addressButton.titleLabel.numberOfLines = 0;
    }
    return _addressButton;
}

- (UIImageView *)actImageView
{
    if (!_actImageView) {
        _actImageView = [UIImageView newAutoLayoutView];
        [_actImageView setImage:[UIImage imageNamed:@"list_more"]];
    }
    return _actImageView;
}

- (UILabel *)ideaLabel
{
    if (!_ideaLabel) {
        _ideaLabel = [UILabel newAutoLayoutView];
        _ideaLabel.font = font12;
        [_ideaLabel setTextColor:kYellowColor];
    }
    return _ideaLabel;
}

- (UIImageView *)bottomImageView
{
    if (!_bottomImageView) {
        _bottomImageView = [UIImageView newAutoLayoutView];
        [_bottomImageView setImage:[UIImage imageNamed:@"querenddbgcaise"]];
    }
    return _bottomImageView;
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
