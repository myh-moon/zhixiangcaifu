//
//  FundCell.m
//  zichanbao
//
//  Created by zhixiang on 15/10/14.
//  Copyright (c) 2015年 zhixiang. All rights reserved.
//

#import "FundCell.h"

@interface FundCell ()

@end

@implementation FundCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"fund";
    FundCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[FundCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
   self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.moneyLabel];
        [self.contentView addSubview:self.timeLabel];
    }
    return self;
}

-(UILabel *)moneyLabel
{
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-100, 5, 90, 20)];
        _moneyLabel.text = @"2273434.34";
        _moneyLabel.textColor = RGBCOLOR(0.8157, 0.2863, 0.4076);
        _moneyLabel.textAlignment = NSTextAlignmentRight;
        _moneyLabel.font = font14;
        
    }
    return _moneyLabel;
}

-(UILabel *)timeLabel
{
    if (!_timeLabel) {
        
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-120, self.moneyLabel.bottom, 110, 20)];
        _timeLabel.textColor = [UIColor grayColor];
        _timeLabel.text = @"12-12 12:12";
        _timeLabel.font = font14;
        _timeLabel.textAlignment = NSTextAlignmentRight;
    }
    return _timeLabel;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
