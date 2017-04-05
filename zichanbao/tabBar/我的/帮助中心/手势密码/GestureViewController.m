//
//  GestureViewController.m
//  zichanbao
//
//  Created by zhixiang on 15/10/27.
//  Copyright (c) 2015年 zhixiang. All rights reserved.
//

#import "GestureViewController.h"

@interface GestureViewController ()

@property (nonatomic,strong) UILabel *gestureWhiteLabel;
@property (nonatomic,strong) UIButton *gestureWhiteButton;

@property (nonatomic,strong) UISwitch *gestureSwitch;

@property (nonatomic,strong) UILabel *reLabel;
@end

@implementation GestureViewController


-(void)viewWillAppear:(BOOL)animated
{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"gesture"] isEqualToString:@"1"]) {
    [self.gestureSwitch setOn:YES animated:YES];
    [self.reLabel setHidden:YES];
    }else{
        [self.gestureWhiteButton setHidden:YES];
        [self.gestureSwitch setOn:NO animated:YES];
        [self.reLabel setHidden:NO];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"手势密码";
    self.view.backgroundColor = kBackgroundColor;
    self.navigationItem.leftBarButtonItem = self.leftItem;

    [self.view addSubview:self.gestureWhiteLabel];
    [self.view addSubview:self.gestureSwitch];
    [self.view addSubview:self.gestureWhiteButton];
    [self.view addSubview:self.reLabel];
    
}

-(UILabel *)gestureWhiteLabel
{
    if (!_gestureWhiteLabel) {
        _gestureWhiteLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, 40)];
        _gestureWhiteLabel.backgroundColor = [UIColor whiteColor];
        [_gestureWhiteLabel addSubview:self.gestureSwitch];
        _gestureWhiteLabel.text = @"   手势密码";
        _gestureWhiteLabel.font = font14;
        _gestureWhiteLabel.textColor = [UIColor blackColor];
        _gestureWhiteLabel.userInteractionEnabled = YES;
    }
    return _gestureWhiteLabel;
}

-(UISwitch *)gestureSwitch
{
    if (!_gestureSwitch) {
        _gestureSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(kScreenWidth-60, self.gestureWhiteLabel.top+5, 40, 30)];
        
        //圆形按钮颜色
        _gestureSwitch.thumbTintColor = kBackgroundColor;
        [_gestureSwitch setOn:NO animated:YES];
        
        _gestureSwitch.tintColor = [UIColor grayColor];
        _gestureSwitch.onTintColor = kNavigationColor;
        [_gestureSwitch addTarget:self action:@selector(switchChoose:) forControlEvents:UIControlEventValueChanged];
    }
    return _gestureSwitch;
}

-(UIButton *)gestureWhiteButton
{
    if (!_gestureWhiteButton) {
        _gestureWhiteButton = [UIButton buttonWithType:0];
        _gestureWhiteButton.frame = CGRectMake(0, self.gestureWhiteLabel.bottom+10, kScreenWidth, self.gestureWhiteLabel.height);
        _gestureWhiteButton.alpha = 1;
        _gestureWhiteButton.backgroundColor = [UIColor whiteColor];
        [_gestureWhiteButton setTitle:@"    修改手势" forState:0];
        _gestureWhiteButton.titleLabel.font = font14;
        [_gestureWhiteButton setTitleColor:[UIColor blackColor] forState:0];
        _gestureWhiteButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        UILabel *la = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-30, 10, 20, 20)];
        la.text = @">";
        la.textColor = [UIColor grayColor];
        [_gestureWhiteButton addSubview:la];
        
        ZXWeakSelf;
        [_gestureWhiteButton addAction:^(UIButton *btn) {
            BOOL hasPwd = [CLLockVC hasPwd];
            
            if (!hasPwd) {
                NSLog(@"你还没有设置");
                [weakself showHint:@"您还没有设置手势码，请重新打开"];
            }else{
                [CLLockVC showModifyLockVCInVC:weakself successBlock:^(CLLockVC *lockVC, NSString *pwd) {
                    [lockVC dismiss:.5f];
                }];
            }
        }];
    }
    return _gestureWhiteButton;
}

-(UILabel *)reLabel
{
    if (!_reLabel) {
        //提示信息
        _reLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.gestureWhiteLabel.bottom+15, kScreenWidth, 20)];
        _reLabel.textColor = [UIColor grayColor];
        _reLabel.text = @"进入直向财富手机应用的使用，保护您的帐号安全";
        _reLabel.font = [UIFont systemFontOfSize:12];
        _reLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _reLabel;
}

-(void)switchChoose:(UISwitch *)swit
{
    BOOL isSwitchOn = [swit isOn];
    
    if (isSwitchOn) {
        [self.gestureWhiteButton setHidden:NO];
        [self.reLabel setHidden:YES];
    }else{
        [self.gestureWhiteButton setHidden:YES];
        [self.reLabel setHidden:NO];
    }

    if (isSwitchOn) {
        BOOL hasPwd = [CLLockVC hasPwd];
        if (hasPwd) {
            NSLog(@"已经设置了密码");
        }else{
            [CLLockVC showSettingLockVCInVC:self successBlock:^(CLLockVC *lockVC, NSString *pwd){
                NSLog(@"密码设置成功");
                [self.gestureWhiteButton setHidden:NO];
                [self.reLabel setHidden:YES];
                [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"gesture"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [lockVC dismiss:1.0f];
            }failBlock:^(CLLockVC *lockVC, NSString *pwd) {
                [self.gestureWhiteButton setHidden:YES];
                [self.reLabel setHidden:NO];
                [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"gesture"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [lockVC dismiss:1.0f];
            }];
        }
        
    }else{
        [self.gestureWhiteButton setHidden:YES];
        [self.reLabel setHidden:NO];
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"gesture"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
