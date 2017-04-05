//
//  PlanModel.h
//  zichanbao
//
//  Created by zhixiang on 16/1/22.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import "BaseModel.h"

@interface PlanModel : BaseModel

@property (nonatomic,copy) NSString *capital;
@property (nonatomic,copy) NSString *interest;
@property (nonatomic,copy) NSString *time;
@property (nonatomic,copy) NSString *title;

@end
