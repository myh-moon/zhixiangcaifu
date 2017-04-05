//
//  MyFinancialView.h
//  zichanbao
//
//  Created by zhixiang on 15/11/14.
//  Copyright © 2015年 zhixiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MineMoneyView.h"
@interface MyFinancialView : UIView

@property (nonatomic,strong) MineMoneyView *fMoneyView;  //理财账户header

@property (nonatomic,strong) void (^didSelectedRow)(NSIndexPath *);
@property (nonatomic,strong) void (^btnClickAction)(NSNumber *);

@end
