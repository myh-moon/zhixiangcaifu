//
//  AddCardViewController.h
//  zichanbao
//
//  Created by zhixiang on 16/1/8.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import "NormalViewController.h"

//typedef void (^ReturnTextBlock)(NSString *isRefrsh);

@interface AddCardViewController : NormalViewController

@property (nonatomic,strong) NSDictionary *bankListDic;
@property (nonatomic,strong) NSDictionary *authentyDic;

@property (nonatomic,strong) NSString *whickView;

//@property (nonatomic,copy) ReturnTextBlock returnTextBlock;
//
//-(void)returnText:(ReturnTextBlock)block;













@end
