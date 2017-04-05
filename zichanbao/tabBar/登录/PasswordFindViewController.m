//
//  PasswordFindViewController.m
//  zichanbao
//
//  Created by zhixiang on 15/10/26.
//  Copyright (c) 2015年 zhixiang. All rights reserved.
//

#import "PasswordFindViewController.h"
#import "JKCountDownButton.h"
#import "BasicButton.h"
#import "BaseModel.h"

@interface PasswordFindViewController ()<UITextFieldDelegate>

@property (nonatomic,assign) BOOL didSetupConstraint;
@property (nonatomic,strong) UIView *whiteView;
@property (nonatomic,strong) BasicButton *commitBtn;

@end

@implementation PasswordFindViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"找回密码";
    self.view.backgroundColor = kBackgroundColor;
    self.navigationItem.leftBarButtonItem = self.leftItem;

    [self.view addSubview:self.whiteView];
    [self.view addSubview:self.commitBtn];

    [self.view setNeedsUpdateConstraints];
}

- (void)updateViewConstraints
{
    if (!self.didSetupConstraint) {
        [self.whiteView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
        [self.whiteView autoSetDimension:ALDimensionHeight toSize:190];
        
        [self.commitBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.whiteView withOffset:kBigPadding];
        [self.commitBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:kBigPadding];
        [self.commitBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:kBigPadding];
        [self.commitBtn autoSetDimension:ALDimensionHeight toSize:50];
        
        self.didSetupConstraint = YES;
    }
    [super updateViewConstraints];
}

#pragma mark - init
-(UIView *)whiteView
{
    if (!_whiteView) {
        _whiteView = [UIView newAutoLayoutView];
        _whiteView.backgroundColor = [UIColor whiteColor];
        
        NSArray *borrowArr = [NSArray arrayWithObjects:@"手机号",@"验证码",@"输入新密码",@"确认新密码", nil];
        NSArray *borrowArray = @[@"请输入手机号",@"请输入验证码",@"请输入新密码",@"再次输入新密码"];
        for (int i=0; i<borrowArr.count; i++) {
            UILabel *borrowLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,15+45*i, 80, 30)];
            borrowLabel.text = borrowArr[i];
            borrowLabel.textColor = [UIColor blackColor];
            borrowLabel.font = font14;
            [_whiteView addSubview:borrowLabel];
            
            //输入框
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(borrowLabel.right+10, borrowLabel.top, kScreenWidth-(20*2+borrowLabel.width+80), borrowLabel.height)];
            [_whiteView addSubview:textField];
            textField.tag = 222+i;
            textField.clearsOnBeginEditing = YES;
            textField.delegate = self;
            textField.font = font14;
            textField.placeholder = borrowArray[i];
            
            //分割线
            UILabel *lineLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(borrowLabel.left, borrowLabel.bottom, kScreenWidth-20*2, 1)];
            lineLabel3.backgroundColor = lineColor11;
            [_whiteView addSubview:lineLabel3];
            
            if (i==1) {
                JKCountDownButton *codeBtn = [[JKCountDownButton alloc] initWithFrame:CGRectMake(kScreenWidth-20*2-50, borrowLabel.top, 70, 25)];
                [codeBtn setBackgroundColor:kNavigationColor];
                [codeBtn setTitle:@"获取" forState:0];
                [codeBtn setTitleColor:[UIColor whiteColor] forState:0];
                codeBtn.layer.cornerRadius = 2;
                codeBtn.titleLabel.font = font14;
                [_whiteView addSubview:codeBtn];
                [codeBtn addTarget:self action:@selector(getPhoneCode:) forControlEvents:UIControlEventTouchUpInside];
               }
        }
    }
    return _whiteView;
}

-(BasicButton *)commitBtn
{
    if (!_commitBtn) {
        _commitBtn = [BasicButton newAutoLayoutView];
        [_commitBtn setBackgroundColor:kNavigationColor];
        [_commitBtn setTitle:@"提交" forState:0];
        [_commitBtn setTitleColor:[UIColor whiteColor] forState:0];
        ZXWeakSelf;
        [_commitBtn addAction:^(UIButton *btn) {
            [weakself findPasswordFinish];
        }];
    }
    return _commitBtn;
}

#pragma mark - request
//get code identifier
-(void)getPhoneCode:(JKCountDownButton *)sender
{
    NSString *passfindString = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFphone];
    UITextField *field1 = [self.whiteView viewWithTag:222];
    NSDictionary *params = @{
                             @"phone" : field1.text,
                             @"type"  : @"3"
                             };
    
    ZXWeakSelf;
    [self requestDataPostWithUrlString:passfindString andParams:params andSuccessBlock:^(id responseObject){
        BaseModel *passFindModel = [BaseModel objectWithKeyValues:responseObject];
        
        [weakself showHint:passFindModel.info];
        
        if ([passFindModel.status intValue] == 1) {
            [sender startWithSecond:60];
            
            [sender didChange:^NSString *(JKCountDownButton *countDownButton, int second) {
                sender.backgroundColor = [UIColor lightGrayColor];
                sender.enabled = NO;
                NSString *title = [NSString stringWithFormat:@"剩余%d秒",second];
                return title;
            }];
            [sender didFinished:^NSString *(JKCountDownButton *countDownButton, int second) {
                sender.backgroundColor = kNavigationColor;
                countDownButton.enabled = YES;
                return @"获取";
            }];
        }

    } andFailedBlock:^{

    }];
}

//commit password
-(void)findPasswordFinish
{
    NSString *findString = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFpasswordFind];
    UITextField *field1 = [self.whiteView viewWithTag:222];
    UITextField *field2 = [self.whiteView viewWithTag:223];
    UITextField *field3 = [self.whiteView viewWithTag:224];
    UITextField *field4 = [self.whiteView viewWithTag:225];
    NSDictionary *params = @{
                             @"phone"   : field1.text,
                             @"code"    : field2.text,
                             @"newpwd"  : field3.text,
                             @"renewpwd":field4.text
                             };
    
    ZXWeakSelf;
    [self requestDataPostWithUrlString:findString andParams:params andSuccessBlock:^(id responseObject){
        BaseModel *passFindModel = [BaseModel objectWithKeyValues:responseObject];
        
        [weakself showHint:passFindModel.info];
        
        if ([passFindModel.status intValue] == 1) {//找回成功
            [weakself back];
        }

    } andFailedBlock:^{

    }];
}

#pragma mark - textfield delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
