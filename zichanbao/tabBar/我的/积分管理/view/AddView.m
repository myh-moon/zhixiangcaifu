//
//  AddView.m
//  zichanbao
//
//  Created by zhixiang on 16/11/10.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import "AddView.h"

@implementation AddView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self addSubview:self.downButton];
        [self addSubview:self.numberLabel];
        [self addSubview:self.upButton];
        
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints
{
    if (!self.didSetupConstraint) {
        
        [self.downButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeRight];
        [self.downButton autoSetDimension:ALDimensionWidth toSize:30];
        
        [self.numberLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.downButton];
        [self.numberLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.downButton];
        [self.numberLabel autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self.downButton];
        [self.numberLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.upButton];
        
        [self.upButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeLeft];
        [self.upButton autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.downButton];
        
        self.didSetupConstraint = YES;
    }
    
    [super updateConstraints];
}

- (UIButton *)downButton
{
    if (!_downButton) {
        _downButton = [UIButton newAutoLayoutView];
        _downButton.layer.borderWidth = 1;
        _downButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [_downButton setTitle:@"-" forState:0];
        _downButton.titleLabel.font = font12;
        _downButton.tag = 20;
        
        NSInteger number = [self.numberLabel.text intValue];
        if (number >= 2) {
            [_downButton setTitleColor:[UIColor blackColor] forState:0];
        }else{
            [_downButton setTitleColor:[UIColor lightGrayColor] forState:0];
        }
        
        ZXWeakSelf;
        [_downButton addAction:^(UIButton *btn) {
            
            NSInteger beforeNum = [weakself.numberLabel.text intValue];
            if (beforeNum >=2 ) {
                beforeNum--;
                
                if (beforeNum > 1) {
                    [btn setTitleColor:[UIColor blackColor] forState:0];
                }else{
                    [btn setTitleColor:[UIColor lightGrayColor] forState:0];
                }
            }
            
            NSInteger afterNum = beforeNum;
            weakself.numberLabel.text = [NSString stringWithFormat:@"%li",(long)afterNum];
            
            if (weakself.didSelected) {
                weakself.didSelected(20);
            }
        }];
    }
    return _downButton;
}

- (UILabel *)numberLabel
{
    if (!_numberLabel) {
        _numberLabel = [UILabel newAutoLayoutView];
        _numberLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _numberLabel.layer.borderWidth = 1;
        _numberLabel.text = @"1";
        _numberLabel.textColor = [UIColor blackColor];
        _numberLabel.font = font12;
        _numberLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _numberLabel;
}

- (UIButton *)upButton
{
    if (!_upButton) {
        _upButton = [UIButton newAutoLayoutView];
        _upButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _upButton.layer.borderWidth = 1;
        [_upButton setTitle:@"+" forState:0];
        [_upButton setTitleColor:[UIColor blackColor] forState:0];
        _upButton.titleLabel.font = font12;
        _upButton.tag = 21;
       
        ZXWeakSelf;
        [_upButton addAction:^(UIButton *btn) {
            NSInteger beforeNum = [weakself.numberLabel.text intValue];
            beforeNum++;
            
            if (beforeNum >= 2) {
                [weakself.downButton setTitleColor:[UIColor blackColor] forState:0];
            }
            
            NSInteger afterNum = beforeNum;
            weakself.numberLabel.text = [NSString stringWithFormat:@"%li",(long)afterNum];
            
            if (weakself.didSelected) {
                weakself.didSelected(21);
            }
        }];
    }
    return _upButton;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
