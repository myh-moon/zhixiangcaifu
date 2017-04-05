//
//  DetailsCell.h
//  zichanbao
//
//  Created by zhixiang on 15/11/17.
//  Copyright © 2015年 zhixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsCell : UITableViewCell

@property (assign,nonatomic) BOOL didSetupConstraints;
@property (strong, nonatomic) UILabel *topLabel1;
@property (strong, nonatomic) UILabel *topLabel2;
@property (strong, nonatomic) UIButton *topButton3;
@property (nonatomic,strong) UILabel *lineLable1;
@property (nonatomic,strong) UILabel *lineLable2;

@end
