//
//  FeedBackViewController.m
//  zichanbao
//
//  Created by zhixiang on 15/11/10.
//  Copyright © 2015年 zhixiang. All rights reserved.
//

#import "FeedBackViewController.h"
#import "BasicButton.h"
#import "BaseModel.h"
@interface FeedBackViewController ()

@property (nonatomic,strong) UITextView *feedBackTextView;
@property (nonatomic,strong)  BasicButton *basicButton;
@end

@implementation FeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"意见反馈";
    self.view.backgroundColor = kBackgroundColor;
    self.navigationItem.leftBarButtonItem = self.leftItem;

    [self.view addSubview:self.feedBackTextView];
    [self.view addSubview:self.basicButton];
}

-(UITextView *)feedBackTextView
{
    if (!_feedBackTextView) {
        _feedBackTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 10, kScreenWidth, 150)];
//        _feedBackTextView.backgroundColor = [];
    }
    return _feedBackTextView;
}

-(BasicButton *)basicButton
{
    if (!_basicButton) {
        _basicButton = [[BasicButton alloc] initWithFrame:CGRectMake(kBigPadding, self.feedBackTextView.bottom+20, kScreenWidth-kBigPadding*2, 50)];
        [_basicButton setBackgroundColor:kNavigationColor];
        [_basicButton setTitleColor:[UIColor whiteColor] forState:0];
        [_basicButton setTitle:@"提交" forState:0];
        
        ZXWeakSelf;
        [_basicButton addAction:^(UIButton *btn) {
            [weakself requestDataOfOpinion];
        }];
    }
    return _basicButton;
}

-(void)requestDataOfOpinion
{
    NSString *feedString = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFCommitAdvice];
    NSDictionary *params = @{
                             @"token" : TOKEN,
                             @"con" : self.feedBackTextView.text
                             };
    
    ZXWeakSelf;
    [self requestDataPostWithUrlString:feedString andParams:params andSuccessBlock:^(id responseObject){
        
        BaseModel *feedModel = [BaseModel objectWithKeyValues:responseObject];
        
        [weakself showHint:feedModel.info];
        
        if ([feedModel.status intValue] == 1) {//反馈成功
            [weakself back];
        }
    } andFailedBlock:^{

    }];
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
