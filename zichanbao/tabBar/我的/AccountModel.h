//
//  AccountModel.h
//  zichanbao
//
//  Created by zhixiang on 15/12/2.
//  Copyright © 2015年 zhixiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface AccountModel : BaseModel
//借款账户信息
@property (nonatomic,copy) NSString *now_borrow_count;//当前借款笔数
@property (nonatomic,copy) NSString *borrow_count;  //累计借款笔数
@property (nonatomic,copy) NSString *ljlx;  //累计利息
@property (nonatomic,copy) NSString *borrow_money; //借款总额
@property (nonatomic,copy) NSString *nreceive_capital;  //待还本金
@property (nonatomic,copy) NSString *nreceive_interest;  //待还利息
@property (nonatomic,copy) NSString *receive_capital;  //已还本金
@property (nonatomic,copy) NSString *receive_interest;  //已还利息

//理财账户信息
@property (nonatomic,copy) NSString *now_money;  //可用总额
@property (nonatomic,copy) NSString *packets_moneys;  //红包金额
@property (nonatomic,copy) NSString *now_borrow_money; //当前借款总额
@property (nonatomic,copy) NSString *total;  //投资总额
@property (nonatomic,copy) NSString *dslx;  //待收利息
@property (nonatomic,copy) NSString *dsbj;  //待收本金
@property (nonatomic,copy) NSString *money_freeze;  //冻结金额
@property (nonatomic,copy) NSString *score;   //积分

@end

