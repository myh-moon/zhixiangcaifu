//
//  RedPacketDetailViewController.m
//  zichanbao
//
//  Created by zhixiang on 16/1/19.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import "RedPacketDetailViewController.h"
#import "NSDate+FormatterTime.h"

@interface RedPacketDetailViewController ()

@property (nonatomic,strong) UIImageView *topImageView;
@property (nonatomic,strong) UILabel *mainLabel;
@property (nonatomic,strong) UILabel *remindLabel;

@end

@implementation RedPacketDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"红包详情";
    self.navigationItem.leftBarButtonItem = self.leftItem;
    
    [self.view addSubview:self.topImageView];
    [self.view addSubview:self.mainLabel];
    [self.view addSubview:self.remindLabel];
}

-(UIImageView *)topImageView
{
    if (!_topImageView) {
        _topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 30, kScreenWidth-50*2, 100)];
        _topImageView.backgroundColor = kNavigationColor;
    }
    return _topImageView;
}

-(UILabel *)mainLabel
{
    if (!_mainLabel) {
        _mainLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.topImageView.bottom+20, kScreenWidth, 40)];
        _mainLabel.textAlignment = NSTextAlignmentCenter;
        NSString *mainStr1 = [NSString stringWithFormat:@"%@个红包已被拆开",@"3"];
        NSString *mainStr2 = [NSString stringWithFormat:@"还剩%@个",@"7"];
        NSString *mainStr = [NSString stringWithFormat:@"%@\n%@",mainStr1,mainStr2];
        
        NSMutableAttributedString *mutStr = [[NSMutableAttributedString alloc] initWithString:mainStr];
        [mutStr addAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:12]} range:NSMakeRange(0, mainStr1.length)];
        [mutStr addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:font14} range:NSMakeRange(mainStr1.length, mainStr2.length)];
        [_mainLabel setAttributedText:mutStr];
    }
    return _mainLabel;
}

-(UILabel *)remindLabel
{
    if (!_remindLabel) {
        _remindLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.mainLabel.bottom+50, kScreenWidth, 90)];
        _remindLabel.textAlignment = NSTextAlignmentCenter;
        _remindLabel.textColor = [UIColor grayColor];
        _remindLabel.font = [UIFont systemFontOfSize:12];
        
        NSString *gettimeStr = [NSString stringWithFormat:@"获得时间：%@",[NSDate getYMDhmsFormatterTime:self.redModel.exp_time]];
        NSString *validtimeStr = [NSString stringWithFormat:@"有效期限：%@",[NSDate getYMDhmsFormatterTime:self.redModel.atime]];
        NSString *sourceStr = [NSString stringWithFormat:@"红包来源：%@",self.redModel.phone];
        NSString *remindStr = [NSString stringWithFormat:@"%@\n%@\n%@",gettimeStr,validtimeStr,sourceStr];
        _remindLabel.text = remindStr;
    }
    return _remindLabel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
