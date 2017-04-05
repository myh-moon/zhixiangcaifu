//
//  HomeCell.m
//  zichanbao
//
//  Created by zhixiang on 15/10/12.
//  Copyright (c) 2015年 zhixiang. All rights reserved.
//

#import "HomeCell.h"
@interface HomeCell ()

@end

@implementation HomeCell

#define kw 10

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.progressView];
        self.progressView.centralView = self.innnerLabel;
        [self.contentView addSubview:self.borrowName];
        [self.contentView addSubview:self.rateBtn];
        [self.contentView addSubview:self.dateBtn];
        [self.contentView addSubview:self.moneyBtn];
        [self.contentView addSubview:self.signBtn];
        [self.contentView addSubview:self.rateLabel];
        [self.contentView addSubview:self.dateLabel];
        [self.contentView addSubview:self.moneyLabel];
    }
    return self;
}

-(UAProgressView *)progressView
{
    if (!_progressView) {
        _progressView = [[UAProgressView alloc] initWithFrame:CGRectMake(10,20,60,60)];
        _progressView.progress = 0.5;
        _progressView.tintColor = kNavigationColor;
        _progressView.borderWidth = 2;
        _progressView.lineWidth = 4;
    }
    return _progressView;
}

-(UILabel *)innnerLabel
{
    if (!_innnerLabel) {
        _innnerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
        _innnerLabel.textAlignment = NSTextAlignmentCenter;
//        _innnerLabel.text = @"进度\n15.00%";
        _innnerLabel.numberOfLines = 0;
        _innnerLabel.font = font14;
    }
    return _innnerLabel;
}

-(UILabel *)borrowName
{
    if (!_borrowName) {
        _borrowName = [[UILabel alloc] initWithFrame:CGRectMake(self.progressView.right+10, self.progressView.top, kScreenWidth-(10*2+self.progressView.width+40+10), 20)];
//        _borrowName.text = @"直e贷000001号上海浦东公寓住宅";
        _borrowName.textColor = [UIColor blackColor];
        _borrowName.font = font14;
    }
    return _borrowName;
}

-(UIButton *)rateBtn
{
    if (!_rateBtn) {
        _rateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rateBtn.frame = CGRectMake(_borrowName.left, _borrowName.bottom+10,(self.borrowName.width-kw*3)/3, 20);
        [_rateBtn setImage:[UIImage imageNamed:@"shouyi"] forState:0];
        [_rateBtn setTitle:@" 收益" forState:0];
        _rateBtn.titleLabel.font = font14;
        [_rateBtn setTitleColor:[UIColor grayColor] forState:0];
        _rateBtn.contentHorizontalAlignment = 1;
        _rateBtn.userInteractionEnabled = NO;
    }
    return _rateBtn;
}

-(UIButton *)dateBtn
{
    if (!_dateBtn) {
        _dateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _dateBtn.frame = CGRectMake(_rateBtn.right + kw, _rateBtn.top, _rateBtn.width, _rateBtn.height);
        [_dateBtn setImage:[UIImage imageNamed:@"qixian"] forState:0];
        [_dateBtn setTitle:@" 期限" forState:0];
        _dateBtn.contentHorizontalAlignment = 1;
        _dateBtn.titleLabel.font = self.rateBtn.titleLabel.font;
        _dateBtn.userInteractionEnabled = NO;
        [_dateBtn setTitleColor:[UIColor grayColor] forState:0];
    }
    return _dateBtn;
}

-(UIButton *)moneyBtn
{
    if (!_moneyBtn) {
        _moneyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _moneyBtn.frame = CGRectMake(_dateBtn.right + kw, _rateBtn.top, _rateBtn.width, _rateBtn.height);
        [_moneyBtn setImage:[UIImage imageNamed:@"jine"] forState:0];
        [_moneyBtn setTitle:@" 金额" forState:0];
        _moneyBtn.contentHorizontalAlignment = 1;
        _moneyBtn.titleLabel.font = self.rateBtn.titleLabel.font;
        _moneyBtn.userInteractionEnabled = NO;
        [_moneyBtn setTitleColor:[UIColor grayColor] forState:0];
    }
    return _moneyBtn;
}

-(UIButton *)signBtn
{
    if (!_signBtn) {
        _signBtn = [UIButton buttonWithType:0];
        _signBtn.frame = CGRectMake(kScreenWidth-50, self.moneyBtn.top-5, 40, 30);
        [_signBtn setTitleColor:[UIColor whiteColor] forState:0];
        _signBtn.layer.cornerRadius = 4;
        [_signBtn setBackgroundColor:kNavigationColor];
        _signBtn.titleLabel.font = font14;
    }
    return _signBtn;
}

-(UILabel *)rateLabel
{
    if (!_rateLabel) {
        _rateLabel = [[UILabel alloc] initWithFrame:CGRectMake(_rateBtn.left, _rateBtn.bottom+5, (kScreenWidth-(10*2+60+10+20*2))/3, 30)];
//        _rateLabel.text = @"15.00%";
        _rateLabel.textColor = [UIColor orangeColor];
        _rateLabel.font = [UIFont systemFontOfSize:18.f];
    }
    return _rateLabel;
}

-(UILabel *)dateLabel
{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(_dateBtn.left, _dateBtn.bottom+5, _rateLabel.width, _rateLabel.height)];
//        _dateLabel.text = @"12个月";
        _dateLabel.textColor = kNavigationColor;
        _dateLabel.font = self.rateLabel.font;
        
    }
    return _dateLabel;
}

-(UILabel *)moneyLabel
{
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(_moneyBtn.left,_moneyBtn.bottom+5, _rateLabel.width+40,  _rateLabel.height)];
//        _moneyLabel.text = @"600万";
        _moneyLabel.textColor = [UIColor blackColor];
        _moneyLabel.font = self.rateLabel.font;
    }
    return _moneyLabel;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
