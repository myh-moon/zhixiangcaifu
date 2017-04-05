//
//  IntegrationModel.m
//  zichanbao
//
//  Created by zhixiang on 16/1/25.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import "IntegrationModel.h"

@implementation IntegrationModel

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"sname" : @"goods.name",
             @"simg" : @"goods.simg",
             @"bimg" : @"goods.bimg",
             @"ID" : @"id"
             };
}

@end
