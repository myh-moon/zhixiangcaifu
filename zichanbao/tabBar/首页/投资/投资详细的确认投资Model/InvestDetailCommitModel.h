//
//  InvestDetailCommitModel.h
//  zichanbao
//
//  Created by zhixiang on 16/1/13.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InvestDetailCommitModel : BaseModel

@property (nonatomic,copy) NSString *account_money;
@property (nonatomic,copy) NSString *all;
@property (nonatomic,copy) NSString *borrow_duration;
@property (nonatomic,copy) NSString *borrow_interest_rate;
@property (nonatomic,copy) NSString *borrow_min;
@property (nonatomic,copy) NSString *borrow_money;
@property (nonatomic,copy) NSString *borrow_name;
@property (nonatomic,copy) NSString *borrow_type;
@property (nonatomic,copy) NSString *code;  //分享码
@property (nonatomic,copy) NSString *packet; //红包
@property (nonatomic,copy) NSString *pid;  //红包参数
@property (nonatomic,copy) NSString *progress; //进度
@property (nonatomic,copy) NSString *repayment_type;
@property (nonatomic,copy) NSString *sy_money;
@property (nonatomic,copy) NSString *ticket;  //投资券
@property (nonatomic,copy) NSString *type;
@property (nonatomic,copy) NSString *url;

@end
