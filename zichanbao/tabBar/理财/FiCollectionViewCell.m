//
//  FiCollectionViewCell.m
//  zichanbao
//
//  Created by zhixiang on 15/10/29.
//  Copyright (c) 2015年 zhixiang. All rights reserved.
//

#import "FiCollectionViewCell.h"

@implementation FiCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.textButton];
    }
    return self;
    
}

-(UIButton *)textButton
{
    if (_textButton == nil) {
        _textButton = [UIButton buttonWithType:0];
        _textButton.frame = CGRectMake((kScreenWidth/3-90)/2, 0, 70, 20);
        [_textButton setTitleColor:[UIColor whiteColor] forState:0];
        _textButton.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return _textButton;
}

@end
