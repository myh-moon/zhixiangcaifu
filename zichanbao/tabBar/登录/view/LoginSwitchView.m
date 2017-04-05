//
//  LoginSwitchView.m
//  zichanbao
//
//  Created by zhixiang on 16/12/22.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import "LoginSwitchView.h"

@implementation LoginSwitchView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.firstButton];
        [self addSubview:self.secondButton];
        [self addSubview:self.lineLabel];
        
        self.leftLineConstraints = [self.lineLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
        
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        
        [self.firstButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeRight];
        [self.firstButton autoSetDimension:ALDimensionWidth toSize:kScreenWidth/2];
        
        [self.secondButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeLeft];
        [self.secondButton autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.firstButton];
        
        [self.lineLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.firstButton];
        [self.lineLabel autoSetDimensionsToSize:CGSizeMake(kScreenWidth/2, 3)];
        [self.lineLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (UIButton *)firstButton
{
    if (!_firstButton ) {
        _firstButton = [UIButton newAutoLayoutView];
        [_firstButton setTitleColor:[UIColor whiteColor] forState:0];
        _firstButton.titleLabel.font = font14;
        _firstButton.tag = 111;
        
        ZXWeakSelf;
        [_firstButton addAction:^(UIButton *btn) {
            weakself.leftLineConstraints.constant = 0;
            if (weakself.didSelectedButton) {
                weakself.didSelectedButton(btn);
            }
        }];
    }
    return _firstButton;
}

- (UIButton *)secondButton
{
    if (!_secondButton) {
        _secondButton = [UIButton newAutoLayoutView];
        [_secondButton setTitleColor:[UIColor whiteColor] forState:0];
        _secondButton.titleLabel.font = font14;
        _secondButton.tag = 112;
        
        ZXWeakSelf;
        [_secondButton addAction:^(UIButton *btn) {
            weakself.leftLineConstraints.constant = kScreenWidth/2;
            if (weakself.didSelectedButton) {
                weakself.didSelectedButton(btn);
            }
        }];
    }
    return _secondButton;
}

- (UILabel *)lineLabel
{
    if (!_lineLabel) {
        _lineLabel = [UILabel newAutoLayoutView];
        [_lineLabel setBackgroundColor:kNavigationColor];
    }
    return _lineLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
