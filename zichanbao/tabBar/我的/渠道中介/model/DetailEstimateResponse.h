//
//  DetailEstimateResponse.h
//  zichanbao
//
//  Created by zhixiang on 17/1/4.
//  Copyright © 2017年 zhixiang. All rights reserved.
//

#import "BaseModel.h"
@class BillModel;

@interface DetailEstimateResponse : BaseModel

@property (nonatomic,strong)  BillModel *list;

@end
