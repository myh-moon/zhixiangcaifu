//
//  UIView+Fram.m
//  zichanbao
//
//  Created by zhixiang on 15/10/9.
//  Copyright (c) 2015年 zhixiang. All rights reserved.
//

#import "UIView+Fram.h"

@implementation UIView (Fram)

@dynamic left,right,top,bottom,width,height;

-(CGFloat)left
{
    return self.frame.origin.x;
}

-(CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

-(CGFloat)top
{
    return self.frame.origin.y;
}

-(CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

-(CGFloat)width
{
   return self.frame.size.width;
}

-(CGFloat)height
{
    return self.frame.size.height;
}

//-(CGFloat)centerX
//{
//    return self.frame.origin.x + (self.frame.size.width)/2;
//}
//
//-(CGFloat)centerY
//{
//    return self.frame.origin.y + (self.frame.size.height)/2;
//}

@end
