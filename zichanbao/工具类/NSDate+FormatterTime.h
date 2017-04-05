//
//  NSDate+FormatterTime.h
//  Connotation
//
//  Created by LJ on 14-12-26.
//  Copyright (c) 2014年 你懂的. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (FormatterTime)
+ (NSString *)getFormatterTime:(NSString *)timeInterval;

+ (NSString *)getYMDhmsFormatterTime:(NSString *)timeInterval;

+ (NSString *)getYMDFormatterTime:(NSString *)timeInterval;

+ (NSString *)getMDhmFormatterTime:(NSString *)timeInterval;

+ (NSString *)getYMDhmFormatterTime:(NSString *)timeInterval;

+ (NSString *)getMDFormatterTime:(NSString *)timeInterval;

+ (NSString *)getOtherYMDhmsFormatterTime:(NSString *)timeInterval;


@end
