//
//  InvestSecondSubView.h
//  zichanbao
//
//  Created by zhixiang on 15/12/11.
//  Copyright © 2015年 zhixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InvestSecondSubView : UIView
@property (nonatomic,strong) UITextField *moneyTextField;
@property (nonatomic,strong) UIButton *ticketBtn;
@property (nonatomic,strong) UIButton *packetBtn;


@property (nonatomic,strong) void (^btnClickAction)(NSNumber *);

-(id)initWithFrame:(CGRect)frame;

@end
