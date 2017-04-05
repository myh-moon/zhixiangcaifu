//
//  InvestDetailCommitModel.m
//  zichanbao
//
//  Created by zhixiang on 16/1/13.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import "InvestDetailCommitModel.h"

@implementation InvestDetailCommitModel

+(NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"account_money" : @"product.account_money",
             @"all" : @"product.all",
             @"borrow_duration" : @"product.borrow_duration",
             @"borrow_interest_rate" : @"product.borrow_interest_rate",
             @"borrow_min" : @"product.borrow_min",
             @"borrow_money" : @"product.borrow_money",
             @"borrow_name"  : @"product.borrow_name",
             @"borrow_type" : @"product.borrow_type",
             @"code"  : @"product.code",
             @"packet" : @"product.packet",
             @"pid" : @"product.pid",
             @"progress" : @"product.progress",
             @"repayment_type" : @"product.repayment_type",
             @"sy_money" : @"product.sy_money",
             @"ticket" : @"product.ticket",
             @"type" : @"product.type",
             @"url" : @"product.url"
             };
}

@end
