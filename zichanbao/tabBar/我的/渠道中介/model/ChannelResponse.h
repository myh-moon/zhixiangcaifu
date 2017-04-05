//
//  ChannelResponse.h
//  zichanbao
//
//  Created by zhixiang on 16/12/29.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import "BaseModel.h"

@interface ChannelResponse : BaseModel

@property (nonatomic,strong) NSMutableArray *list;
@property (nonatomic,copy) NSString *estate_all;
@property (nonatomic,copy) NSString *comeinpiece_all;
@property (nonatomic,copy) NSString *has_borrow_all;
@property (nonatomic,copy) NSString *commission_yes_all;
@property (nonatomic,copy) NSString *commission_no_all;

@end
