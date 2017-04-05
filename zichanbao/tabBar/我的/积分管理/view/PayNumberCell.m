//
//  PayNumberCell.m
//  zichanbao
//
//  Created by zhixiang on 16/11/10.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import "PayNumberCell.h"

@implementation PayNumberCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.ppButton];
        [self.contentView addSubview:self.addNumberView];
        
//        [self.contentView addSubview:self.downButton];
//        [self.contentView addSubview:self.numberLabel];
//        [self.contentView addSubview:self.upButton];
        
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        
        [self.ppButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:kSmallPadding];
        [self.ppButton autoAlignAxisToSuperviewAxis:ALAxisHorizontal];

//        [self.downButton autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.upButton];
//        [self.downButton autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self.upButton];
//        [self.downButton autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.ppButton];
//        [self.downButton autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.numberLabel];
//        
//        [self.numberLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.upButton];
//        [self.numberLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.downButton];
//        [self.numberLabel autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self.downButton];
//        [self.numberLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.upButton];
//        
//        [self.upButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(4, 0, 4, kSmallPadding) excludingEdge:ALEdgeLeft];
//        [self.upButton autoSetDimension:ALDimensionWidth toSize:30];
        
        
        [self.addNumberView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:kSmallPadding];
        [self.addNumberView autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.ppButton];
        [self.addNumberView autoSetDimension:ALDimensionHeight toSize:26];
        [self.addNumberView autoSetDimension:ALDimensionWidth toSize:100];

        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (UIButton *)ppButton
{
    if (!_ppButton) {
        _ppButton = [UIButton newAutoLayoutView];
        [_ppButton setTitleColor:[UIColor blackColor] forState:0];
        _ppButton.titleLabel.font = font14;
    }
    return _ppButton;
}

//- (UIButton *)downButton
//{
//    if (!_downButton) {
//        _downButton = [UIButton newAutoLayoutView];
//        _downButton.layer.borderWidth = 1;
//        _downButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
//        [_downButton setTitle:@"-" forState:0];
//        _downButton.titleLabel.font = font12;
//        _downButton.tag = 20;
//        
//        NSInteger number = [self.numberLabel.text intValue];
//        if (number >= 2) {
//            [_downButton setTitleColor:[UIColor blackColor] forState:0];
//        }else{
//            [_downButton setTitleColor:[UIColor lightGrayColor] forState:0];
//        }
//        
//        ZXWeakSelf;
//        [_downButton addAction:^(UIButton *btn) {
//            
//            NSInteger beforeNum = [weakself.numberLabel.text intValue];
//            if (beforeNum >=2 ) {
//                beforeNum--;
//                
//                if (beforeNum > 1) {
//                    [btn setTitleColor:[UIColor blackColor] forState:0];
//                }else{
//                    [btn setTitleColor:[UIColor lightGrayColor] forState:0];
//                }
//            }
//            
//            NSInteger afterNum = beforeNum;
//            weakself.numberLabel.text = [NSString stringWithFormat:@"%li",(long)afterNum];
//        }];
//    }
//    return _downButton;
//}
//
//- (UILabel *)numberLabel
//{
//    if (!_numberLabel) {
//        _numberLabel = [UILabel newAutoLayoutView];
//        _numberLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
//        _numberLabel.layer.borderWidth = 1;
//        _numberLabel.text = @"1";
//        _numberLabel.textColor = [UIColor blackColor];
//        _numberLabel.font = font12;
//        _numberLabel.textAlignment = NSTextAlignmentCenter;
//    }
//    return _numberLabel;
//}
//
//- (UIButton *)upButton
//{
//    if (!_upButton) {
//        _upButton = [UIButton newAutoLayoutView];
//        _upButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
//        _upButton.layer.borderWidth = 1;
//        [_upButton setTitle:@"+" forState:0];
//        [_upButton setTitleColor:[UIColor blackColor] forState:0];
//        _upButton.titleLabel.font = font12;
//        _upButton.tag = 21;
//        
//        ZXWeakSelf;
//        [_upButton addAction:^(UIButton *btn) {
//            NSInteger beforeNum = [weakself.numberLabel.text intValue];
//            beforeNum++;
//            
//            if (beforeNum >= 2) {
//                [weakself.downButton setTitleColor:[UIColor blackColor] forState:0];
//            }
//            
//            NSInteger afterNum = beforeNum;
//            weakself.numberLabel.text = [NSString stringWithFormat:@"%li",(long)afterNum];
//        }];
//    }
//    return _upButton;
//}


- (AddView *)addNumberView
{
    if (!_addNumberView) {
        _addNumberView = [AddView newAutoLayoutView];
        
        
    }
    return _addNumberView;
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
