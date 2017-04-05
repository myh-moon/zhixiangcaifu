//
//  MineMoneyView.m
//  zichanbao
//
//  Created by zhixiang on 15/11/6.
//  Copyright © 2015年 zhixiang. All rights reserved.
//

#import "MineMoneyView.h"

@interface MineMoneyView ()
@property (nonatomic,strong) NSNumber *style;
@end
#define font111 [UIFont systemFontOfSize:12];

@implementation MineMoneyView

//-(instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        [self initialize];
//    }
//    return self;
//}

-(instancetype)initWithFrame:(CGRect)frame andStyle:(NSNumber *)style
{
    self = [super initWithFrame:frame];
    if (self) {
        _style = style;
        [self initialize];
        self.userInteractionEnabled  = YES;
    }
    return self;
}
- (void)initialize
{
    self.backgroundColor = kBackgroundColor;
    [self addSubview:self.userButton1];
    [self addSubview:self.userButton2];
    [self addSubview:self.userImage];
    [self addSubview:self.retainBtn];
    [self addSubview:self.rechargeBtn];
    [self addSubview:self.withdraBtn];
    [self addSubview:self.whiteView];
}

-(UIButton *)userButton1
{
    if (!_userButton1) {
        _userButton1 = [UIButton buttonWithType:0];
        _userButton1.frame = CGRectMake(0,10, kScreenWidth, 30);
        [_userButton1 setTitleColor:[UIColor grayColor] forState:0];
        _userButton1.titleLabel.font = [UIFont systemFontOfSize:17];
    }
    return _userButton1;
}

-(UIButton *)userButton2
{
    if (!_userButton2) {
        _userButton2 = [UIButton buttonWithType:0];
        _userButton2.frame = CGRectMake(kScreenWidth-20-60, self.userButton1.top, 60, 30);
        [_userButton2 setTitleColor:[UIColor grayColor] forState:0];
        _userButton2.titleLabel.font = font111;
    }
    return _userButton2;
}

-(UIImageView *)userImage
{
    if (!_userImage) {
        _userImage = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth-40)/2, self.userButton1.bottom+20, 40, 40)];
        [_userImage setImage:[UIImage imageNamed:@"logo"]];
                _userImage.layer.cornerRadius = 20;
        _userImage.layer.masksToBounds = YES;
    }
    return _userImage;
}

-(UIButton *)retainBtn
{
    if (!_retainBtn) {
        _retainBtn = [UIButton buttonWithType:0];
        _retainBtn.frame = CGRectMake(0, self.userImage.bottom+10, kScreenWidth, 60);
//        [_retainBtn setTitleColor:[UIColor grayColor] forState:0];
        _retainBtn.titleLabel.numberOfLines = 0;
        _retainBtn.titleLabel.font = font111;
    }
    return _retainBtn;
}

-(UIButton *)rechargeBtn
{
    if (!_rechargeBtn) {
        _rechargeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rechargeBtn.frame = CGRectMake(40, self.retainBtn.bottom+10,(kScreenWidth-100)/2,30);
        _rechargeBtn.titleLabel.font = font111;
        [_rechargeBtn setTitleColor:[UIColor blackColor] forState:0];
    }
    
    return _rechargeBtn;
}

-(UIButton *)withdraBtn
{
    if (!_withdraBtn) {
        _withdraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _withdraBtn.frame = CGRectMake(self.rechargeBtn.right+20, self.rechargeBtn.top, self.rechargeBtn.width, self.rechargeBtn.height);
        _withdraBtn.titleLabel.font = font111;
        [_withdraBtn setTitleColor:[UIColor whiteColor] forState:0];
    }
    return _withdraBtn;
}

-(UIView *)whiteView
{
    if (!_whiteView) {//0-未登录界面 1-
        if (self.style.intValue == 0) {
//            _whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, self.rechargeBtn.bottom+20, kScreenWidth, 130)];
        }else if(self.style.intValue == 1){//
           _whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, self.rechargeBtn.bottom+20, kScreenWidth, 130)];
        }else{
            _whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height-130, kScreenWidth, 130)];
        }
//        _whiteView = [[UIView alloc] init];
        _whiteView.backgroundColor = [UIColor whiteColor];
    
        [_whiteView addSubview:self.allMoneyLabel];
        [_whiteView addSubview:self.moneyLabel1];
        [_whiteView addSubview:self.moneyLabel2];
        [_whiteView addSubview:self.moneyLabel3];
        [_whiteView addSubview:self.moneyLabel4];
        [_whiteView addSubview:self.moneyLabel5];
        
        //横一
        UILabel *grayLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(20, self.allMoneyLabel.bottom+10, kScreenWidth-40, 1)];
        [_whiteView addSubview:grayLabel1];
        grayLabel1.backgroundColor = [UIColor lightGrayColor];
        
        //横二
        UILabel *grayLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(20,self.moneyLabel2.bottom,grayLabel1.width,grayLabel1.height)];
        [_whiteView addSubview:grayLabel2];
        grayLabel2.backgroundColor = [UIColor lightGrayColor];
        
        //竖一
        UILabel *grayLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(self.moneyLabel2.right+(kScreenWidth-(50+80)*2)/2,grayLabel1.bottom+5,1,30)];
        [_whiteView addSubview:grayLabel3];
        grayLabel3.backgroundColor = [UIColor lightGrayColor];
        
        //竖二
        UILabel *grayLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(grayLabel3.left, grayLabel2.bottom+5,1,grayLabel3.height+10)];
        [_whiteView addSubview:grayLabel4];
        grayLabel4.backgroundColor = [UIColor lightGrayColor];

    
    }
    return _whiteView;
}

-(UILabel *)allMoneyLabel
{
    if (!_allMoneyLabel) {
        _allMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, 50, 20)];
        _allMoneyLabel.text = @"总资产";
        _allMoneyLabel.textColor = [UIColor blackColor];
        _allMoneyLabel.font = font111;
    }
    return _allMoneyLabel;
}

//具体总资产
-(UILabel *)moneyLabel1
{
    if (_moneyLabel1 == nil) {
        
        _moneyLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-180, self.allMoneyLabel.top, 150, self.allMoneyLabel.height)];
        _moneyLabel1.textColor = [UIColor blackColor];
        _moneyLabel1.text = @"21412.22元";
        _moneyLabel1.textAlignment = NSTextAlignmentRight;
        _moneyLabel1.font = font111;
    }
    return _moneyLabel1;
}

//待收收益
-(UILabel *)moneyLabel2
{
    if (!_moneyLabel2) {
        _moneyLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(50, self.moneyLabel1.bottom+10, 80, 40)];
        _moneyLabel2.text = @"待收收益\n2432.23元";
        _moneyLabel2.textColor = [UIColor blackColor];
        _moneyLabel2.textAlignment = NSTextAlignmentCenter;
        _moneyLabel2.numberOfLines = 0;
        _moneyLabel2.font = font111;
        
    }
    return _moneyLabel2;
}

-(UILabel *)moneyLabel3
{
    if (!_moneyLabel3) {
        _moneyLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(_moneyLabel2.right+kScreenWidth-(50+80)*2,self.moneyLabel2.top,self.moneyLabel2.width, self.moneyLabel2.height)];
        _moneyLabel3.text = @"累计收益\n2432.23元";
        _moneyLabel3.textColor = [UIColor blackColor];
        _moneyLabel3.textAlignment = NSTextAlignmentCenter;
        _moneyLabel3.numberOfLines = 0;
        _moneyLabel3.font = font111;
        
    }
    return _moneyLabel3;
}

-(UILabel *)moneyLabel4

{
    if (!_moneyLabel4) {
        
        _moneyLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(self.moneyLabel2.left,self.moneyLabel2.bottom+10,self.moneyLabel2.width, self.moneyLabel2.height)];
        _moneyLabel4.text = @"待收本金\n2432.23元";
        _moneyLabel4.textColor = [UIColor blackColor];
        _moneyLabel4.textAlignment = NSTextAlignmentCenter;
        _moneyLabel4.numberOfLines = 0;
        _moneyLabel4.font = font111;
    }
    return _moneyLabel4;
}

-(UILabel *)moneyLabel5
{
    if (!_moneyLabel5) {
        
        _moneyLabel5 = [[UILabel alloc] initWithFrame:CGRectMake(self.moneyLabel3.left,self.moneyLabel4.top,self.moneyLabel2.width, self.moneyLabel2.height)];
        _moneyLabel5.text = @"冻结本金\n2432.23元";
        _moneyLabel5.textColor = [UIColor blackColor];
        _moneyLabel5.textAlignment = NSTextAlignmentCenter;
        _moneyLabel5.numberOfLines = 0;
        _moneyLabel5.font = font111;
        
    }
    return _moneyLabel5;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
