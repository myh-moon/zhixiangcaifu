//
//  MarqueeView.m
//  zichanbao
//
//  Created by zhixiang on 15/12/10.
//  Copyright © 2015年 zhixiang. All rights reserved.
//

#import "MarqueeView.h"

@interface MarqueeView ()

@property (nonatomic,strong) UILabel *marqueeLabel;

@property (nonatomic,strong) UILabel *showLabel1;
@property (nonatomic,strong) UILabel *showLabel2;
@property (nonatomic,strong) UILabel *showLabel3;

@end

@implementation MarqueeView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.marqueeLabel];
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(UILabel *)marqueeLabel
{
    if (!_marqueeLabel) {
        _marqueeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
        _marqueeLabel.font = font14;
        _marqueeLabel.textColor = [UIColor whiteColor];
        _marqueeLabel.numberOfLines = 0;
        
        [_marqueeLabel addSubview:self.showLabel1];
        [_marqueeLabel addSubview:self.showLabel2];
        [_marqueeLabel addSubview:self.showLabel3];
        
    }
    return _marqueeLabel;
}

-(UILabel *)showLabel1
{
    if (!_showLabel1) {
        _showLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth*2/3, self.marqueeLabel.height)];
        _showLabel1.font = font14;
        _showLabel1.numberOfLines = 0;
        _showLabel1.textColor = [UIColor whiteColor];
        _showLabel1.text = @"用户名：123456789009 \n2015-12-12投资1000元";
    }
    return _showLabel1;
}

-(UILabel *)showLabel2
{
    if (!_showLabel2) {
        _showLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(self.showLabel1.right, self.showLabel1.top, self.showLabel1.width, self.showLabel1.height)];
        _showLabel2.font = font14;
        _showLabel2.textColor = [UIColor whiteColor];
        _showLabel2.numberOfLines = 0;
        _showLabel2.text = @"用户名：张某某\n于2016-09-90投资500元";
    }
    return _showLabel2;
}

-(UILabel *)showLabel3
{
    if (!_showLabel3) {
        _showLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(self.showLabel2.right, self.showLabel1.top, self.showLabel1.width, self.showLabel1.height)];
        _showLabel3.font = font14;
        _showLabel3.textColor = [UIColor whiteColor];
        _showLabel3.numberOfLines = 0;
        _showLabel3.text = @"用户名：13355**343\n于2016-07-08投资10000元";
    }
    return _showLabel3;
}

-(void)addMarqueeList
{
    if (self.marqueeArray.count) {
        
        NSString *text = nil;
        
//        for (int i=0; i<self.marqueeArray.count; i++) {
//            if (i == 0) {
//                text = self.marqueeArray[i];
//            }else{
//                text = [NSString stringWithFormat:@"%@\n%@",text,self.marqueeArray[i]];
//            }
//        }
        
        CGRect rect = self.marqueeLabel.frame;
        
        [self.marqueeLabel setFrame:rect];
        [self.marqueeLabel setText:text];
        
        if (self.timer == nil) {
            self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(handleTimer:) userInfo:nil repeats:YES];
        }
    }
}

-(void)handleTimer:(id)sender
{
    if (self.marqueeArray.count) {
        CGRect newFrame = self.marqueeLabel.frame;

        if (newFrame.origin.x < -newFrame.size.width) {
            newFrame.origin.x = kScreenWidth;
        }else{
            newFrame.origin.x = newFrame.origin.x-1;
        }
        
        [self.marqueeLabel setFrame:newFrame];
    }
}

-(NSMutableArray *)marqueeArray
{
    if (!_marqueeArray) {
        _marqueeArray = [NSMutableArray array];
        [_marqueeArray addObject:@"直向投资v 部位是 v 披萨 v不出来上班 v 了成事不足不是 LJDBv 说"];
        [_marqueeArray addObject:@"放心无忧sdUDgcwuegh wefgwuaeguweih北京航班 v 饿"];
    }
    return _marqueeArray;
}

//-(NSTimer *)timer
//{
//    if (!_timer) {
//        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(handleTimer:) userInfo:nil repeats:YES];
//    }
//    return _timer;
//}

@end
