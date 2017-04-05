//
//  InvestDetailCommitOrderModel.h
//  zichanbao
//
//  Created by zhixiang on 16/1/13.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InvestDetailCommitOrderModel : NSObject

@property (nonatomic,copy) NSString *borrow_duration;
@property (nonatomic,copy) NSString *borrow_interest_rate;
@property (nonatomic,copy) NSString *borrow_min;
@property (nonatomic,copy) NSString *borrow_money;  //总额
@property (nonatomic,copy) NSString *borrow_name;
@property (nonatomic,copy) NSString *borrow_type;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *phone;
@property (nonatomic,copy) NSString *progress;
@property (nonatomic,copy) NSString *repayment_type;
@property (nonatomic,copy) NSString *sy_money;  //总额
@property (nonatomic,copy) NSString *url;
@property (nonatomic,copy) NSString *type;

@end
