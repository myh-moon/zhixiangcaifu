//
//  NSString+ValidString.m
//  zichanbao
//
//  Created by zhixiang on 16/12/29.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import "NSString+ValidString.h"

@implementation NSString (ValidString)

+ (NSString *)getValidStringFromString:(NSString *)fromString
{
    if (fromString.length == 0 || [fromString isEqualToString:@""]) {
        fromString = @"0";
    }
    return fromString;
}

+ (NSString *)getValidStringFromString:(NSString *)fromString toString:(NSString *)toString
{
    if (fromString.length == 0 || [fromString isEqualToString:@""]) {
        return toString;
    }
    return fromString;
}

@end
