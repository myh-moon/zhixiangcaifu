//
//  DetailsCell.m
//  zichanbao
//
//  Created by zhixiang on 15/11/17.
//  Copyright © 2015年 zhixiang. All rights reserved.
//

#import "DetailsCell.h"

@implementation DetailsCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.topLabel1];
        [self.contentView addSubview:self.topLabel2];
        [self.contentView addSubview:self.topButton3];
        [self.contentView addSubview:self.lineLable1];
        [self.contentView addSubview:self.lineLable2];
        
//        UILabel *lineLable1 = [[UILabel alloc] initWithFrame:CGRectMake(self.topLabel1.right-0.5, 5, 1, self.topLabel1.height-5*2)];
//        lineLable1.backgroundColor = [UIColor lightGrayColor];
//        [self.contentView addSubview:lineLable1];
//        
//        UILabel *lineLable2 = [[UILabel alloc] initWithFrame:CGRectMake(self.topLabel2.right-0.5, lineLable1.top, lineLable1.width,lineLable1.height)];
//        lineLable2.backgroundColor = [UIColor lightGrayColor];
//        [self.contentView addSubview:lineLable2];
        
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        [self.topLabel1 autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeRight];
        [self.topLabel1 autoSetDimension:ALDimensionWidth toSize:kScreenWidth/3];
        
        [self.topLabel2 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.topLabel1];
        [self.topLabel2 autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.topLabel1];
        [self.topLabel2 autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.topLabel1];
        [self.topLabel2 autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.topButton3];

        [self.topButton3 autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeLeft];
        [self.topButton3 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.topLabel1];
        
        [self.lineLable1 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.topLabel1];
        [self.lineLable1 autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5];
        [self.lineLable1 autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:5];
        [self.lineLable1 autoSetDimension:ALDimensionWidth toSize:kBorderWidth];
        
        [self.lineLable2 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.topLabel2];
        [self.lineLable2 autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.lineLable1];
        [self.lineLable2 autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.lineLable1];
        [self.lineLable2 autoSetDimension:ALDimensionWidth toSize:kBorderWidth];
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

-(UILabel *)topLabel1
{
    if (!_topLabel1) {
        _topLabel1 = [UILabel newAutoLayoutView];
        _topLabel1.textAlignment = NSTextAlignmentCenter;
        _topLabel1.font = font14;
    }
    return _topLabel1;
}

-(UILabel *)topLabel2
{
    if (!_topLabel2) {
        _topLabel2 = [UILabel newAutoLayoutView];
        _topLabel2.textAlignment = NSTextAlignmentCenter;
        _topLabel2.font = font14;
    }
    return _topLabel2;
}

-(UIButton *)topButton3
{
    if (!_topButton3) {
        _topButton3 = [UIButton newAutoLayoutView];
//        _topButton3.textAlignment = NSTextAlignmentCenter;
//        _topButton3.font = font14;
        _topButton3.titleLabel.font = font14;
    }
    return _topButton3;
}

- (UILabel *)lineLable1
{
    if (!_lineLable1) {
        _lineLable1 = [UILabel newAutoLayoutView];
        _lineLable1.backgroundColor = kLightGrayColor;
    }
    return _lineLable1;
}

- (UILabel *)lineLable2
{
    if (!_lineLable2) {
        _lineLable2 = [UILabel newAutoLayoutView];
        _lineLable2.backgroundColor = kLightGrayColor;
    }
    return _lineLable2;
}

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
