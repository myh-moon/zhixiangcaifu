//
//  PlanResponseModel.h
//  zichanbao
//
//  Created by zhixiang on 16/10/18.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlanResponseModel : NSObject

@property (nonatomic,copy) NSString *dsbx;  //利息
@property (nonatomic,copy) NSString *k;  //日期
@property (nonatomic,strong) NSMutableArray *l;  
@end
