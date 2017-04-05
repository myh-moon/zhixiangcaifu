//
//  BasicButton.m
//  zichanbao
//
//  Created by zhixiang on 15/10/28.
//  Copyright (c) 2015年 zhixiang. All rights reserved.
//

#import "BasicButton.h"

@implementation BasicButton

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kNavigationColor;
        self.frame = CGRectMake(30,0, kScreenWidth-30*2, 50);
        self.layer.cornerRadius = 4;
        [self setTitleColor:[UIColor whiteColor] forState:0];
        self.titleLabel.font = [UIFont systemFontOfSize:20];
    }
    return self;
}

//-(UIButton *)bottomBasicButton
//{
//    if (!_bottomBasicButton) {
//        _bottomBasicButton = [UIButton buttonWithType:0];
//        _bottomBasicButton.frame = CGRectMake(30,0, kScreenWidth-30*2, 50);
//        _bottomBasicButton.layer.cornerRadius = 4;
//    }
//    return _bottomBasicButton;
//}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
