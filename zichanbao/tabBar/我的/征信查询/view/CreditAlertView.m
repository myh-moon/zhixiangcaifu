//
//  CreditAlertView.m
//  zichanbao
//
//  Created by zhixiang on 17/2/17.
//  Copyright © 2017年 zhixiang. All rights reserved.
//

#import "CreditAlertView.h"

@implementation CreditAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleButton];
        
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints
{
    if (!self.didSetupConstraints){
        [self.titleButton autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:kScreenHeight/4];
        [self.titleButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:kBigPadding];
        [self.titleButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:kBigPadding];
        [self.titleButton autoSetDimension:ALDimensionHeight toSize:300];
        
        [self.cancelButton autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.titleButton withOffset:-kSmallPadding];
        [self.cancelButton autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.titleButton withOffset:kSmallPadding];
        
        [self.actButton1 autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.titleButton withOffset:kSmallPadding];
        [self.actButton1 autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.titleButton withOffset:-kSmallPadding];
        [self.actButton1 autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.titleButton withOffset:kSmallPadding*3];
        
        [self.actButton2 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.actButton1 withOffset:kSmallPadding];
        [self.actButton2 autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.actButton1];
        [self.actButton2 autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.actButton1];
        
        [self.actButton3 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.actButton2 withOffset:kSmallPadding];
        [self.actButton3 autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.actButton2];
        [self.actButton3 autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.actButton2];
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (UIButton *)titleButton
{
    if (!_titleButton) {
        _titleButton = [UIButton newAutoLayoutView];
        [_titleButton setTitleColor:kBlackColor forState:0];
        _titleButton.titleLabel.font = font16;
        _titleButton.contentVerticalAlignment = 1;
        [_titleButton setContentEdgeInsets:UIEdgeInsetsMake(kSmallPadding, 0, 0, 0)];
        _titleButton.layer.cornerRadius = 10;
        
        [_titleButton addSubview:self.cancelButton];
        [_titleButton addSubview:self.actButton1];
        [_titleButton addSubview:self.actButton2];
        [_titleButton addSubview:self.actButton3];
    }
    return _titleButton;
}

- (UIButton *)cancelButton
{
    if (!_cancelButton) {
        _cancelButton = [UIButton newAutoLayoutView];
        [_cancelButton setImage:[UIImage imageNamed:@"chaa"] forState:0];
        ZXWeakSelf;
        [_cancelButton addAction:^(UIButton *btn) {
            if (weakself.didSelectedBtn) {
                weakself.didSelectedBtn(88);
            }
        }];
    }
    return _cancelButton;
}

- (UIButton *)actButton1
{
    if (!_actButton1) {
        _actButton1 = [UIButton newAutoLayoutView];
        ZXWeakSelf;
        [_actButton1 addAction:^(UIButton *btn) {
            if (weakself.didSelectedBtn) {
                weakself.didSelectedBtn(89);
            }
        }];
    }
    return _actButton1;
}

- (UIButton *)actButton2
{
    if (!_actButton2) {
        _actButton2 = [UIButton newAutoLayoutView];
        ZXWeakSelf;
        [_actButton2 addAction:^(UIButton *btn) {
            if (weakself.didSelectedBtn) {
                weakself.didSelectedBtn(90);
            }
        }];
    }
    return _actButton2;
}

- (UIButton *)actButton3
{
    if (!_actButton3) {
        _actButton3 = [UIButton newAutoLayoutView];
        ZXWeakSelf;
        [_actButton3 addAction:^(UIButton *btn) {
            if (weakself.didSelectedBtn) {
                weakself.didSelectedBtn(91);
            }
        }];
    }
    return _actButton3;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
