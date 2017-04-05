//
//  MyBorrowView.h
//  zichanbao
//
//  Created by zhixiang on 15/11/14.
//  Copyright © 2015年 zhixiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MineMoneyView.h"

@interface MyBorrowView : UIView

@property (nonatomic,strong) MineMoneyView *bMoneyView;

@property (nonatomic,strong) void (^didSelectedRow)(NSInteger);
@property (nonatomic,strong) void (^btnClickAction)(NSNumber *);

@end
