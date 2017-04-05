//
//  InvestModel.h
//  zichanbao
//
//  Created by zhixiang on 16/1/8.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InvestModel : NSObject


@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *borrow_name;  //标名
@property (nonatomic,copy) NSString *borrow_duration;  //期限
@property (nonatomic,copy) NSString *borrow_money; //金额
@property (nonatomic,copy) NSString *borrow_interest_rate;  //比率
@property (nonatomic,copy) NSString *vouch_member; //图片
@property (nonatomic,copy) NSString *borrow_type; //类型
@property (nonatomic,copy) NSString *progress;  //进度
@property (nonatomic,copy) NSString *type;    //类型

@end
