//
//  InteRecordCell.h
//  zichanbao
//
//  Created by zhixiang on 16/11/8.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InteRecordCell : UITableViewCell

@property (nonatomic,assign) BOOL didSetupConstraints;
@property (nonatomic,strong) UIImageView *recordImageView;
@property (nonatomic,strong) UILabel *recordLabel;
@property (nonatomic,strong) UIButton *recordButton;

@end
