//
//  DetailsView.m
//  zichanbao
//
//  Created by zhixiang on 15/11/17.
//  Copyright © 2015年 zhixiang. All rights reserved.
//

#import "DetailsView.h"
@interface DetailsView()

@property (nonatomic,strong) UIView *whiteDetailView;

@end

#define h 20
@implementation DetailsView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.whiteDetailView];
    }
    return self;
}

#pragma mark - init
-(UIView *)whiteDetailView
{
    if (!_whiteDetailView) {
        _whiteDetailView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 170)];
        _whiteDetailView.backgroundColor = [UIColor whiteColor];
        
        [_whiteDetailView addSubview:self.typeBtn1];
        [_whiteDetailView addSubview:self.nameLabel];
        [_whiteDetailView addSubview:self.rateLabel1];
        [_whiteDetailView addSubview:self.rateLabel2];
        [_whiteDetailView addSubview:self.timeLabel1];
        [_whiteDetailView addSubview:self.timeLabel2];
        
        [_whiteDetailView addSubview:self.windReportButton];
        
        [_whiteDetailView addSubview:self.progressView];
        [_whiteDetailView addSubview:self.leftLabel];
        [_whiteDetailView addSubview:self.rightLabel];
        [_whiteDetailView addSubview:self.startMomeyLabel];
        [_whiteDetailView addSubview:self.wayLabel];
        
        //分隔线
        UILabel *lineL = [[UILabel alloc] initWithFrame:CGRectMake(0, self.typeBtn1.bottom+5, kScreenWidth, 1)];
        lineL.backgroundColor = [UIColor lightGrayColor];
        [_whiteDetailView addSubview:lineL];
    }
    return _whiteDetailView;
}
-(UIButton *)typeBtn1
{
    if (!_typeBtn1) {
        _typeBtn1 = [UIButton buttonWithType:0];
        _typeBtn1.frame = CGRectMake(20, 5, 60, h);
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
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.typeBtn1.right+10,self.typeBtn1.top, kScreenWidth-(20*2+self.typeBtn1.width+10),h)];
        _nameLabel.textColor = kNavigationColor;
        _nameLabel.font = font14;
    }
    return _nameLabel;
}

-(UILabel *)rateLabel1
{
    if (_rateLabel1 == nil) {
        _rateLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(self.typeBtn1.left, self.typeBtn1.bottom+15,(kScreenWidth-20*2)/2,h)];
        _rateLabel1.text = @"年化率";
        _rateLabel1.textColor = [UIColor blackColor];
        _rateLabel1.font = font14;
    }
    return _rateLabel1;
}

-(UILabel *)rateLabel2
{
    if (_rateLabel2 == nil) {
        _rateLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(self.rateLabel1.left, self.rateLabel1.bottom, self.rateLabel1.width,40)];
        _rateLabel2.font = [UIFont systemFontOfSize:26];
        _rateLabel2.textColor = kNavigationColor;
    }
    return _rateLabel2;
}

-(UILabel *)timeLabel1
{
    if (_timeLabel1 == nil) {
        _timeLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-20-60*2, self.rateLabel1.top, 60, h)];
        _timeLabel1.textColor = [UIColor blackColor];
        _timeLabel1.text = @"借款时间";
        _timeLabel1.font = font14;
    }
    return _timeLabel1;
}

-(UILabel *)timeLabel2
{
    if (_timeLabel2 == nil) {
        _timeLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(self.timeLabel1.right, self.timeLabel1.top-5, 60, 30)];
        _timeLabel2.textColor = kNavigationColor;
        _timeLabel2.font = [UIFont systemFontOfSize:18];
    }
    return _timeLabel2;
}

- (UIButton *)windReportButton
{
    if (!_windReportButton) {
        _windReportButton = [[UIButton alloc] initWithFrame:CGRectMake(self.timeLabel1.left, self.rateLabel2.top, self.timeLabel1.width+self.timeLabel2.width, self.rateLabel2.height)];
        [_windReportButton setTitleColor:[UIColor blackColor] forState:0];
        _windReportButton.titleLabel.font = font14;
    }
    return _windReportButton;
}

-(UIProgressView *)progressView
{
    if (_progressView == nil) {
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(self.rateLabel1.left, self.rateLabel2.bottom+5, kScreenWidth-20*2, 5)];
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
        _leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.progressView.left+10, self.progressView.bottom+10, (self.progressView.width-10*2)/2, 10)];
        _leftLabel.textColor = [UIColor blackColor];
        //        _leftLabel.text = @"已售10%";
        _leftLabel.font = [UIFont systemFontOfSize:12];
    }
    return _leftLabel;
}

-(UILabel *)rightLabel
{
    if (_rightLabel == nil) {
        _rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.leftLabel.right, self.leftLabel.top, self.leftLabel.width, self.leftLabel.height)];
        _rightLabel.font = [UIFont systemFontOfSize:12];
        _rightLabel.textAlignment = NSTextAlignmentRight;
    }
    return _rightLabel;
}

-(UILabel *)startMomeyLabel
{
    if (_startMomeyLabel == nil) {
        _startMomeyLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.leftLabel.left, self.leftLabel.bottom+15, self.leftLabel.width, self.leftLabel.height)];
        
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
        _wayLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.startMomeyLabel.right, self.startMomeyLabel.top, self.startMomeyLabel.width, self.startMomeyLabel.height)];
        _wayLabel.textAlignment = NSTextAlignmentRight;
//        _wayLabel.text = @"一次性还本付息";
        _wayLabel.font = [UIFont systemFontOfSize:12];
    }
    return _wayLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
