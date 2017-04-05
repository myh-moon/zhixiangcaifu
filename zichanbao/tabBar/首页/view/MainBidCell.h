//
//  MainBidCell.h
//  zichanbao
//
//  Created by zhixiang on 17/1/3.
//  Copyright © 2017年 zhixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainBidCell : UITableViewCell

@property (nonatomic,assign) BOOL didSetupConstraints;
@property (nonatomic,strong) UIButton *codeButton;//code
@property (nonatomic,strong) UIButton *typeButton;  //推荐，热门
@property (nonatomic,strong) UILabel *linesLabel;
@property (nonatomic,strong) UILabel *contenLabel1;
@property (nonatomic,strong) UILabel *contenLabel2;
@property (nonatomic,strong) UILabel *contenLabel3;
@property (nonatomic,strong) UIProgressView *progressView;
@property (nonatomic,strong) UILabel *progressTagLabel;
@property (nonatomic,strong) UIButton *actionButton; //投资，预约

@end
