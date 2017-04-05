//
//  InvestDetailCommitOrderModel.m
//  zichanbao
//
//  Created by zhixiang on 16/1/13.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import "InvestDetailCommitOrderModel.h"

@implementation InvestDetailCommitOrderModel

+(NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"borrow_duration" : @"product.borrow_duration",
             @"borrow_interest_rate" : @"product.borrow_interest_rate",
             @"borrow_min" : @"product.borrow_min",
             @"borrow_money" : @"product.borrow_money",
             @"borrow_name"  : @"product.borrow_name",
             @"borrow_type" : @"product.borrow_type",
             @"name"  : @"product.name",
             @"phone" : @"product.phone",
             @"progress" : @"product.progress",
             @"repayment_type" : @"product.repayment_type",
             @"sy_money" : @"product.sy_money",
             @"url" : @"product.url",
             @"type" : @"product.type"
             };
}

@end
