//
//  StepView.m
//  zichanbao
//
//  Created by zhixiang on 17/2/15.
//  Copyright © 2017年 zhixiang. All rights reserved.
//

#import "StepView.h"

@implementation StepView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = NO;
        
        [self addSubview:self.stepButton1];
        [self addSubview:self.stepLine1];
        [self addSubview:self.stepButton2];
        [self addSubview:self.stepLine2];
        [self addSubview:self.stepButton3];
        [self addSubview:self.stepLine3];
        [self addSubview:self.stepButton4];
        [self addSubview:self.stepLabel1];
        [self addSubview:self.stepLabel2];
        [self addSubview:self.stepLabel3];
        [self addSubview:self.stepLabel4];

        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints
{
    if (!self.didSetupConstraints) {

        NSArray *views1 = @[self.stepButton1,self.stepButton2,self.stepButton3,self.stepButton4];
        [views1 autoSetViewsDimensionsToSize:CGSizeMake(32, 32)];
        
        NSArray *views2 = @[self.stepLine1,self.stepLine2,self.stepLine3];
        [views2 autoSetViewsDimension:ALDimensionWidth toSize:(kScreenWidth-25*2-32*4)/3];
        [views2 autoSetViewsDimension:ALDimensionHeight toSize:3];
        
        [self.stepButton1 autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:25];
        [self.stepButton1 autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.stepLabel1 withOffset:-10];
        
        [self.stepLine1 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.stepButton1];
        [self.stepLine1 autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.stepButton1];
        
        [self.stepButton2 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.stepLine1];
        [self.stepButton2 autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.stepLine1];
        
        [self.stepLine2 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.stepButton2];
        [self.stepLine2 autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.stepButton2];
        
        [self.stepButton3 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.stepLine2];
        [self.stepButton3 autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.stepLine2];
        
        [self.stepLine3 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.stepButton3];
        [self.stepLine3 autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.stepButton3];
        
        [self.stepButton4 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.stepLine3];
        [self.stepButton4 autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.stepLine3];
        
        [self.stepLabel1 autoAlignAxis:ALAxisVertical toSameAxisOfView:self.stepButton1];
        [self.stepLabel1 autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:30];
        
        [self.stepLabel2 autoAlignAxis:ALAxisVertical toSameAxisOfView:self.stepButton2];
        [self.stepLabel2 autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.stepLabel1];
        
        [self.stepLabel3 autoAlignAxis:ALAxisVertical toSameAxisOfView:self.stepButton3];
        [self.stepLabel3 autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.stepLabel2];

        [self.stepLabel4 autoAlignAxis:ALAxisVertical toSameAxisOfView:self.stepButton4];
        [self.stepLabel4 autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.stepLabel3];

        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (UIButton *)stepButton1
{
    if (!_stepButton1) {
        _stepButton1 = [UIButton newAutoLayoutView];
        _stepButton1.layer.cornerRadius = 16;
        [_stepButton1 setTitle:@"1" forState:0];
        [_stepButton1 setTitleColor:kNavigationColor forState:0];
        _stepButton1.titleLabel.font = font14;
        _stepButton1.backgroundColor = kWhiteColor;
    }
    return _stepButton1;
}

- (UIButton *)stepButton2
{
    if (!_stepButton2) {
        _stepButton2 = [UIButton newAutoLayoutView];
        _stepButton2.layer.cornerRadius = 16;
        [_stepButton2 setTitle:@"2" forState:0];
        [_stepButton2 setTitleColor:kNavigationColor forState:0];
        _stepButton2.titleLabel.font = font14;
        _stepButton2.backgroundColor = kWhiteColor1;
    }
    return _stepButton2;
}

- (UIButton *)stepButton3
{
    if (!_stepButton3) {
        _stepButton3 = [UIButton newAutoLayoutView];
        _stepButton3.layer.cornerRadius = 16;
        [_stepButton3 setTitle:@"3" forState:0];
        [_stepButton3 setTitleColor:kNavigationColor forState:0];
        _stepButton3.titleLabel.font = font14;
        _stepButton3.backgroundColor = kWhiteColor1;
    }
    return _stepButton3;
}

- (UIButton *)stepButton4
{
    if (!_stepButton4) {
        _stepButton4 = [UIButton newAutoLayoutView];
        _stepButton4.layer.cornerRadius = 16;
        [_stepButton4 setTitle:@"4" forState:0];
        [_stepButton4 setTitleColor:kNavigationColor forState:0];
        _stepButton4.titleLabel.font = font14;
        _stepButton4.backgroundColor = kWhiteColor1;
    }
    return _stepButton4;
}

- (UILabel *)stepLine1
{
    if (!_stepLine1) {
        _stepLine1 = [UILabel newAutoLayoutView];
        [_stepLine1 setBackgroundColor:kWhiteColor1];
    }
    return _stepLine1;
}

- (UILabel *)stepLine2
{
    if (!_stepLine2) {
        _stepLine2 = [UILabel newAutoLayoutView];
        [_stepLine2 setBackgroundColor:kWhiteColor1];
    }
    return _stepLine2;
}

- (UILabel *)stepLine3
{
    if (!_stepLine3) {
        _stepLine3 = [UILabel newAutoLayoutView];
        [_stepLine3 setBackgroundColor:kWhiteColor1];
    }
    return _stepLine3;
}

- (UILabel *)stepLabel1
{
    if (!_stepLabel1) {
        _stepLabel1 = [UILabel newAutoLayoutView];
        _stepLabel1.font = font14;
        _stepLabel1.textColor = kWhiteColor;
        _stepLabel1.text = @"基本信息";
    }
    return _stepLabel1;
}

- (UILabel *)stepLabel2
{
    if (!_stepLabel2) {
        _stepLabel2 = [UILabel newAutoLayoutView];
        _stepLabel2.font = font14;
        _stepLabel2.textColor = kWhiteColor1;
        _stepLabel2.text = @"手机信息";
    }
    return _stepLabel2;
}

- (UILabel *)stepLabel3
{
    if (!_stepLabel3) {
        _stepLabel3 = [UILabel newAutoLayoutView];
        _stepLabel3.font = font14;
        _stepLabel3.textColor = kWhiteColor1;
        _stepLabel3.text = @"信用信息";
    }
    return _stepLabel3;
}

- (UILabel *)stepLabel4
{
    if (!_stepLabel4) {
        _stepLabel4 = [UILabel newAutoLayoutView];
        _stepLabel4.font = font14;
        _stepLabel4.textColor = kWhiteColor1;
        _stepLabel4.text = @"数据采集";
    }
    return _stepLabel4;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
