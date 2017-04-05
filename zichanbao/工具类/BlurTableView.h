//
//  BlurTableView.h
//  zichanbao
//
//  Created by zhixiang on 16/12/28.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlurTableView : UITableView<UITableViewDataSource,UITableViewDelegate>

/* 动态数据 */
@property (nonatomic,strong) NSArray *blurDataList;
@property (nonatomic,strong) NSLayoutConstraint *heightTableConstraints;
@property (nonatomic,strong) NSString *tableType; //1-从屏幕底开始，2-从屏幕顶开始
@property (nonatomic,strong) NSString *upwardTitleString;  //选择的类型


@property (nonatomic,strong) void (^didSelectedRow)(NSString *text,NSInteger indexRow);
@property (nonatomic,strong) void (^didSelectedButton)(NSInteger);


@end
