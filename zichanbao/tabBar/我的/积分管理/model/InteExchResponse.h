//
//  InteExchResponse.h
//  zichanbao
//
//  Created by zhixiang on 16/11/9.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import "BaseModel.h"

@interface InteExchResponse : BaseModel

@property (nonatomic,copy) NSString *score;  //我的积分
@property (nonatomic,copy) NSString *url;  //规则
@property (nonatomic,copy) NSString *vip;  //会员等级
@property (nonatomic,strong) NSMutableArray *jf;  //积分等级
@property (nonatomic,strong) NSMutableArray *list;  //推荐产品列表

@end
