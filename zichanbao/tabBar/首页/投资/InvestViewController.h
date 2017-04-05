//
//  InvestViewController.h
//  zichanbao
//
//  Created by zhixiang on 15/10/22.
//  Copyright (c) 2015年 zhixiang. All rights reserved.
//

#import "NormalViewController.h"
#import "InvestDetailCommitModel.h"

@interface InvestViewController : NormalViewController

@property (nonatomic,strong)NSString *borrowID; //接收borrow_id
@property (nonatomic,strong)NSString *borrowType; //接收标签名

@property (nonatomic,strong) InvestDetailCommitModel *investModel;



@end
