//
//  UIViewController+BlurView.h
//  zichanbao
//
//  Created by zhixiang on 16/12/28.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (BlurView)

- (void)showBlurInView:(UIView *)view withArray:(NSArray *)array andTitle:(NSString *)title finishBlock:(void(^)(NSString *text,NSInteger row))finishBlock;

- (void)showBlurInView:(UIView *)view withArray:(NSArray *)array withTop:(CGFloat)top finishBlock:(void(^)(NSString *text,NSInteger row))finishBlock;


@end
