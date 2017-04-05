//
//  RemindNoButton.m
//  zichanbao
//
//  Created by zhixiang on 17/1/5.
//  Copyright © 2017年 zhixiang. All rights reserved.
//

#import "RemindNoButton.h"

@implementation RemindNoButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.noImageButton];
        [self addSubview:self.noTextButton];
        
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        
        [self.noImageButton autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [self.noImageButton autoAlignAxisToSuperviewAxis:ALAxisVertical];
        
        [self.noTextButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.noImageButton withOffset:20];
        [self.noTextButton autoAlignAxisToSuperviewAxis:ALAxisVertical];
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (UIButton *)noImageButton
{
    if (!_noImageButton) {
        _noImageButton = [UIButton newAutoLayoutView];
        _noImageButton.userInteractionEnabled = NO;
    }
    return _noImageButton;
}

- (UIButton *)noTextButton
{
    if (!_noTextButton) {
        _noTextButton = [UIButton newAutoLayoutView];
        [_noTextButton setTitleColor:kNavigationColor forState:0];
        _noTextButton.titleLabel.font = font14;
        _noTextButton.userInteractionEnabled = NO;
    }
    return _noTextButton;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
