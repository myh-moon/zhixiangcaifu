//
//  NSDate+FormatterTime.m
//  Connotation
//
//  Created by LJ on 14-12-26.
//  Copyright (c) 2014年 你懂的. All rights reserved.
//

#import "NSDate+FormatterTime.h"

@implementation NSDate (FormatterTime)

+ (NSString *)getFormatterTime:(NSString *)timeInterval
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    //处理模型数据时间
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeInterval doubleValue]];
    NSString *dateSMS = [dateFormatter stringFromDate:date];
    //获取当前时间
        [dateFormatter setDateFormat:@"MM-dd HH:mm"];
        dateSMS = [dateFormatter stringFromDate:date];
    
    return dateSMS;
}

+ (NSString *)getYMDhmsFormatterTime:(NSString *)timeInterval
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    //处理模型数据时间
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeInterval doubleValue]];
    NSString *dateSMS = [dateFormatter stringFromDate:date];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    dateSMS = [dateFormatter stringFromDate:date];
    return dateSMS;
}

+ (NSString *)getYMDFormatterTime:(NSString *)timeInterval
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    //处理模型数据时间
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeInterval doubleValue]];
    NSString *dateSMS = [dateFormatter stringFromDate:date];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    dateSMS = [dateFormatter stringFromDate:date];
    return dateSMS;

}

+ (NSString *)getMDhmFormatterTime:(NSString *)timeInterval
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    //处理模型数据时间
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeInterval doubleValue]];
    NSString *dateSMS = [dateFormatter stringFromDate:date];
    [dateFormatter setDateFormat:@"MM-dd HH:mm"];
    dateSMS = [dateFormatter stringFromDate:date];
    return dateSMS;

}

+ (NSString *)getYMDhmFormatterTime:(NSString *)timeInterval
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    //处理模型数据时间
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeInterval doubleValue]];
    NSString *dateSMS = [dateFormatter stringFromDate:date];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    dateSMS = [dateFormatter stringFromDate:date];
    return dateSMS;

}

+ (NSString *)getMDFormatterTime:(NSString *)timeInterval
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    //处理模型数据时间
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeInterval doubleValue]];
    NSString *dateSMS = [dateFormatter stringFromDate:date];
    [dateFormatter setDateFormat:@"MM-dd"];
    dateSMS = [dateFormatter stringFromDate:date];
    return dateSMS;
}

+(NSString *)getOtherYMDhmsFormatterTime:(NSString *)timeInterval
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    //处理模型数据时间
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeInterval doubleValue]];
    NSString *dateSMS = [dateFormatter stringFromDate:date];
    [dateFormatter setDateFormat:@"YYYYMMddHHmmss"];
    dateSMS = [dateFormatter stringFromDate:date];
    return dateSMS;
}

@end
