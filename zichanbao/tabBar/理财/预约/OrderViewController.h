//
//  OrderViewController.h
//  zichanbao
//
//  Created by zhixiang on 15/11/17.
//  Copyright © 2015年 zhixiang. All rights reserved.
//

#import "NormalViewController.h"
#import "InvestDetailCommitOrderModel.h"

@interface OrderViewController : NormalViewController
//接受传过来的borrow_id
@property (nonatomic,strong) NSString *borrowID;
@property (nonatomic,strong) NSString *borrowType;
@property (nonatomic,strong) InvestDetailCommitOrderModel *orderModel;

@end
