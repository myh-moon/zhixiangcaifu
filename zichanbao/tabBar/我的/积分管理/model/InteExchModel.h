//
//  InteExchModel.h
//  zichanbao
//
//  Created by zhixiang on 16/11/9.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InteExchModel : NSObject

@property (nonatomic,copy) NSString *name;  //名称
@property (nonatomic,copy) NSString *score;  //积分
@property (nonatomic,copy) NSString *smoney; //余额
@property (nonatomic,copy) NSString *money;  //市场价
@property (nonatomic,copy) NSString *number; //总量
@property (nonatomic,copy) NSString *simg;  //小图片
@property (nonatomic,copy) NSString *bimg;  //大图片
@property (nonatomic,copy) NSString *ID;

@property (nonatomic,copy) NSString *remark;  //描述
@end
