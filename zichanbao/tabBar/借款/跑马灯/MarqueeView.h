//
//  MarqueeView.h
//  zichanbao
//
//  Created by zhixiang on 15/12/10.
//  Copyright © 2015年 zhixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MarqueeView : UIView

@property (nonatomic,copy) NSMutableArray *marqueeArray;
@property (nonatomic,strong) NSTimer *timer;

-(id)initWithFrame:(CGRect)frame;

-(void)addMarqueeList;
-(void)handleTimer:(id)sender;

@end
