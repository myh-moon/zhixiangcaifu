//
//  OrderDetailsCell.m
//  zichanbao
//
//  Created by zhixiang on 17/1/5.
//  Copyright © 2017年 zhixiang. All rights reserved.
//

#import "OrderDetailsCell.h"
#define h 20


@implementation OrderDetailsCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.typeBtn1];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.rateLabel1];
        [self.contentView addSubview:self.rateLabel2];
        [self.contentView addSubview:self.timeLabel1];
        [self.contentView addSubview:self.timeLabel2];
        
        [self.contentView addSubview:self.windReportButton];
        
        [self.contentView addSubview:self.progressView];
        [self.contentView addSubview:self.leftLabel];
        [self.contentView addSubview:self.rightLabel];
        [self.contentView addSubview:self.startMomeyLabel];
        [self.contentView addSubview:self.wayLabel];
       
    }
    return self;
}

- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        
        [self.typeBtn1 autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:kSpacePadding];
        [self.typeBtn1 autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:kSmallSpace];
        
        [self.nameLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.typeBtn1 withOffset:10];
        [self.nameLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.typeBtn1];
        
        [self.linesLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [self.linesLabel autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [self.linesLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.typeBtn1 withOffset:kSmallSpace];
        [self.linesLabel autoSetDimension:ALDimensionHeight toSize:kBorderWidth];
        
        [self.rateLabel1 autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.typeBtn1];
        [self.rateLabel1 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.linesLabel withOffset:10];
        
        [self.rateLabel2 autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.rateLabel1];
        [self.rateLabel2 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.rateLabel1 withOffset:5];
        
        [self.timeLabel1 autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.self.rateLabel1];
        [self.timeLabel1 autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.timeLabel2];
        
        [self.timeLabel2 autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:kSpacePadding];
        [self.timeLabel2 autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.self.timeLabel1];
        
        
        [self.windReportButton autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.timeLabel1];
        [self.windReportButton autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.rateLabel2];
        
        [self.progressView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:kSpacePadding];
        [self.progressView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:kSpacePadding];
        [self.progressView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.rateLabel2 withOffset:kSmallSpace];
        [self.progressView autoSetDimension:ALDimensionHeight toSize:kSmallSpace];
        
        [self.leftLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.progressView withOffset:10];
        [self.leftLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.progressView withOffset:10];
        
        [self.rightLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.leftLabel];
        [self.rightLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.progressView withOffset:-10];

        [self.startMomeyLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.leftLabel];
        [self.startMomeyLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.leftLabel withOffset:kSmallPadding];
        
        [self.wayLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.rightLabel];
        [self.wayLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.startMomeyLabel];
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

-(UIButton *)typeBtn1
{
    if (!_typeBtn1) {
        _typeBtn1 = [UIButton newAutoLayoutView];
//        [UIButton buttonWithType:0];
//        _typeBtn1.frame = CGRectMake(20, 5, 60, h);
        [_typeBtn1 setBackgroundImage:[UIImage imageNamed:@"biao"] forState:0];
        [_typeBtn1 setTitleColor:[UIColor whiteColor] forState:0];
        _typeBtn1.titleLabel.font = font14;
        _typeBtn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _typeBtn1;
}

-(UILabel *)nameLabel
{
    if (_nameLabel == nil) {
        _nameLabel = [UILabel newAutoLayoutView];
//        [[UILabel alloc] initWithFrame:CGRectMake(self.typeBtn1.right+10,self.typeBtn1.top, kScreenWidth-(20*2+self.typeBtn1.width+10),h)];
        _nameLabel.textColor = kNavigationColor;
        _nameLabel.font = font14;
    }
    return _nameLabel;
}

- (UILabel *)linesLabel
{
    if (!_linesLabel) {
        _linesLabel = [UILabel newAutoLayoutView];
//        [UILabel newAutoLayoutView];
        _linesLabel.backgroundColor = kBlackColor;
    }
    return _linesLabel;
}

-(UILabel *)rateLabel1
{
    if (_rateLabel1 == nil) {
        _rateLabel1 = [UILabel newAutoLayoutView];
//        [[UILabel alloc] initWithFrame:CGRectMake(self.typeBtn1.left, self.typeBtn1.bottom+15,(kScreenWidth-20*2)/2,h)];
        _rateLabel1.text = @"年化率";
        _rateLabel1.textColor = [UIColor blackColor];
        _rateLabel1.font = font14;
    }
    return _rateLabel1;
}

-(UILabel *)rateLabel2
{
    if (_rateLabel2 == nil) {
        _rateLabel2 = [UILabel newAutoLayoutView];
//        [[UILabel alloc] initWithFrame:CGRectMake(self.rateLabel1.left, self.rateLabel1.bottom, self.rateLabel1.width,40)];
        _rateLabel2.font = [UIFont systemFontOfSize:26];
        _rateLabel2.textColor = kNavigationColor;
    }
    return _rateLabel2;
}

-(UILabel *)timeLabel1
{
    if (_timeLabel1 == nil) {
        _timeLabel1 = [UILabel newAutoLayoutView];
//        [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-20-60*2, self.rateLabel1.top, 60, h)];
        _timeLabel1.textColor = [UIColor blackColor];
        _timeLabel1.text = @"借款时间";
        _timeLabel1.font = font14;
    }
    return _timeLabel1;
}

-(UILabel *)timeLabel2
{
    if (_timeLabel2 == nil) {
        _timeLabel2 = [UILabel newAutoLayoutView];
//        [[UILabel alloc] initWithFrame:CGRectMake(self.timeLabel1.right, self.timeLabel1.top-5, 60, 30)];
        _timeLabel2.textColor = kNavigationColor;
        _timeLabel2.font = [UIFont systemFontOfSize:18];
    }
    return _timeLabel2;
}

- (UIButton *)windReportButton
{
    if (!_windReportButton) {
        _windReportButton = [UIButton newAutoLayoutView];
//        [[UIButton alloc] initWithFrame:CGRectMake(self.timeLabel1.left, self.rateLabel2.top, self.timeLabel1.width+self.timeLabel2.width, self.rateLabel2.height)];
        [_windReportButton setTitleColor:[UIColor blackColor] forState:0];
        _windReportButton.titleLabel.font = font14;
    }
    return _windReportButton;
}

-(UIProgressView *)progressView
{
    if (_progressView == nil) {
        _progressView = [UIProgressView newAutoLayoutView];
//        [[UIProgressView alloc] initWithFrame:CGRectMake(self.rateLabel1.left, self.rateLabel2.bottom+5, kScreenWidth-20*2, 5)];
        CGAffineTransform transform = CGAffineTransformMakeScale(1, 3);
        _progressView.transform = transform;
        _progressView.progressTintColor = kNavigationColor;
        _progressView.trackTintColor = kBackgroundColor;
    }
    return _progressView;
}

-(UILabel *)leftLabel
{
    if (_leftLabel == nil) {
        _leftLabel = [UILabel newAutoLayoutView];
//        [[UILabel alloc] initWithFrame:CGRectMake(self.progressView.left+10, self.progressView.bottom+10, (self.progressView.width-10*2)/2, 10)];
        _leftLabel.textColor = [UIColor blackColor];
        //        _leftLabel.text = @"已售10%";
        _leftLabel.font = [UIFont systemFontOfSize:12];
    }
    return _leftLabel;
}

-(UILabel *)rightLabel
{
    if (_rightLabel == nil) {
        _rightLabel = [UILabel newAutoLayoutView];
//        [[UILabel alloc] initWithFrame:CGRectMake(self.leftLabel.right, self.leftLabel.top, self.leftLabel.width, self.leftLabel.height)];
        _rightLabel.font = [UIFont systemFontOfSize:12];
        _rightLabel.textAlignment = NSTextAlignmentRight;
    }
    return _rightLabel;
}

-(UILabel *)startMomeyLabel
{
    if (_startMomeyLabel == nil) {
        _startMomeyLabel = [UILabel newAutoLayoutView];
//        [[UILabel alloc] initWithFrame:CGRectMake(self.leftLabel.left, self.leftLabel.bottom+15, self.leftLabel.width, self.leftLabel.height)];
        
        //        NSString *startS = @"起投金额500元";
        //        NSMutableAttributedString *startAttributeString = [[NSMutableAttributedString alloc] initWithString:startS];
        //        [startAttributeString addAttributes:@{NSForegroundColorAttributeName:kNavigationColor} range:NSMakeRange(4, 4)];
        //        [_startMomeyLabel setAttributedText:startAttributeString];
        _startMomeyLabel.font = [UIFont systemFontOfSize:12];
    }
    return _startMomeyLabel;
}

-(UILabel *)wayLabel
{
    if (_wayLabel == nil) {
        _wayLabel = [UILabel newAutoLayoutView];
//        [[UILabel alloc] initWithFrame:CGRectMake(self.startMomeyLabel.right, self.startMomeyLabel.top, self.startMomeyLabel.width, self.startMomeyLabel.height)];
        _wayLabel.textAlignment = NSTextAlignmentRight;
        //        _wayLabel.text = @"一次性还本付息";
        _wayLabel.font = [UIFont systemFontOfSize:12];
    }
    return _wayLabel;
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
