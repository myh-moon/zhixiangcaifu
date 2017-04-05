//
//  MyOrderModel.m
//  zichanbao
//
//  Created by zhixiang on 16/1/14.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import "MyOrderModel.h"

@implementation MyOrderModel

+(NSArray *)allowedPropertyNames
{
    return @[@"bid",@"bname",@"btype",@"borrow_money",@"duration",@"ID",@"money",@"rate",@"status",@"time",@"type"];
}

+(NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"ID" : @"id"
             };
}

@end
