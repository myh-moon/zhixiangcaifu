//
//  InvestDetailRecordHomeModel.m
//  zichanbao
//
//  Created by zhixiang on 16/1/12.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import "InvestDetailRecordHomeModel.h"

@implementation InvestDetailRecordHomeModel

+(NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"homeID" : @"id"
             };
}

@end
