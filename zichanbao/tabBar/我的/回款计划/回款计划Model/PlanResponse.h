//
//  PlanResponse.h
//  zichanbao
//
//  Created by zhixiang on 16/10/18.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import "BaseModel.h"

@interface PlanResponse : BaseModel

//@property (nonatomic,copy) NSString *dsbx;
@property (nonatomic,strong) NSMutableArray *list;
@property (nonatomic,copy) NSString *page;

@end
