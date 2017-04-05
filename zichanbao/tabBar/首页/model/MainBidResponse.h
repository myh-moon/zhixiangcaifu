//
//  MainBidResponse.h
//  zichanbao
//
//  Created by zhixiang on 17/1/5.
//  Copyright © 2017年 zhixiang. All rights reserved.
//

#import "BaseModel.h"

@interface MainBidResponse : BaseModel

@property (nonatomic,strong) NSMutableArray *link;
@property (nonatomic,strong) NSMutableArray *lists;

@end
