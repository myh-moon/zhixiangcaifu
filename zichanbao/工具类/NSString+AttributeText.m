//
//  NSString+AttributeText.m
//  zichanbao
//
//  Created by zhixiang on 16/10/19.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import "NSString+AttributeText.h"

@implementation NSString (AttributeText)

+ (NSMutableAttributedString *)getStringFromFirstString:(NSString *)firstString andFirstColor:(UIColor *)firstColor andFirstFont:(UIFont *)firstFont ToSecondString:(NSString *)secondString andSecondColor:(UIColor *)secondColor andSecondFont:(UIFont *)secondFont
{
    NSString *baseString = [NSString stringWithFormat:@"%@%@",firstString,secondString];
    NSMutableAttributedString *attributeBaseString = [[NSMutableAttributedString alloc] initWithString:baseString];
    
    [attributeBaseString setAttributes:@{NSFontAttributeName:firstFont,NSForegroundColorAttributeName:firstColor} range:NSMakeRange(0, firstString.length)];
    [attributeBaseString setAttributes:@{NSFontAttributeName:secondFont,NSForegroundColorAttributeName:secondColor} range:NSMakeRange(firstString.length, secondString.length)];
    return attributeBaseString;
}

@end
