//
//  RePayDetailCell.m
//  zichanbao
//
//  Created by zhixiang on 16/11/8.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import "RePayDetailCell.h"

@implementation RePayDetailCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.rePayLabel1];
        [self.contentView addSubview:self.rePayLabel2];
        [self.contentView addSubview:self.rePayLabel3];
        [self.contentView addSubview:self.rePayLabel4];
        
        UILabel *lineLable1 = [[UILabel alloc] initWithFrame:CGRectMake(self.rePayLabel1.right-0.5, 5, 1, self.rePayLabel1.height-5*2)];
        lineLable1.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:lineLable1];
        
        UILabel *lineLable2 = [[UILabel alloc] initWithFrame:CGRectMake(self.rePayLabel2.right-0.5, lineLable1.top, lineLable1.width,lineLable1.height)];
        lineLable2.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:lineLable2];
        
        UILabel *lineLable3 = [[UILabel alloc] initWithFrame:CGRectMake(self.rePayLabel3.right-0.5, lineLable1.top, lineLable1.width,lineLable1.height)];
        lineLable3.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:lineLable3];
        
    }
    return self;
}

-(UILabel *)rePayLabel1
{
    if (!_rePayLabel1) {
        _rePayLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth/4, 40)];
        _rePayLabel1.textAlignment = NSTextAlignmentCenter;
        _rePayLabel1.font = font14;
    }
    return _rePayLabel1;
}

-(UILabel *)rePayLabel2
{
    if (!_rePayLabel2) {
        _rePayLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(self.rePayLabel1.right, 0, kScreenWidth/4, self.rePayLabel1.height)];
        _rePayLabel2.textAlignment = NSTextAlignmentCenter;
        _rePayLabel2.font = font14;
    }
    return _rePayLabel2;
}

-(UILabel *)rePayLabel3
{
    if (!_rePayLabel3) {
        _rePayLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(self.rePayLabel2.right,0, kScreenWidth/4, self.rePayLabel1.height)];
        _rePayLabel3.textAlignment = NSTextAlignmentCenter;
        _rePayLabel3.font = font14;
    }
    return _rePayLabel3;
}

-(UILabel *)rePayLabel4
{
    if (!_rePayLabel4) {
        _rePayLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(self.rePayLabel3.right,0, kScreenWidth/4, self.rePayLabel1.height)];
        _rePayLabel4.textAlignment = NSTextAlignmentCenter;
        _rePayLabel4.font = font14;
    }
    return _rePayLabel4;
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
