//
//  MainBidModel.h
//  zichanbao
//
//  Created by zhixiang on 17/1/4.
//  Copyright © 2017年 zhixiang. All rights reserved.
//

#import "BaseModel.h"

@interface MainBidModel : BaseModel

@property (nonatomic,copy) NSString *borrow_duration;
@property (nonatomic,copy) NSString *borrow_interest_rate;
@property (nonatomic,copy) NSString *borrow_money;
@property (nonatomic,copy) NSString *borrow_name;
@property (nonatomic,copy) NSString *borrow_type;
@property (nonatomic,copy) NSString *durations;
@property (nonatomic,copy) NSString *has_borrow;
@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *is_day;
@property (nonatomic,copy) NSString *progress;
@property (nonatomic,copy) NSString *type;
@property (nonatomic,copy) NSString *type_name;

@end
