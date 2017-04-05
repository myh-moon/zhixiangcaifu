//
//  UIViewController+HUD.h
//  zichanbao
//
//  Created by zhixiang on 17/1/4.
//  Copyright © 2017年 zhixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (HUD)


- (void)showHudInView:(UIView *)view hint:(NSString *)hint;

- (void)hideHud;

- (void)showHint:(NSString *)hint;

- (void)showSuitHint:(NSString *)hint;

// 从默认(showHint:)显示的位置再往上(下)yOffset
- (void)showHint:(NSString *)hint yOffset:(float)yOffset;

@end
