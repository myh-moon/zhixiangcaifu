//
//  ChannelCalendarView.m
//  zichanbao
//
//  Created by zhixiang on 16/12/26.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import "ChannelCalendarView.h"


@implementation ChannelCalendarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.fromDateButton];
        [self addSubview:self.daoLabel];
        [self addSubview:self.toDateButton];
        [self addSubview:self.dateSearchButton];
        [self addSubview:self.fromImageView];
        [self addSubview:self.toImageView];
        
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        
        [self.fromDateButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(3, kSmallSpace, 3, 0) excludingEdge:ALEdgeRight];
        [self.fromDateButton autoSetDimension:ALDimensionWidth toSize:(kScreenWidth-100)/2];
        
        [self.fromImageView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.fromDateButton withOffset:-2];
        [self.fromImageView autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.fromDateButton];
        
        [self.daoLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.fromDateButton withOffset:kSmallSpace];
        [self.daoLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.fromDateButton];
        
        [self.toDateButton autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.daoLabel withOffset:kSmallSpace];
        [self.toDateButton autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self.fromDateButton];
        [self.toDateButton autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.fromDateButton];
        [self.toDateButton autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.fromDateButton];
        
        [self.toImageView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.toDateButton withOffset:-2];
        [self.toImageView autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.toDateButton];
        
        [self.dateSearchButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:kSmallSpace];
        [self.dateSearchButton autoSetDimension:ALDimensionWidth toSize:50];
        [self.dateSearchButton autoSetDimension:ALDimensionHeight toSize:20];
        [self.dateSearchButton autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (UIButton *)fromDateButton
{
    if (!_fromDateButton) {
        _fromDateButton = [UIButton newAutoLayoutView];
        [_fromDateButton setBackgroundColor:RGBCOLOR(0.9373, 0.9373, 0.9647)];
        [_fromDateButton setTitleColor:kBlackColor forState:0];
        _fromDateButton.titleLabel.font = font12;
        _fromDateButton.tag = 211;
        
        ZXWeakSelf;
        [_fromDateButton addAction:^(UIButton *btn) {
            if (weakself.didSelectedBtn) {
                weakself.didSelectedBtn(btn);
            }
        }];
    }
    return _fromDateButton;
}

- (UIImageView *)fromImageView
{
    if (!_fromImageView) {
        _fromImageView = [UIImageView newAutoLayoutView];
        [_fromImageView setImage:[UIImage imageNamed:@"rili"]];
    }
    return _fromImageView;
}

- (UILabel *)daoLabel
{
    if (!_daoLabel) {
        _daoLabel = [UILabel newAutoLayoutView];
        _daoLabel.text = @"到";
        _daoLabel.textColor = kBlackColor;
        _daoLabel.font = font12;
    }
    return _daoLabel;
}

- (UIButton *)toDateButton
{
    if (!_toDateButton) {
        _toDateButton = [UIButton newAutoLayoutView];
        [_toDateButton setBackgroundColor:RGBCOLOR(0.9373, 0.9373, 0.9647)];
        [_toDateButton setTitleColor:kBlackColor forState:0];
        _toDateButton.titleLabel.font = font12;
        _toDateButton.tag = 212;
        
        ZXWeakSelf;
        [_toDateButton addAction:^(UIButton *btn) {
            if (weakself.didSelectedBtn) {
                weakself.didSelectedBtn(btn);
            }
        }];
    }
    return _toDateButton;
}

- (UIImageView *)toImageView
{
    if (!_toImageView) {
        _toImageView = [UIImageView newAutoLayoutView];
        [_toImageView setImage:[UIImage imageNamed:@"rili"]];
    }
    return _toImageView;
}

- (UIButton *)dateSearchButton
{
    if (!_dateSearchButton) {
        _dateSearchButton = [UIButton newAutoLayoutView];
        _dateSearchButton.backgroundColor = kNavigationColor;
        [_dateSearchButton setTitleColor:[UIColor whiteColor] forState:0];
        [_dateSearchButton setTitle:@"搜索" forState:0];
        _dateSearchButton.titleLabel.font = font12;
        _dateSearchButton.tag = 213;
        
        ZXWeakSelf;
        [_dateSearchButton addAction:^(UIButton *btn) {
            if (weakself.didSelectedBtn) {
                weakself.didSelectedBtn(btn);
            }
        }];
    }
    return _dateSearchButton;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
