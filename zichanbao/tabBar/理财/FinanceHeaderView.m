//
//  FinanceHeaderView.m
//  zichanbao
//
//  Created by zhixiang on 15/10/27.
//  Copyright (c) 2015年 zhixiang. All rights reserved.
//

#import "FinanceHeaderView.h"

@implementation FinanceHeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        [self addSubview:self.headerView];
        
//        [self addSubview:self.downButton];
    }
    return self;
}

-(UIView *)headerView
{
    if (_headerView == nil) {
       _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
        
        NSArray *typeArray = [NSArray arrayWithObjects:@"产品类型",@"期限",@"收益", nil];
        
        for (int t=0; t<3; t++) {
            UIButton *typeButton = [UIButton buttonWithType:0];
            typeButton.frame = CGRectMake(kScreenWidth/3*t, 0, kScreenWidth/3, 30);
            [typeButton setTitleColor:[UIColor whiteColor] forState:0];
            typeButton.titleLabel.font = font14;
            [typeButton setTitle:typeArray[t] forState:0];
            [_headerView addSubview:typeButton];
        }
    }
    return _headerView;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
