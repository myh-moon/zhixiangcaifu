//
//  InvestCell.m
//  zichanbao
//
//  Created by zhixiang on 15/10/14.
//  Copyright (c) 2015年 zhixiang. All rights reserved.
//

#import "InvestCell.h"

#define labelH  20
#define labelW  220

@implementation InvestCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
   self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.headerLabel];
        
        [self.contentView addSubview:self.typeBtn1];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.typeBtn2];
        
        [self.contentView addSubview:self.lineLabel];
        
        [self.contentView addSubview:self.moneyLabel];
        [self.contentView addSubview:self.dateLabel];
        [self.contentView addSubview:self.ProfitLabel];
        [self.contentView addSubview:self.wayLabel];
        
        [self.contentView addSubview:self.rateLabel1];
        [self.contentView addSubview:self.rateLabel2];
        
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        
        [self.headerLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
        [self.headerLabel autoSetDimension:ALDimensionHeight toSize:10];
        
        [self.typeBtn1 autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:kSpacePadding];
        [self.typeBtn1 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.headerLabel withOffset:5];
        [self.typeBtn1 autoSetDimensionsToSize:CGSizeMake(60, labelH)];
        
        [self.nameLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.typeBtn1 withOffset:5];
        [self.nameLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.typeBtn1];
        
        [self.typeBtn2 autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:kSpacePadding];
        [self.typeBtn2 autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.nameLabel];
        [self.typeBtn2 autoSetDimension:ALDimensionHeight toSize:20];
        
        [self.lineLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [self.lineLabel autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [self.lineLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.typeBtn1 withOffset:5];
        [self.lineLabel autoSetDimension:ALDimensionHeight toSize:1];
        
        [self.moneyLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.typeBtn1];
        [self.moneyLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.lineLabel withOffset:10];
        
        [self.dateLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.moneyLabel];
        [self.dateLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.moneyLabel withOffset:5];
        
        [self.ProfitLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.moneyLabel ];
        [self.ProfitLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.dateLabel withOffset:5];
        
        [self.wayLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.moneyLabel];
        [self.wayLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.ProfitLabel withOffset:5];

        [self.rateLabel1 autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.moneyLabel];
        [self.rateLabel1 autoAlignAxis:ALAxisVertical toSameAxisOfView:self.rateLabel2];
        [self.rateLabel1 autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.rateLabel2];
        
        [self.rateLabel2 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.rateLabel1];
        [self.rateLabel2 autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:kSpacePadding];
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

-(UILabel *)headerLabel
{
    if (!_headerLabel) {
        _headerLabel = [UILabel newAutoLayoutView];
        _headerLabel.backgroundColor = kBackgroundColor;
    }
    return _headerLabel;
}

-(UIButton *)typeBtn1
{
    if (!_typeBtn1) {
        _typeBtn1 = [UIButton newAutoLayoutView];
        [_typeBtn1 setTitleColor:[UIColor whiteColor] forState:0];
        _typeBtn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_typeBtn1 setBackgroundImage:[UIImage imageNamed:@"biao"] forState:0];
        _typeBtn1.titleLabel.font = font14;
     }
    return _typeBtn1;
}

-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [UILabel newAutoLayoutView];
        _nameLabel.textColor = kNavigationColor;
        _nameLabel.font = font14;
        _nameLabel.text = @"1232423435345";
    }
    return _nameLabel;
}

-(UIButton *)typeBtn2
{
    if (!_typeBtn2) {
        _typeBtn2 = [UIButton newAutoLayoutView];
        [_typeBtn2 setTitleColor:[UIColor whiteColor] forState:0];
        _typeBtn2.layer.cornerRadius = 2;
        _typeBtn2.titleLabel.font = font14;
        [_typeBtn2 setBackgroundColor:kNavigationColor];
    }
    return _typeBtn2;
}

- (UILabel *)lineLabel
{
    if (!_lineLabel) {
        _lineLabel = [UILabel newAutoLayoutView];
        _lineLabel.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineLabel;
}

-(UILabel *)moneyLabel
{
    if (!_moneyLabel) {
        _moneyLabel = [UILabel newAutoLayoutView];
        _moneyLabel.textColor = [UIColor blackColor];
        _moneyLabel.font = font14;
        _moneyLabel.text = @"借款金额：300000元";
    }
    return _moneyLabel;
}

-(UILabel *)dateLabel
{
    if (!_dateLabel) {
        _dateLabel = [UILabel newAutoLayoutView];
        _dateLabel.textColor = [UIColor blackColor];
        _dateLabel.font = font14;
        _dateLabel.text = @"借款期限：6个月";
    }
    return _dateLabel;
}

-(UILabel *)ProfitLabel
{
    if (!_ProfitLabel) {
        
        _ProfitLabel = [UILabel newAutoLayoutView];
        _ProfitLabel.textColor = [UIColor blackColor];
        _ProfitLabel.font = font14;
        _ProfitLabel.text = @"借款利率：10%";
    }
    return _ProfitLabel;
}

-(UILabel *)wayLabel
{
    if (!_wayLabel) {
        _wayLabel = [UILabel newAutoLayoutView];
        _wayLabel.textColor = [UIColor blackColor];
        _wayLabel.font = font14;
        _wayLabel.text = @"还款方式：一次性还本付息";
    }
    return _wayLabel;
}

-(UILabel *)rateLabel1
{
    if (!_rateLabel1) {
        _rateLabel1 = [UILabel newAutoLayoutView];
        _rateLabel1.font = font14;
        _rateLabel1.textColor = [UIColor blackColor];
    }
    return _rateLabel1;
}

-(UILabel *)rateLabel2
{
    if (!_rateLabel2) {
        _rateLabel2 = [UILabel newAutoLayoutView];
        _rateLabel2.font = [UIFont systemFontOfSize:22];
        _rateLabel2.textColor = kNavigationColor;
    }
    return _rateLabel2;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
