//
//  MyInvestDetailModel.m
//  zichanbao
//
//  Created by zhixiang on 16/1/14.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import "MyInvestDetailModel.h"

@implementation MyInvestDetailModel

+(NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"add_time" : @"list.add_time",
             @"borrow_duration" : @"list.borrow_duration",
             @"borrow_info" : @"list.borrow_info",
             @"borrow_interest_rate" : @"list.borrow_interest_rate",
             @"borrow_name" : @"list.borrow_name",
             @"borrow_type" : @"list.borrow_type",
             @"capital" : @"list.capital",
             @"ID" : @"list.id",
             @"interest" : @"list.interest",
             @"phone" : @"list.phone",
             @"progress" : @"list.progress",
             @"repayment_type" : @"list.repayment_type",
             @"time" : @"list.time",
             @"name" : @"list.name"
             };
}

@end
