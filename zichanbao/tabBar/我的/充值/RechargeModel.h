//
//  RechargeModel.h
//  zichanbao
//
//  Created by zhixiang on 16/1/8.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface RechargeModel : BaseModel

//充值获取验证码
@property (nonatomic,copy) NSString *PaymentNo;
@property (nonatomic,copy) NSString *Paymoney;
@end
