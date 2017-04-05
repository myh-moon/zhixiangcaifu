//
//  MyInvestDetailRecordModel.h
//  zichanbao
//
//  Created by zhixiang on 16/1/14.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyInvestDetailRecordModel : NSObject

@property (nonatomic,copy) NSString *deadline;
@property (nonatomic,copy) NSString *status;

@property (nonatomic,copy) NSString *phone;  //投资人
@property (nonatomic,copy) NSString *borrow_name; //投资人
@property (nonatomic,copy) NSString *interest; //投标利息
@property (nonatomic,copy) NSString *time; //投资时间
@property (nonatomic,copy) NSString *capital;  //投标金额

@end
