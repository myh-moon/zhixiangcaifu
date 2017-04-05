//
//  InvestDetailModel.h
//  zichanbao
//
//  Created by zhixiang on 16/1/12.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import "BaseModel.h"
#import "InvestDetailRepayList.h"

@interface InvestDetailModel : BaseModel

@property (nonatomic,copy) NSString *borrow_duration;
@property (nonatomic,copy) NSString *borrow_interest_rate;
@property (nonatomic,copy) NSString *borrow_money;
@property (nonatomic,copy) NSString *borrow_name;
@property (nonatomic,copy) NSString *borrow_info;
@property (nonatomic,copy) NSString *borrow_type;
@property (nonatomic,copy) NSString *progress;
@property (nonatomic,copy) NSString *borrow_min;
@property (nonatomic,copy) NSString *sy_money;//剩余总额
@property (nonatomic,copy) NSString *repayment_type;

@property (nonatomic,strong) NSArray *repay_list;
@property (nonatomic,copy) NSString *type;

@end
