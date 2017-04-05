//
//  EstimateTwoCell.m
//  zichanbao
//
//  Created by zhixiang on 16/12/27.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import "EstimateTwoCell.h"

@implementation EstimateTwoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.etButton2];
        [self.contentView addSubview:self.etButton3];
        
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        
        NSArray *views = @[self.etButton2,self.etButton3];
        [views autoSetViewsDimension:ALDimensionWidth toSize:60];
        [views autoSetViewsDimension:ALDimensionHeight toSize:26];
        
        [self.etButton2 autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.etButton3 withOffset:-10];
        [self.etButton2 autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        [self.etButton3 autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
        [self.etButton3 autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.etButton2];
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (UIButton *)etButton2
{
    if (!_etButton2) {
        _etButton2 = [UIButton newAutoLayoutView];
        [_etButton2 setBackgroundColor:kNavigationColor];
        _etButton2.layer.cornerRadius = 2;
        [_etButton2 setTitleColor:[UIColor whiteColor] forState:0];
        _etButton2.titleLabel.font = font14;
    }
    return _etButton2;
}

- (UIButton *)etButton3
{
    if (!_etButton3) {
        _etButton3 = [UIButton newAutoLayoutView];
        [_etButton3 setBackgroundColor:kNavigationColor];
        _etButton3.layer.cornerRadius = 2;
        [_etButton3 setTitleColor:[UIColor whiteColor] forState:0];
        _etButton3.titleLabel.font = font14;
    }
    return _etButton3;
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
