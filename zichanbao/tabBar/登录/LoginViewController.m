//
//  LoginViewController.m
//  zichanbao
//
//  Created by zhixiang on 15/10/21.
//  Copyright (c) 2015年 zhixiang. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginModel.h"

#import "RegisterViewController.h"  //注册
#import "PasswordFindViewController.h"  //找回密码

#import "JKCountDownButton.h"
#import "LoginSwitchView.h"  //切换view
#import "LoginCodeView.h"  //手机号，验证码


@interface LoginViewController ()<UITextFieldDelegate,MBProgressHUDDelegate>

@property (nonatomic,assign) BOOL didSetupConstraints;
@property (nonatomic,strong) UIImageView *bgImageView1;//上半部分背景
@property (nonatomic,strong) UIButton *existButton;//退出
@property (nonatomic,strong) UIButton *userShowButton;  //普通用户／渠道中介显示
@property (nonatomic,strong) LoginSwitchView *switchView; //切换view

@property (nonatomic,strong) UIImageView *bgImageView2;//下半部分背景
@property (nonatomic,strong) LoginCodeView *phoneView; //手机号
@property (nonatomic,strong) LoginCodeView *codeView;  //验证码

@property (nonatomic,strong) UIButton *forgetButton;  //忘记密码
@property (nonatomic,strong) UIButton *registerButton1; //普通用户注册按钮
@property (nonatomic,strong) UIButton *registerButton2; //渠道中介注册按钮

@property (nonatomic,strong) UIButton *loginButton;  //登录按钮
//@property (nonatomic,strong) UIButton *userSwitchButton;  //用户切换按钮

@property (nonatomic,strong) NSMutableDictionary *loginDataDic;

//@property (nonatomic,strong) UITextField *phoneTextField;  //手机号
//@property (nonatomic,strong) UITextField *passWordTextField;//密码
//@property (nonatomic,strong) UITextField *codeTextField;  //验证码
//@property (nonatomic,strong) JKCountDownButton *countDownButton; //获取验证码
//@property (nonatomic,strong) UIButton *loginBtn;  //登录按钮
//@property (nonatomic,strong) UIButton *registerBtn;  //注册按钮
//@property (nonatomic,strong) UIButton *changeBtn;
// //验证码登录按钮
//@property (nonatomic,strong) UIButton *forgetBtn;  //忘记密码按钮
//
//@property (nonatomic,strong) NSString *whichLogin; //标记是哪种方法登录
//
////等待效果
//@property (nonatomic,strong) UIActivityIndicatorView *activityIndicator;
//
//@property (nonatomic,strong) MBProgressHUD *loginHud;

@end

@implementation LoginViewController
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"登录";
    
    [self.view addSubview:self.bgImageView1];
    [self.view addSubview:self.existButton];
    [self.view addSubview:self.userShowButton];
    [self.view addSubview:self.switchView];
    
    [self.view addSubview:self.bgImageView2];
    [self.view addSubview:self.phoneView];
    [self.view addSubview:self.codeView];
    [self.view addSubview:self.forgetButton];
    [self.view addSubview:self.registerButton1];
    [self.view addSubview:self.registerButton2];
    [self.view addSubview:self.loginButton];
    
    [self.view setNeedsUpdateConstraints];
}

- (void)updateViewConstraints
{
    if (!self.didSetupConstraints) {
        
        [self.bgImageView1 autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
//        [self.bgImageView1 autoSetDimension:ALDimensionHeight toSize:kScreenHeight/3];
        
        [self.existButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:kSmallPadding*2];
        [self.existButton autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:44];
        
        [self.userShowButton autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [self.userShowButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.existButton];
        
        [self.switchView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [self.switchView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [self.switchView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.bgImageView1];
        [self.switchView autoSetDimension:ALDimensionHeight toSize:40];
        
        [self.bgImageView2 autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
        [self.bgImageView2 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.bgImageView1];
        
        [self.phoneView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [self.phoneView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [self.phoneView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.switchView withOffset:kSmallPadding];
        [self.phoneView autoSetDimension:ALDimensionHeight toSize:60];

        [self.codeView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [self.codeView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [self.codeView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.phoneView];
        [self.codeView autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self.phoneView];
        
        [self.forgetButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:kSmallPadding];
        [self.forgetButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.codeView withOffset:kSmallPadding];
        
        [self.registerButton1 autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [self.registerButton1 autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.forgetButton];
        
        [self.registerButton2 autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:kSmallPadding];
        [self.registerButton2 autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.registerButton1];
        
        
        [self.loginButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:kSmallPadding];
        [self.loginButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:kSmallPadding];
        [self.loginButton autoSetDimension:ALDimensionHeight toSize:kCellHeight];
        [self.loginButton autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:kSmallPadding];
        
        self.didSetupConstraints  = YES;
    }
    [super updateViewConstraints];
}

- (UIImageView *)bgImageView1
{
    if (!_bgImageView1) {
        _bgImageView1 = [UIImageView newAutoLayoutView];
        _bgImageView1.image = [UIImage imageNamed:@"bbgone"];
    }
    return _bgImageView1;
}

-(UIButton *)existButton
{
    if (!_existButton) {
        _existButton = [UIButton newAutoLayoutView];
        [_existButton setTitle:@"X" forState:0];
        [_existButton setTitleColor:[UIColor whiteColor] forState:0];
        ZXWeakSelf;
        [_existButton addAction:^(UIButton *btn) {
            if ([weakself.backString integerValue] == 1) {
                UITabBarController *tabBarController = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
                tabBarController.selectedViewController = tabBarController.viewControllers.firstObject;
                
                UITabBar *tabBar = tabBarController.tabBar;
                for (UIButton *item in tabBar.subviews) {
                    if ([item isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
                        item.selected = YES;
                    }
                }
                [weakself dismissViewControllerAnimated:YES completion:nil];
                
            }else{
                [weakself dismissViewControllerAnimated:YES completion:nil];
            }
        }];
    }
    return _existButton;
}

- (UIButton *)userShowButton
{
    if (!_userShowButton) {
        _userShowButton = [UIButton newAutoLayoutView];
        [_userShowButton setImage:[UIImage imageNamed:@"logos"] forState:0];
    }
    return _userShowButton;
}

- (LoginSwitchView *)switchView
{
    if (!_switchView) {
        _switchView = [LoginSwitchView newAutoLayoutView];
        _switchView.backgroundColor = [UIColor clearColor];
        [_switchView.firstButton setTitle:@"帐号登录" forState:0];
        [_switchView.secondButton setTitle:@"验证码登录" forState:0];
        
        ZXWeakSelf;
        [_switchView setDidSelectedButton:^(UIButton *selectedBtn) {
            weakself.codeView.contentTextField.text = nil;
            NSString *ccc;
            switch (selectedBtn.tag) {
                case 111:{//帐号登录
                    ccc = @"请输入密码";
                    [weakself.codeView.getCodeButton setHidden:YES];
                }
                    break;
                case 112:{//验证码登录
                    [weakself.codeView.getCodeButton setHidden:NO];
                    ccc = @"请输入验证码";
                }
                    break;
                default:
                    break;
            }
            NSMutableAttributedString *attributeC = [[NSMutableAttributedString alloc] initWithString:ccc];
            [attributeC setAttributes:@{NSFontAttributeName:font14,NSForegroundColorAttributeName:[UIColor whiteColor]} range:NSMakeRange(0, ccc.length)];
            [weakself.codeView.contentTextField setAttributedPlaceholder:attributeC];
        }];
    }
    return _switchView;
}

- (UIImageView *)bgImageView2
{
    if (!_bgImageView2) {
        _bgImageView2 = [UIImageView newAutoLayoutView];
        _bgImageView2.image = [UIImage imageNamed:@"bbgtwo"];
    }
    return _bgImageView2;
}

- (LoginCodeView *)phoneView
{
    if (!_phoneView) {
        _phoneView = [LoginCodeView newAutoLayoutView];
        [_phoneView.getCodeButton setHidden:YES];
        [_phoneView.imageButton setImage:[UIImage imageNamed:@"shoujihao"] forState:0];
        
        NSString *ccc = @"输入手机号";
        NSMutableAttributedString *attributeC = [[NSMutableAttributedString alloc] initWithString:ccc];
        [attributeC setAttributes:@{NSFontAttributeName:font14,NSForegroundColorAttributeName:[UIColor whiteColor]} range:NSMakeRange(0, ccc.length)];
        [_phoneView.contentTextField setAttributedPlaceholder:attributeC];
        
        ZXWeakSelf;
        [_phoneView setDidEndEditting:^(NSString *text) {
            [weakself.loginDataDic setObject:text forKey:@"user_phone"];
            [weakself.loginDataDic setObject:text forKey:@"phone"];
        }];
    }
    return _phoneView;
}

- (LoginCodeView *)codeView
{
    if (!_codeView) {
        _codeView = [LoginCodeView newAutoLayoutView];
        [_codeView.imageButton setImage:[UIImage imageNamed:@"mima"] forState:0];
        [_codeView.getCodeButton setHidden:YES];
        [_codeView.getCodeButton setTitle:@"获取" forState:0];
        
        NSString *ccc = @"输入密码";
        NSMutableAttributedString *attributeC = [[NSMutableAttributedString alloc] initWithString:ccc];
        [attributeC setAttributes:@{NSFontAttributeName:font14,NSForegroundColorAttributeName:[UIColor whiteColor]} range:NSMakeRange(0, ccc.length)];
        [_codeView.contentTextField setAttributedPlaceholder:attributeC];
        
        //获取验证码
        [_codeView.getCodeButton addTarget:self action:@selector(getPhoneCodeWithButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _codeView;
}


- (UIButton *)forgetButton
{
    if (!_forgetButton) {
        _forgetButton = [UIButton newAutoLayoutView];
        [_forgetButton setTitleColor:[UIColor whiteColor] forState:0];
        [_forgetButton setTitle:@"忘记密码" forState:0];
        _forgetButton.titleLabel.font = font14;
        
        ZXWeakSelf;
        [_forgetButton addAction:^(UIButton *btn) {
            PasswordFindViewController *passwordFindVC = [[PasswordFindViewController alloc] init];
            [weakself.navigationController pushViewController:passwordFindVC animated:YES];
        }];
    }
    return _forgetButton;
}

- (UIButton *)registerButton1
{
    if (!_registerButton1) {
        _registerButton1 = [UIButton newAutoLayoutView];
        [_registerButton1 setTitle:@"普通用户注册        " forState:0];
        [_registerButton1 setTitleColor:[UIColor whiteColor] forState:0];
        _registerButton1.titleLabel.font = font14;
        
        ZXWeakSelf;
        [_registerButton1 addAction:^(UIButton *btn) {
            RegisterViewController *registerVC = [[RegisterViewController alloc] init];
            [weakself.navigationController pushViewController:registerVC animated:YES];
        }];
    }
    return _registerButton1;
}

- (UIButton *)registerButton2
{
    if (!_registerButton2) {
        _registerButton2 = [UIButton newAutoLayoutView];
        [_registerButton2 setTitle:@"渠道中介注册" forState:0];
        [_registerButton2 setTitleColor:[UIColor whiteColor] forState:0];
        _registerButton2.titleLabel.font = font14;
        
        ZXWeakSelf;
        [_registerButton2 addAction:^(UIButton *btn) {
            RegisterViewController *registerVC = [[RegisterViewController alloc] init];
            registerVC.registerType = @"1";
            [weakself.navigationController pushViewController:registerVC animated:YES];
        }];
    }
    return _registerButton2;
}

- (UIButton *)loginButton
{
    if (!_loginButton) {
        _loginButton = [UIButton newAutoLayoutView];
        [_loginButton setTitle:@"登录" forState:0];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:0];
        _loginButton.titleLabel.font = font16;
        [_loginButton setBackgroundColor:RGBCOLOR(0.7765, 0.2902, 0.5647)];
        _loginButton.layer.cornerRadius = 2;
        
        ZXWeakSelf;
        [_loginButton addAction:^(UIButton *btn) {
            [weakself toLoginUser];
        }];
    }
    return _loginButton;
}

- (NSMutableDictionary *)loginDataDic
{
    if (!_loginDataDic) {
        _loginDataDic = [NSMutableDictionary dictionary];
    }
    return _loginDataDic;
}

#pragma mark - request
- (void)toLoginUser
{
    [self.view endEditing:YES];

    NSString *loginString;
    NSDictionary *params;
    
    if (self.switchView.leftLineConstraints.constant == 0) {//帐号登陆
        loginString = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFlogin];
        params = @{@"user_phone" : self.phoneView.contentTextField.text,
                   @"user_pass" : self.codeView.contentTextField.text,
                   @"phone" : @"1"};
    }else if ((self.switchView.leftLineConstraints.constant = kScreenWidth/2)){//验证码登录
        loginString = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFloginCode];
        params = @{@"phone" : self.phoneView.contentTextField.text,
                   @"code" : self.codeView.contentTextField.text,
                   @"is_phone" : @"1"};
    }
    
    ZXWeakSelf;
    [self requestDataPostWithUrlString:loginString andParams:params andSuccessBlock:^(id responseObject) {
        LoginModel *loginModel = [LoginModel objectWithKeyValues:responseObject];
        
        [weakself showHint:loginModel.info];
        
        if ([loginModel.status isEqualToString:@"1"]) {
            //保存token
            [[NSUserDefaults standardUserDefaults] setObject:loginModel.token forKey:@"token"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [weakself dismissViewControllerAnimated:YES completion:nil];
        }
    } andFailedBlock:^{
        
    }];
}

-(void)getPhoneCodeWithButton:(JKCountDownButton *)sender
{
    [self.view endEditing:YES];
    
    NSString *codeString = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFloginSendCode];
    NSDictionary *params = @{@"phone" : self.phoneView.contentTextField.text};
    
    ZXWeakSelf;
    [self requestDataPostWithUrlString:codeString andParams:params andSuccessBlock:^(id responseObject){
        BaseModel *codeModel = [BaseModel objectWithKeyValues:responseObject];
        
        [weakself showHint:codeModel.info];
        
        if ([codeModel.status intValue] == 1) {//发送成功
            [sender startWithSecond:60];
            [sender didChange:^NSString *(JKCountDownButton *countDownButton, int second) {
                sender.enabled = NO;
                NSString *title = [NSString stringWithFormat:@"还剩%d秒",second];
                return title;
            }];
            
            [sender didFinished:^NSString *(JKCountDownButton *countDownButton, int second) {
                countDownButton.enabled = YES;
                return @"获取验证码";
            }];
        }
        
    } andFailedBlock:^{
        
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
