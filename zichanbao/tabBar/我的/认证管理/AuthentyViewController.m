//
//  AuthentyViewController.m
//  zichanbao
//
//  Created by zhixiang on 15/10/16.
//  Copyright (c) 2015年 zhixiang. All rights reserved.
//

#import "AuthentyViewController.h"

#import "BasicButton.h"
#import "BaseModel.h"

@interface AuthentyViewController ()<UITextFieldDelegate>

@property (nonatomic,assign) BOOL didSetupConstraint;
@property (nonatomic,strong) UIView *whiteView;
@property (nonatomic,strong) BasicButton *commitBtn3;

@property (nonatomic,strong) NSMutableArray *auArray;

@end

@implementation AuthentyViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"认证管理";
    self.view.backgroundColor = kBackgroundColor;
    self.navigationItem.leftBarButtonItem = self.leftItem;
    
    [self.view addSubview:self.whiteView];
    [self.view addSubview:self.commitBtn3];
    
    [self.view setNeedsUpdateConstraints];
}

- (void)updateViewConstraints
{
    if (!self.didSetupConstraint) {
        
        [self.whiteView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
        [self.whiteView autoSetDimension:ALDimensionHeight toSize:110];
        
        [self.commitBtn3 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.whiteView withOffset:kSpacePadding];
        [self.commitBtn3 autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:kSpacePadding];
        [self.commitBtn3 autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:kSpacePadding];
        [self.commitBtn3 autoSetDimension:ALDimensionHeight toSize:kCommitHeight];
        
        self.didSetupConstraint = YES;
    }
    [super updateViewConstraints];
}

#pragma mark - request data
-(void)requestDataOfAuthenty
{
    NSString *authentyString = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFAuthenty];
    UITextField *textField1 = [self.whiteView viewWithTag:50];
    UITextField *textField2 = [self.whiteView viewWithTag:51];
    NSDictionary *params = @{
                             @"token" : TOKEN,
                             @"realname" : textField1.text,
                             @"card" : textField2.text
                             };
    
    ZXWeakSelf;
    [self requestDataPostWithUrlString:authentyString andParams:params andSuccessBlock:^(id responseObject){
        
        BaseModel *authentyModel = [BaseModel objectWithKeyValues:responseObject];
        
        [weakself showHint:authentyModel.info];
        
        if ([authentyModel.status intValue] == 1) {//认证成功
            [weakself back];
        }
        
    } andFailedBlock:^{

    }];
}

#pragma mark - init view
-(UIView *)whiteView
{
    if (!_whiteView) {
        _whiteView = [UIView newAutoLayoutView];
        _whiteView.backgroundColor = [UIColor whiteColor];
        
        NSArray *auArray1 = [NSArray arrayWithObjects:@"姓名",@"证件号", nil];
        NSArray *auArray2 = [NSArray arrayWithObjects:@"",@"身份证号或护照号", nil];
        
        for (int i = 0; i<2; i++) {
            UILabel *auLabel = [[UILabel alloc] initWithFrame:CGRectMake(30,30+50*i, 60, 20)];
            auLabel.text = auArray1[i];
            auLabel.textColor = [UIColor blackColor];
            auLabel.font = font14;
            [_whiteView addSubview:auLabel];
            
            //分割线
            UILabel *lineLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(auLabel.left, auLabel.bottom, kScreenWidth-30*2, 1)];
            lineLabel1.backgroundColor = [UIColor lightGrayColor];
            [_whiteView addSubview:lineLabel1];
            
            UITextField *auTextField = [[UITextField alloc] initWithFrame:CGRectMake(auLabel.right, auLabel.top, kScreenWidth-30-auLabel.width-60, auLabel.height)];
            auTextField.placeholder = auArray2[i];
            auTextField.font = font14;
            [_whiteView addSubview:auTextField];
            auTextField.tag = i+50;
            auTextField.delegate = self;
        }
    }
    return _whiteView;
}

-(BasicButton *)commitBtn3
{
    if (!_commitBtn3) {
        _commitBtn3 = [BasicButton newAutoLayoutView];
        [_commitBtn3 setBackgroundColor:kNavigationColor];
        [_commitBtn3 setTitleColor:[UIColor whiteColor] forState:0];
        [_commitBtn3 setTitle:@"提交" forState:0];
        ZXWeakSelf;
        [_commitBtn3 addAction:^(UIButton *btn) {
            [weakself requestDataOfAuthenty];
        }];
    }
    return _commitBtn3;
}

#pragma mark - textField delegate
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
