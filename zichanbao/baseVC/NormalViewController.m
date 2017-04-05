//
//  NormalViewController.m
//  zichanbao
//
//  Created by zhixiang on 16/1/7.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import "NormalViewController.h"

@interface NormalViewController ()

@property (nonatomic,strong) MBProgressHUD *hud;

@end

@implementation NormalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//get
-(void)requestDataGetWithUrlString:(NSString *)urlString paramter:(NSDictionary *)params SucceccBlock:(void (^)(id responseObject))successBlock andFailedBlock:(void (^)())failedBlock
{
    [self showHudInView:self.view hint:@"请稍后"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    ZXWeakSelf;
    [manager GET:urlString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [weakself hideHud];
        if (successBlock) {
            successBlock(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [weakself hideHud];
        [weakself showHint:@"请检查网络"];
        
    }];
}

//post
-(void)requestDataPostWithUrlString:(NSString *)urlString andParams:(NSDictionary *)params andSuccessBlock:(void (^)(id responseObject))successBlock andFailedBlock:(void (^)())failedBlock
{
    [self showHudInView:self.view hint:@"请稍后"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    ZXWeakSelf;
    [manager POST:urlString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [weakself hideHud];
        if (successBlock) {
            successBlock(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [weakself hideHud];
        [weakself showHint:@"请检查网络"];
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
