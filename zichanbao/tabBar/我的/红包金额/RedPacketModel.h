//
//  RedPacketModel.h
//  zichanbao
//
//  Created by zhixiang on 16/1/6.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RedPacketModel : NSObject

//收到的
@property (nonatomic,copy) NSString *phone;   //用户
@property (nonatomic,copy) NSString *atime;  //开始时间
@property (nonatomic,copy) NSString *exp_time; //有效期
@property (nonatomic,copy) NSString *umoney;
@property (nonatomic,copy) NSString *type;

//发出的
@property (nonatomic,copy) NSString *addtime;//获得时间
@property (nonatomic,copy) NSString *c; //拆开的红包
@property (nonatomic,copy) NSString *number; //总共红包
@property (nonatomic,copy) NSString *url;

@property (nonatomic,copy) NSString *status;
@property (nonatomic,copy) NSString *borrow_id;
@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *obid;
@property (nonatomic,copy) NSString *pid;

@end
