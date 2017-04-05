//
//  UIButton+Block.m
//  zichanbao
//
//  Created by zhixiang on 17/1/5.
//  Copyright © 2017年 zhixiang. All rights reserved.
//

#import "UIButton+Block.h"
#import <objc/runtime.h>


@implementation UIButton (Block)


static char actionTag;

-(void)addAction:(ButtonBlock)block
{
    objc_setAssociatedObject(self, &actionTag, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)addAction:(ButtonBlock)block forControlEvents:(UIControlEvents)controlEvents
{
    objc_setAssociatedObject(self, &actionTag, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)action:(id)sender
{
    //    ButtonBlock blockAction = (ButtonBlock)objc_getAssociatedObject(self, &ActionTag);
    
    ButtonBlock blockAction = objc_getAssociatedObject(self, &actionTag);
    if (blockAction) {
        blockAction(self);
    }
}


@end
