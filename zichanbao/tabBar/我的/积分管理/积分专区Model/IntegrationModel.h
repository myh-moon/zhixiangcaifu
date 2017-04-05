//
//  IntegrationModel.h
//  zichanbao
//
//  Created by zhixiang on 16/1/25.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IntegrationModel : NSObject

@property (nonatomic,copy) NSString *address;
@property (nonatomic,copy) NSString *company;
@property (nonatomic,copy) NSString *express;
@property (nonatomic,copy) NSString *gid;
@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *name;  //收货人
@property (nonatomic,copy) NSString *tel; //收货人电话
@property (nonatomic,copy) NSString *score; //购买积分
@property (nonatomic,copy) NSString *money;//购买余额
@property (nonatomic,copy) NSString *number;//购买数量
@property (nonatomic,copy) NSString *time;//购买时间
@property (nonatomic,copy) NSString *simg;//商品小图片
@property (nonatomic,copy) NSString *bimg;//商品大图片
@property (nonatomic,copy) NSString *sname;  //商品名称
@property (nonatomic,copy) NSString *status;//发货状态－未发货，已发货
@property (nonatomic,copy) NSString *url;//快递信息


@end
