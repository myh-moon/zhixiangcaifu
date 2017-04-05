//
//  NSString+AttributeText.h
//  zichanbao
//
//  Created by zhixiang on 16/10/19.
//  Copyright © 2016年 zhixiang. All rights reserved.
//



@interface NSString (AttributeText)

+ (NSMutableAttributedString*)getStringFromFirstString:(NSString *)firstString andFirstColor:(UIColor *)firstColor andFirstFont:(UIFont *)firstFont ToSecondString:(NSString *)secondString  andSecondColor:(UIColor *)secondColor andSecondFont:(UIFont *)secondFont;

@end
