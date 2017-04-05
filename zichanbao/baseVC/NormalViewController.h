//
//  NormalViewController.h
//  zichanbao
//
//  Created by zhixiang on 16/1/7.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface NormalViewController : BaseViewController

-(void)requestDataPostWithUrlString:(NSString *)urlString andParams:(NSDictionary *)params andSuccessBlock:(void(^)(id responseObject))successBlock  andFailedBlock:(void(^)())failedBlock;

-(void)requestDataGetWithUrlString:(NSString *)urlString paramter:(NSDictionary *)params  SucceccBlock:(void(^)(id responseObject))successBlock andFailedBlock:(void(^)())failedBlock;

@end
