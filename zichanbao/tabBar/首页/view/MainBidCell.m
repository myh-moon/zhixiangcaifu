//
//  MainBidCell.m
//  zichanbao
//
//  Created by zhixiang on 17/1/3.
//  Copyright © 2017年 zhixiang. All rights reserved.
//

#import "MainBidCell.h"

@implementation MainBidCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.codeButton];
        [self.contentView addSubview:self.typeButton];
        [self.contentView addSubview:self.linesLabel];
        [self.contentView addSubview:self.contenLabel1];
        [self.contentView addSubview:self.contenLabel2];
        [self.contentView addSubview:self.contenLabel3];
        [self.contentView addSubview:self.progressView];
        [self.contentView addSubview:self.progressTagLabel];
        [self.contentView addSubview:self.actionButton];
        
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        
        [self.codeButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:kSmallPadding];
        [self.codeButton autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:12];
        
        [self.typeButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:kSmallPadding];
        [self.typeButton autoPinEdgeToSuperviewEdge:ALEdgeTop];
        
        [self.linesLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [self.linesLabel autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [self.linesLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.codeButton withOffset:12];
        [self.linesLabel autoSetDimension:ALDimensionHeight toSize:kBorderWidth];
        
        [self.contenLabel1 autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:kSmallPadding];
        [self.contenLabel1 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.linesLabel withOffset:10];
        
        [self.contenLabel2 autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.contenLabel1];
        [self.contenLabel2 autoAlignAxisToSuperviewAxis:ALAxisVertical];
        
        [self.contenLabel3 autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.contenLabel2];
        [self.contenLabel3 autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:kSmallPadding];
        
        [self.progressView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.contenLabel1];
        [self.progressView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.contenLabel1 withOffset:kSmallPadding];
        [self.progressView autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.progressTagLabel withOffset:-kSmallPadding];
        [self.progressView autoSetDimension:ALDimensionHeight toSize:7];
        
        [self.progressTagLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.progressView];
        [self.progressTagLabel autoSetDimensionsToSize:CGSizeMake(40, 18)];
        [self.progressTagLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.actionButton withOffset:-kSmallPadding*2];
        
        [self.actionButton autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.contenLabel3];
        [self.actionButton autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.progressTagLabel];
        [self.actionButton autoSetDimensionsToSize:CGSizeMake(50, 24)];
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (UIButton *)codeButton
{
    if (!_codeButton) {
        _codeButton = [UIButton newAutoLayoutView];
        _codeButton.titleLabel.font = font14;
        [_codeButton setTitleColor:kBlackColor forState:0];
    }
    return _codeButton;
}

- (UIButton *)typeButton
{
    if (!_typeButton) {
        _typeButton = [UIButton newAutoLayoutView];
    }
    return _typeButton;
}

- (UILabel *)linesLabel
{
    if (!_linesLabel) {
        _linesLabel = [UILabel newAutoLayoutView];
        _linesLabel.backgroundColor = kBackgroundColor;
    }
    return _linesLabel;
}

- (UILabel *)contenLabel1
{
    if (!_contenLabel1) {
        _contenLabel1 = [UILabel newAutoLayoutView];
        _contenLabel1.numberOfLines = 0;
        _contenLabel1.textAlignment= 1;
    }
    return _contenLabel1;
}

- (UILabel *)contenLabel2
{
    if (!_contenLabel2) {
        _contenLabel2 = [UILabel newAutoLayoutView];
        _contenLabel2.numberOfLines = 0;
        _contenLabel2.textAlignment= 1;
    }
    return _contenLabel2;
}

- (UILabel *)contenLabel3
{
    if (!_contenLabel3) {
        _contenLabel3 = [UILabel newAutoLayoutView];
        _contenLabel3.numberOfLines = 0;
        _contenLabel3.textAlignment= 1;
    }
    return _contenLabel3;
}

- (UIProgressView *)progressView
{
    if (!_progressView) {
        _progressView = [UIProgressView newAutoLayoutView];
        _progressView.trackImage = [UIImage imageNamed:@"yjbg"];
        _progressView.progressImage = [UIImage imageNamed:@"jindutiaoman"];
    }
    return _progressView;
}

- (UILabel *)progressTagLabel
{
    if (!_progressTagLabel) {
        _progressTagLabel = [UILabel newAutoLayoutView];
        _progressTagLabel.layer.borderColor = kBlueColor.CGColor;
        _progressTagLabel.layer.borderWidth = kBorderWidth;
        _progressTagLabel.layer.cornerRadius = 4;
        _progressTagLabel.text = @"50%";
        _progressTagLabel.textColor = kBlueColor;
        _progressTagLabel.font = font12;
        _progressTagLabel.textAlignment = 1;
    }
    return _progressTagLabel;
}

- (UIButton *)actionButton
{
    if (!_actionButton) {
        _actionButton = [UIButton newAutoLayoutView];
        _actionButton.backgroundColor = kPurpleColor;
        [_actionButton setTitleColor:kWhiteColor forState:0];
        _actionButton.titleLabel.font = font14;
        _actionButton.layer.cornerRadius = 4;
    }
    return _actionButton;
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
