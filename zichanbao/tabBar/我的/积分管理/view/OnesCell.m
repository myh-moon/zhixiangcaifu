//
//  OnesCell.m
//  zichanbao
//
//  Created by zhixiang on 16/12/20.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import "OnesCell.h"

@implementation OnesCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.oneButton];
        
        [self setNeedsUpdateConstraints];
    }
    
    return self;
}

- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        
        [self.oneButton autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [self.oneButton autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (UIButton *)oneButton
{
    if (!_oneButton) {
        _oneButton = [UIButton newAutoLayoutView];
        _oneButton.titleLabel.font = font12;
        [_oneButton setTitleColor:kNavigationColor forState:0];
    }
    return _oneButton;
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
