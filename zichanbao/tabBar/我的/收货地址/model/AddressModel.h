//
//  AddressModel.h
//  zichanbao
//
//  Created by zhixiang on 16/11/10.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import "BaseModel.h"

@interface AddressModel : BaseModel

@property (nonatomic,copy) NSString *address;
@property (nonatomic,copy) NSString *city;
@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *province;
@property (nonatomic,copy) NSString *tel;
@property (nonatomic,copy) NSString *time;
@property (nonatomic,copy) NSString *type;//0-为默认，1－默认
@property (nonatomic,copy) NSString *uid;
@property (nonatomic,copy) NSString *zip;


@end
