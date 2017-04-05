//
//  WithdraCell.m
//  zichanbao
//
//  Created by zhixiang on 16/9/8.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import "WithdraCell.h"

@implementation WithdraCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.whiteView];
        [self.contentView addSubview:self.cardButton];
        [self.contentView addSubview:self.moneyLabel1];
        [self.contentView addSubview:self.moneyLabel2];
        [self.contentView addSubview:self.moneyTextField];
        [self.contentView addSubview:self.lineLabel];
        [self.contentView addSubview:self.allMoneyButton];
        
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        
        [self.whiteView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(kBigPadding, kBigPadding, 0, kBigPadding) excludingEdge:ALEdgeBottom];
        [self.whiteView autoSetDimension:ALDimensionHeight toSize:185];
        
        [self.cardButton autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.whiteView];
        [self.cardButton autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.whiteView];
        [self.cardButton autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.whiteView];
        [self.cardButton autoSetDimension:ALDimensionHeight toSize:50];
        
        [self.moneyLabel1 autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.whiteView];
        [self.moneyLabel1 autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.whiteView];
        [self.moneyLabel1 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.cardButton];
        [self.moneyLabel1 autoSetDimension:ALDimensionHeight toSize:60];
        
        [self.moneyLabel2 autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.whiteView];
        [self.moneyLabel2 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.moneyLabel1];
        [self.moneyLabel2 autoSetDimension:ALDimensionWidth toSize:50];
        
        [self.moneyTextField autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.moneyLabel2 ];
        [self.moneyTextField autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.moneyLabel2];
        [self.moneyTextField autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.whiteView];
        //        [self.moneyTextField autoSetDimension:ALDimensionHeight toSize:40];
        
        [self.lineLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.moneyLabel2 withOffset:kBigPadding];
        [self.lineLabel autoSetDimension:ALDimensionHeight toSize:1];
        [self.lineLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.whiteView withOffset:15];
        [self.lineLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.whiteView withOffset:-15];
        
        [self.allMoneyButton autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.whiteView];
        [self.allMoneyButton autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.whiteView];
        [self.allMoneyButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.lineLabel];
        [self.allMoneyButton autoSetDimension:ALDimensionHeight toSize:40];
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (UIView *)whiteView
{
    if (!_whiteView) {
        _whiteView = [UIView newAutoLayoutView];
        _whiteView.backgroundColor = [UIColor whiteColor];
        _whiteView.layer.cornerRadius = 5;
        _whiteView.layer.cornerRadius = 2;
    }
    return _whiteView;
}

- (UIButton *)cardButton
{
    if (!_cardButton) {
        _cardButton = [UIButton newAutoLayoutView];
        _cardButton.titleLabel.font = font14;
        [_cardButton setTitleColor:[UIColor blackColor] forState:0];
        _cardButton.backgroundColor = [UIColor whiteColor];
        _cardButton.contentHorizontalAlignment = 1;
    }
    return _cardButton;
}

- (UILabel *)moneyLabel1
{
    if (!_moneyLabel1) {
        _moneyLabel1 = [UILabel newAutoLayoutView];
        _moneyLabel1.text = @"    金额(元)";
        _moneyLabel1.font = font14;
        _moneyLabel1.textColor = [UIColor blackColor];
        _moneyLabel1.backgroundColor = [UIColor whiteColor];
    }
    return _moneyLabel1;
}

- (UILabel *)moneyLabel2
{
    if (!_moneyLabel2) {
        _moneyLabel2 = [UILabel newAutoLayoutView];
        _moneyLabel2.text = @"    ¥";
        _moneyLabel2.font = [UIFont systemFontOfSize:20];
        _moneyLabel2.backgroundColor = [UIColor whiteColor];
    }
    return _moneyLabel2;
}

- (UITextField *)moneyTextField
{
    if (!_moneyTextField) {
        _moneyTextField = [UITextField newAutoLayoutView];
        _moneyTextField.font = [UIFont systemFontOfSize:20];
        _moneyTextField.textColor = [UIColor blackColor];
        _moneyTextField.backgroundColor = [UIColor whiteColor];
        _moneyTextField.delegate = self;
    }
    return _moneyTextField;
}

- (UILabel *)lineLabel
{
    if (!_lineLabel) {
        _lineLabel = [UILabel newAutoLayoutView];
        _lineLabel.backgroundColor = RGBCOLOR(0.8745, 0.8745, 0.8824);
    }
    return _lineLabel;
}

- (UIButton *)allMoneyButton
{
    if (!_allMoneyButton) {
        _allMoneyButton = [UIButton newAutoLayoutView];
        _allMoneyButton.titleLabel.font = font14;
        [_allMoneyButton setTitleColor:[UIColor blackColor] forState:0];
        _allMoneyButton.backgroundColor = [UIColor whiteColor];
        _allMoneyButton.contentHorizontalAlignment = 1;
    }
    return _allMoneyButton;
}

#pragma mar- delegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.didEndEditing) {
        self.didEndEditing(textField.text);
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
