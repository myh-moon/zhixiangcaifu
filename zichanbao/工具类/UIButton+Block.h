//
//  UIButton+Block.h
//  zichanbao
//
//  Created by zhixiang on 17/1/5.
//  Copyright © 2017年 zhixiang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ButtonBlock)(UIButton *btn);

@interface UIButton (Block)


-(void)addAction:(ButtonBlock)block;
-(void)addAction:(ButtonBlock)block forControlEvents:(UIControlEvents)controlEvents;


@end
