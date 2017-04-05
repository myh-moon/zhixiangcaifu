//
//  RedCell.m
//  zichanbao
//
//  Created by zhixiang on 15/10/19.
//  Copyright (c) 2015年 zhixiang. All rights reserved.
//

#import "RedCell.h"
#define kScreenWidth1  kScreenWidth-10*2

@interface RedCell ()

@end

@implementation RedCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"red";
    RedCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[RedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
                
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        UILabel *bglabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth1, 10)];
        bglabel.backgroundColor = kBackgroundColor;
        [self.contentView addSubview:bglabel];
        
        [self.contentView addSubview:self.nameHongBao];
        
        [self.contentView addSubview:self.getTimeLab];
        [self.contentView addSubview:self.indataLab];

        [self.contentView addSubview:self.moneyBtn];
        
    }
    return self;
}

-(UILabel *)nameHongBao
{
    if (!_nameHongBao) {
        _nameHongBao = [[UILabel alloc] initWithFrame:CGRectMake(10,15, kScreenWidth1-20*2, 20)];
        _nameHongBao.font = [UIFont systemFontOfSize:13];
        _nameHongBao.textColor = [UIColor blackColor];
//        _nameHongBao.text = @"收到了*****的红包";

    }
    return _nameHongBao;
}

-(UILabel *)getTimeLab
{
    if (!_getTimeLab) {
        _getTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(10,self.nameHongBao.bottom, 200, 20)];
        _getTimeLab.textColor = [UIColor blackColor];
        _getTimeLab.font = [UIFont systemFontOfSize:13];
//        _getTimeLab.text = @"获得时间：2015－10-19 10:47:12";
    }
    return _getTimeLab;
}

-(UILabel *)indataLab
{
    if (!_indataLab) {
        _indataLab = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.getTimeLab.frame), 200, 21)];
        _indataLab.textColor = [UIColor blackColor];
        _indataLab.font = [UIFont systemFontOfSize:13];
//        _indataLab.text = @"有效期限：2015－10-26 10:47:12";
    }
    return _indataLab;
}

-(UIButton *)moneyBtn
{
    if (!_moneyBtn) {
        _moneyBtn = [UIButton buttonWithType:0];
        _moneyBtn.frame = CGRectMake(kScreenWidth1 - 90, 30, 70, 30);
        _moneyBtn.tag = 15;
        _moneyBtn.titleLabel.font = [UIFont systemFontOfSize:13];
//        _moneyBtn.backgroundColor = kNavigationColor;
        _moneyBtn.layer.cornerRadius = 15;
//        [_moneyBtn setTitle:@"¥2.56" forState:0];
        [_moneyBtn setTitleColor:[UIColor whiteColor] forState:0];
    }
    return _moneyBtn;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
