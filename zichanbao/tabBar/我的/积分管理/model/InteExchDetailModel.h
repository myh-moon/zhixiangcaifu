//
//  InteExchDetailModel.h
//  zichanbao
//
//  Created by zhixiang on 16/11/10.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import "BaseModel.h"
@class InteExchModel;
@class AddressModel;

@interface InteExchDetailModel : BaseModel

@property (nonatomic,copy) NSString *money;
@property (nonatomic,copy) NSString *score;
@property (nonatomic,strong) InteExchModel *list; //产品信息
@property (nonatomic,strong) AddressModel *address;  //默认地址

@end
