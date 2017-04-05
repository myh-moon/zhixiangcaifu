//
//  BillModel.h
//  zichanbao
//
//  Created by zhixiang on 16/12/29.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BillModel : NSObject

//账单
@property (nonatomic,copy) NSString *yearmon; //时间
@property (nonatomic,copy) NSString *estate_num; //评估笔数
@property (nonatomic,copy) NSString *comeinpiece_num;//进件笔数
@property (nonatomic,copy) NSString *has_borrow;//通过金额
@property (nonatomic,copy) NSString *commission_yes;//已返佣金
@property (nonatomic,copy) NSString *commission_no;//未返佣金

//返点
@property (nonatomic,copy) NSString *idString;////////
@property (nonatomic,copy) NSString *uid;
@property (nonatomic,copy) NSString *type;
@property (nonatomic,copy) NSString *affect_money;
@property (nonatomic,copy) NSString *account_money;
@property (nonatomic,copy) NSString *collect_money;
@property (nonatomic,copy) NSString *freeze_money;
@property (nonatomic,copy) NSString *info;
@property (nonatomic,copy) NSString *add_time;
@property (nonatomic,copy) NSString *add_ip;
@property (nonatomic,copy) NSString *target_uid;
@property (nonatomic,copy) NSString *date;

//进件
//@property (nonatomic,copy) NSString *idString;////////
@property (nonatomic,copy) NSString *borrow_money;
@property (nonatomic,copy) NSString *kfuid;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *duration_date;
@property (nonatomic,copy) NSString *apply_date;
@property (nonatomic,copy) NSString *business_type;
@property (nonatomic,copy) NSString *status;


//预估
//@property (nonatomic,copy) NSString *idString;////////
@property (nonatomic,copy) NSString *address;
@property (nonatomic,copy) NSString *spare;
//@property (nonatomic,copy) NSString *add_time; //添加时间
@property (nonatomic,copy) NSString *update_time;//评估时间
@property (nonatomic,copy) NSString *apply_id;  //分配销售
@property (nonatomic,copy) NSString *channel_id;  //提交预估人
@property (nonatomic,copy) NSString *price;  //房产总价
//@property (nonatomic,copy) NSString *status; //状态
@property (nonatomic,copy) NSString *narea; //地下面积
@property (nonatomic,copy) NSString *rent; //年租金
@property (nonatomic,copy) NSString *comple_date; //竣工日期
@property (nonatomic,copy) NSString *layer;  //所在楼层
@property (nonatomic,copy) NSString *unit_id; //评估人
@property (nonatomic,copy) NSString *unit;  //评估单位
@property (nonatomic,copy) NSString *way;  //评估方式
@property (nonatomic,copy) NSString *single_price; //单价／平米


@end
