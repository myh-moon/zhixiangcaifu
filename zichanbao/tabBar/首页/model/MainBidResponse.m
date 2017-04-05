//
//  MainBidResponse.m
//  zichanbao
//
//  Created by zhixiang on 17/1/5.
//  Copyright © 2017年 zhixiang. All rights reserved.
//

#import "MainBidResponse.h"

@implementation MainBidResponse

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"link" : @"product.link",
             @"lists" : @"product.lists"};
}

+ (NSDictionary *)objectClassInArray
{
    return @{@"link" : @"ImageModel",
             @"lists" : @"MainBidModel"};
}

@end
