//
//  InvestDetailsViewController.h
//  zichanbao
//
//  Created by zhixiang on 15/11/17.
//  Copyright © 2015年 zhixiang. All rights reserved.
//

#import "NormalViewController.h"

@interface InvestDetailsViewController : NormalViewController
@property (assign, nonatomic)  NSInteger index;  //通过BTN的tag判断哪种状态

@property (nonatomic,strong) NSString *borrowType;   //标类型
@property (nonatomic,strong) NSString *type;  //投资类型
@property (nonatomic,copy) NSString *borrowID;  //接受传过来的borrow_id

@end
