//
//  InvestDetailModel.m
//  zichanbao
//
//  Created by zhixiang on 16/1/12.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import "InvestDetailModel.h"

@implementation InvestDetailModel

+(NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"borrow_duration"      : @"product.borrow_duration",
             @"borrow_interest_rate" : @"product.borrow_interest_rate",
             @"borrow_money"         : @"product.borrow_money",
             @"borrow_name"          : @"product.borrow_name",
             @"borrow_info"          : @"product.borrow_info",
             @"borrow_type"          : @"product.borrow_type",
             @"progress"             : @"product.progress",
             @"borrow_min"           : @"product.borrow_min",
             @"sy_money"             : @"product.sy_money",
             @"repayment_type"       : @"product.repayment_type",
             @"repay_list"           : @"product.repay_list",
             @"type"                 : @"product.type"
             };
}

+(NSDictionary *)objectClassInArray
{
    return @{
             @"repay_list" : @"InvestDetailRepayList"
             };
}

@end
