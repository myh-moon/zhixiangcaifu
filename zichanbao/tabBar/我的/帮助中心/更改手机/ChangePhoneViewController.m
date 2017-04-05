//
//  ChangePhoneViewController.m
//  zichanbao
//
//  Created by zhixiang on 15/11/3.
//  Copyright (c) 2015年 zhixiang. All rights reserved.
//

#import "ChangePhoneViewController.h"

@interface ChangePhoneViewController ()

@property (nonatomic,strong) UIImageView *changePhoneImageView;
@property (nonatomic,strong) UILabel *changePhoneLabel;
@property (nonatomic,strong) UILabel *remindLabel;

@end

@implementation ChangePhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = self.leftItem;
    self.navigationItem.title = @"更改手机号";
    
    [self.view addSubview:self.changePhoneImageView];
    [self.view addSubview:self.changePhoneLabel];
    [self.view addSubview:self.remindLabel];

}

#pragma mark - init
-(UIImageView *)changePhoneImageView
{
    if (!_changePhoneImageView) {
        _changePhoneImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/3, kScreenWidth/3, kScreenWidth/3, kScreenWidth/3)];
        _changePhoneImageView.image = [UIImage imageNamed:@"finishi"];
    }
    return _changePhoneImageView;
}

-(UILabel *)changePhoneLabel
{
    if (!_changePhoneLabel) {
        _changePhoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.changePhoneImageView.bottom, kScreenWidth, 50)];
        _changePhoneLabel.textAlignment = NSTextAlignmentCenter;
        
        NSString *phoneS = self.changeTelDic[@"tel"];
        NSString *changeString = [NSString stringWithFormat:@"您的手机号码：%@\n已绑定",phoneS];
        
        NSMutableAttributedString *changeAttributeString = [[NSMutableAttributedString alloc] initWithString:changeString];
        
        [changeAttributeString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blackColor]} range:NSMakeRange(0, 7)];
        [changeAttributeString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:kNavigationColor} range:NSMakeRange(7, phoneS.length)];
        [changeAttributeString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blackColor]} range:NSMakeRange(changeString.length-3, 3)];
        
        [_changePhoneLabel setAttributedText:changeAttributeString];
        _changePhoneLabel.numberOfLines = 0;
    }
    return _changePhoneLabel;
}

-(UILabel *)remindLabel
{
    if (!_remindLabel) {
        _remindLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, self.view.bottom-64-80, kScreenWidth-20*2, 60)];
        _remindLabel.text = self.changeTelDic[@"info"];
//        _remindLabel.text = @"需要解绑或更换手机号码，请使用电脑访问www.zhixiangcf.com，在“用户中心－安全设置”内找到“绑定手机”进行修改";
        _remindLabel.numberOfLines = 0;
        _remindLabel.font = font14;
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
