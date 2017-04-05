//
//  MyLoanModel.h
//  zichanbao
//
//  Created by zhixiang on 16/1/18.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyLoanModel : NSObject

@property (nonatomic,copy) NSString *borrow_interest_rate;
@property (nonatomic,copy) NSString *borrow_money;
@property (nonatomic,copy) NSString *borrow_name;
@property (nonatomic,copy) NSString *borrow_type;
@property (nonatomic,copy) NSString *borrow_duration;
@property (nonatomic,copy) NSString *repayment_type;
@property (nonatomic,copy) NSString *status;

@end
