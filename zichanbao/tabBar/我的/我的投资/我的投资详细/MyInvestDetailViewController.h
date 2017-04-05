//
//  MyInvestDetailViewController.h
//  zichanbao
//
//  Created by zhixiang on 15/11/17.
//  Copyright © 2015年 zhixiang. All rights reserved.
//

#import "NormalViewController.h"

@interface MyInvestDetailViewController : NormalViewController


@property (nonatomic,strong) NSString *idString;//投资详情需要的ID
@property (nonatomic,strong) NSString *borrowID;  //接受传过来的borrow_id（还款方案需要的ID）
@property (nonatomic,strong) NSString *statusType;
@property (nonatomic,strong) NSString *borrowType;

@property (assign, nonatomic)  NSInteger index;  //通过BTN的tag判断哪种状态
@property (nonatomic,strong)NSString *borrowStatus;  //接受传过来的状态

@end
