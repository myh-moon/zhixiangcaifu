//
//  MineReceiptAddressViewController.h
//  zichanbao
//
//  Created by zhixiang on 16/11/10.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import "NormalViewController.h"
#import "AddressModel.h"

@interface MineReceiptAddressViewController : NormalViewController

@property (nonatomic,strong) void (^didSelectedRow)(AddressModel *);

@end
