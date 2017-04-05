//
//  CreditListView.m
//  zichanbao
//
//  Created by zhixiang on 17/2/16.
//  Copyright © 2017年 zhixiang. All rights reserved.
//

#import "CreditListView.h"
#import "UIButton+Addition.h"

@implementation CreditListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.borderColor = kLightGrayColor.CGColor;
        self.layer.borderWidth = kBorderWidth;
        
        [self addSubview:self.creditButton];
        [self addSubview:self.creditNameButton];
        [self addSubview:self.creditSearchButton];
        
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        
        [self.creditButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeRight];
        [self.creditButton autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.creditNameButton];
        
        [self.creditNameButton autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.creditButton];
        [self.creditNameButton autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5];
        [self.creditNameButton autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:5];
        
        [self.creditSearchButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:5];
        [self.creditSearchButton autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.creditNameButton];
        [self.creditSearchButton autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.creditNameButton withOffset:15];
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (UIButton *)creditButton
{
    if (!_creditButton) {
        _creditButton = [UIButton newAutoLayoutView];
        [_creditButton swapImage];
        [_creditButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [_creditButton setImageEdgeInsets:UIEdgeInsetsMake(0, 7, 0, 7)];
        [_creditButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 14, 0, 0)];
        [_creditButton setImage:[UIImage imageNamed:@"xialas"] forState:0];
        [_creditButton setTitle:@"姓名" forState:0];
        [_creditButton setTitleColor:kBlackColor forState:0];
        _creditButton.titleLabel.font = font14;
        
        ZXWeakSelf;
        [_creditButton addAction:^(UIButton *btn) {
            if (weakself.didSelectedBtn) {
                weakself.didSelectedBtn(44);
            }
        }];
    }
    return _creditButton;
}

- (UIButton *)creditNameButton
{
    if (!_creditNameButton) {
        _creditNameButton = [UIButton newAutoLayoutView];
        _creditNameButton.backgroundColor = kBackgroundColor;
        [_creditNameButton setTitle:@"  请按查询方式输入匹配  " forState:0];
        [_creditNameButton setTitleColor:kGrayColor forState:0];
        _creditNameButton.titleLabel.font = font14;
        
        ZXWeakSelf;
        [_creditNameButton addAction:^(UIButton *btn) {
            if (weakself.didSelectedBtn) {
                weakself.didSelectedBtn(45);
            }
        }];
    }
    return _creditNameButton;
}

- (UIButton *)creditSearchButton
{
    if (!_creditSearchButton) {
        _creditSearchButton = [UIButton newAutoLayoutView];
        [_creditSearchButton setBackgroundColor:kNavigationColor];
        [_creditSearchButton setTitle:@"    搜索    " forState:0];
        [_creditSearchButton setTitleColor:kWhiteColor forState:0];
        _creditSearchButton.titleLabel.font = font14;
        
        ZXWeakSelf;
        [_creditSearchButton addAction:^(UIButton *btn) {
            if (weakself.didSelectedBtn) {
                weakself.didSelectedBtn(46);
            }
        }];
    }
    return _creditSearchButton;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
