//
//  UIButton+Addition.m
//  zichanbao
//
//  Created by zhixiang on 16/12/28.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import "UIButton+Addition.h"

@implementation UIButton (Addition)

- (void)swapImage
{
    self.transform = CGAffineTransformRotate(self.transform, M_PI);
    self.titleLabel.transform = CGAffineTransformRotate(self.titleLabel.transform, M_PI);
    self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, M_PI);
}

- (void)swapImageOfRightAngle
{
    self.transform = CGAffineTransformRotate(self.transform, M_PI_2);
    self.titleLabel.transform = CGAffineTransformRotate(self.titleLabel.transform, M_PI_2);
    self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, M_PI_2);
    
//    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
//    [btn setTitleEdgeInsets:UIEdgeInsetsMake(btn.imageView.frame.size.height ,-btn.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
//    [btn setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0,0.0, -btn.titleLabel.bounds.size.width)];//图片距离右边框距离减少图片的宽度，其它不边
}

@end
