//
//  InvestSecondSubView.m
//  zichanbao
//
//  Created by zhixiang on 15/12/11.
//  Copyright © 2015年 zhixiang. All rights reserved.
//

#import "InvestSecondSubView.h"

@interface InvestSecondSubView()

@property (nonatomic,strong) UIView *whiteView;

@end

@implementation InvestSecondSubView

#define label1X 80
#define label1H 50

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.whiteView];
    }
    return self;
}

-(UIView *)whiteView
{
    if (!_whiteView) {
        _whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 150)];
        _whiteView.backgroundColor = [UIColor whiteColor];
        
        //布局
        NSArray *tiArray1 = [NSArray arrayWithObjects:@"投资金额",@"投资券",@"红包", nil];
        NSArray *tiArray2 = [NSArray arrayWithObjects:@"充值",@"全投", nil];
        for (int i=0; i<tiArray1.count; i++) {
            UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(20, (2*i+1)*15+20*i, 60, 20)];
            label1.text = tiArray1[i];
            label1.font = font14;
            label1.textColor = [UIColor blackColor];
            [_whiteView addSubview:label1];
            
            //分隔线
            UILabel *lineL1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 50*(i+1), kScreenWidth, 1)];
            lineL1.backgroundColor = lineColor11;
            [_whiteView addSubview:lineL1];
            
            if (i == 0) {//投资金额
                [_whiteView addSubview:self.moneyTextField];
                
                //充值，全投
                for (int j = 0; j < 2; j++) {
                    UIButton *postBtn = [UIButton buttonWithType:0];
                    postBtn.frame = CGRectMake((kScreenWidth-20-10-40*2)+50*j, label1.top,40, label1.height);
                    [postBtn setTitle:tiArray2[j] forState:0];
                    [postBtn setTitleColor:[UIColor whiteColor] forState:0];
                    postBtn.titleLabel.font = font14;
                    [postBtn setBackgroundColor:kNavigationColor];
                    postBtn.layer.cornerRadius = 4;
                    [_whiteView addSubview:postBtn];
                    postBtn.tag = j;
                    
                    [postBtn addAction:^(UIButton *button) {
                        
                        if (button.tag == 0) {
                            //充值
                            if (self.btnClickAction) {
                                self.btnClickAction(@0);
                            }
                            
                        }else{
                            //全投
                            if (self.btnClickAction) {
                                self.btnClickAction(@1);
                            }
                        }
                    }];
                    
                }
            }else if (i==1){//投资券
               
                [_whiteView addSubview:self.ticketBtn];
                
            }else{
                [_whiteView addSubview:self.packetBtn];
            }
        }
    }
    return _whiteView;
}

-(UITextField *)moneyTextField
{
    if (!_moneyTextField) {
        _moneyTextField = [[UITextField alloc] initWithFrame:CGRectMake(label1X+10, 0.3*label1H, 150,0.4*label1H)];
        _moneyTextField.placeholder = @"请输入投资金额";
        _moneyTextField.font = font14;
        _moneyTextField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _moneyTextField;
}

-(UIButton *)ticketBtn
{
    if (!_ticketBtn) {
        _ticketBtn = [UIButton buttonWithType:0];
        _ticketBtn.frame = CGRectMake(label1X+10,1.3*label1H, self.moneyTextField.width,self.moneyTextField.height);
        [_ticketBtn setTitle:@"点击使用投资券" forState:0];
        [_ticketBtn setTitleColor:[UIColor lightGrayColor] forState:0];
        _ticketBtn.titleLabel.font = font14;
        _ticketBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        ZXWeakSelf;
        [_ticketBtn addAction:^(UIButton *btn) {
            if (weakself.btnClickAction) {
                weakself.btnClickAction(@2);
            }
        }];
    }
    return _ticketBtn;
}

-(UIButton *)packetBtn
{
    if (!_packetBtn) {
        _packetBtn = [UIButton buttonWithType:0];
        _packetBtn.frame = CGRectMake(self.ticketBtn.left,2.3*label1H, self.ticketBtn.width,self.ticketBtn.height);
        [_packetBtn setTitle:@"点击使用红包" forState:0];
        [_packetBtn setTitleColor:[UIColor lightGrayColor] forState:0];
        _packetBtn.titleLabel.font = font14;
        _packetBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        ZXWeakSelf;
        [_packetBtn addAction:^(UIButton *btn) {
            if (weakself.btnClickAction) {
                weakself.btnClickAction(@3);
            }
        }];
    }
    return _packetBtn;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
