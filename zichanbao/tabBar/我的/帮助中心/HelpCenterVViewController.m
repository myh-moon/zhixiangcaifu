//
//  HelpCenterVViewController.m
//  zichanbao
//
//  Created by zhixiang on 16/1/12.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import "HelpCenterVViewController.h"
#import "AboutZXViewController.h"        //关于直向
#import "CommonProblemViewController.h"  //常见问题
#import "GestureViewController.h"        //手势密码
#import "ChangePhoneViewController.h"    //更改手机
#import "IncomeViewController.h"         //收益计算
#import "LoanViewController.h"           //贷款计算
//#import "FeedBackViewController.h"       //意见反馈


@interface HelpCenterVViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *helpTableView;
@property (nonatomic,strong) NSArray *helpArray;


@end

@implementation HelpCenterVViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = self.leftItem;
    self.title = @"帮助中心";
    
    _helpArray = [NSArray arrayWithObjects:@"关于直向",@"常见问题",@"手势密码",@"更改手机",@"收益计算",@"贷款计算", nil];
    
    [self.view addSubview:self.helpTableView];
    
}

#pragma mark - request
-(void)requestDataOfChangeTel
{
    NSString *changeTelString = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFchangeTel];
    NSDictionary *param = @{
                            @"token" : TOKEN
                            };
    
    ZXWeakSelf;
    [self requestDataGetWithUrlString:changeTelString paramter:param SucceccBlock:^(id responseObject){
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        if ([dic[@"status"] integerValue] == 1) {
            
            ChangePhoneViewController *changePhoneVC = [[ChangePhoneViewController alloc] init];
            changePhoneVC.changeTelDic = dic;
            [weakself.navigationController pushViewController:changePhoneVC animated:YES];
        }
    } andFailedBlock:^{

    }];
}

#pragma mark - init view
-(UITableView *)helpTableView
{
    if (!_helpTableView) {
        _helpTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 300) style:UITableViewStylePlain];
        _helpTableView.dataSource = self;
        _helpTableView.delegate = self;
    }
    return _helpTableView;
}

#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _helpArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"help";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = _helpArray[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:{
            //关于直向
            AboutZXViewController *aboutZXVC = [[AboutZXViewController alloc] init];
            [self.navigationController pushViewController:aboutZXVC animated:YES];
        }
            break;
        case 1:{
            //常见问题
            CommonProblemViewController *commonProblemVC = [[CommonProblemViewController alloc] init];
            [self.navigationController pushViewController:commonProblemVC animated:YES];
        }
            break;
        case 2:{
            //手势密码
            GestureViewController *gestureVC = [[GestureViewController alloc] init];
            [self.navigationController pushViewController:gestureVC animated:YES];
        }
            break;
        case 3:
        {
            //更改手机
            [self requestDataOfChangeTel];
        }
            break;
        case 4:{
            //收益计算
            IncomeViewController *incomeVC = [[IncomeViewController alloc] init];
            [self.navigationController pushViewController:incomeVC animated:YES];
        }
            break;
        case 5:{
            //贷款计算
            LoanViewController *loanVC = [[LoanViewController alloc] init];
            [self.navigationController pushViewController:loanVC animated:YES];
        }
            break;
//        case 6:{
//            //意见反馈
//            FeedBackViewController *feedBackVC = [[FeedBackViewController alloc] init];
//            [self.navigationController pushViewController:feedBackVC animated:YES];
//        }
//            break;
        default:
            break;
    }
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
