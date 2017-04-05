//
//  MineReceiptAddressViewController.m
//  zichanbao
//
//  Created by zhixiang on 16/11/10.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import "MineReceiptAddressViewController.h"
#import "AddNewAddressViewController.h"

#import "BorrowBaseCell.h"
#import "AddressModel.h"

@interface MineReceiptAddressViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,assign) BOOL didSetupConstarints;
@property (nonatomic,strong) UITableView *addressTableView;

//json
@property (nonatomic,strong) NSMutableArray *addresssArray;

@end

@implementation MineReceiptAddressViewController

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
    
    [self getListOfMyReceiptAddress];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收货地址";
    self.navigationItem.leftBarButtonItem = self.leftItem;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
    [self.rightButton setTitle:@"添加" forState:0];
    
    [self.view addSubview:self.addressTableView];
    [self.view addSubview:self.remindButton];
    [self.remindButton.noTextButton setTitle:@"暂无收货地址！请添加" forState:0];
    [self.remindButton setHidden:YES];
    
    [self.view setNeedsUpdateConstraints];
}

- (void)updateViewConstraints
{
    if (!self.didSetupConstarints) {
        
        [self.addressTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
        
        [self.remindButton autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [self.remindButton autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        self.didSetupConstarints = YES;
    }
    [super updateViewConstraints];
}

- (UITableView *)addressTableView
{
    if (!_addressTableView) {
        _addressTableView.translatesAutoresizingMaskIntoConstraints = NO;
        _addressTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _addressTableView.delegate = self;
        _addressTableView.dataSource = self;
//        _addressTableView.tableFooterView = [[UIView alloc] init];
    }
    return _addressTableView;
}

- (NSMutableArray *)addresssArray
{
    if (!_addresssArray) {
        _addresssArray = [NSMutableArray array];
    }
    return _addresssArray;
}

#pragma mark - delegate and datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.addresssArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"address";
    BorrowBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[BorrowBaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.leftButton.titleLabel.numberOfLines = 0;
    [cell.leftButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:kSmallPadding];
    [cell.leftButton setContentHorizontalAlignment:1];
    cell.leftButton.userInteractionEnabled = NO;
    
    [cell.rightButton autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:cell.leftButton];
    [cell.rightButton setContentVerticalAlignment:1];
    cell.rightButton.userInteractionEnabled = NO;
    
    AddressModel *addressModel = self.addresssArray[indexPath.row];
    
    NSString *name1;
    if ([addressModel.type integerValue] == 1) {
        name1 = [NSString stringWithFormat:@"%@(默认地址)\n",addressModel.name];
    }else{
        name1 = [NSString stringWithFormat:@"%@\n",addressModel.name];
    }
    NSString *address1 = addressModel.address;
    NSString *ccc = [NSString stringWithFormat:@"%@%@",name1,address1];
    NSMutableAttributedString *attributeCC = [[NSMutableAttributedString alloc] initWithString:ccc];
    [attributeCC addAttributes:@{NSFontAttributeName:font14,NSForegroundColorAttributeName:[UIColor blackColor]} range:NSMakeRange(0, name1.length)];
    [attributeCC addAttributes:@{NSFontAttributeName:font14,NSForegroundColorAttributeName:[UIColor blackColor]} range:NSMakeRange(name1.length, address1.length)];
    NSMutableParagraphStyle *stylep = [[NSMutableParagraphStyle alloc] init];
//    [stylep setLineSpacing:4];
    [stylep setParagraphSpacing:6];
    stylep.alignment = NSTextAlignmentLeft;
    [attributeCC addAttribute:NSParagraphStyleAttributeName value:stylep range:NSMakeRange(0, ccc.length)];
    [cell.leftButton setAttributedTitle:attributeCC forState:0];
    
    //tel
    [cell.rightButton setTitle:addressModel.tel forState:0];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return kSmallSpace;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddressModel *addressModel = self.addresssArray[indexPath.row];
    if (self.didSelectedRow) {
        self.didSelectedRow(addressModel);
    }
    
    [self back];
}

#pragma mark - method
- (void)getListOfMyReceiptAddress
{
    NSString *listString = [NSString stringWithFormat:@"%@%@",ZXCF,ZXCFReceiptAddressOfAdd];
    NSDictionary *params = @{@"token" : TOKEN};
    
    ZXWeakSelf;
    [self requestDataGetWithUrlString:listString paramter:params SucceccBlock:^(id responseObject) {
        
        [weakself.addresssArray removeAllObjects];
        
        NSArray *listArray = [AddressModel objectArrayWithKeyValuesArray:responseObject];
        
        for (AddressModel *addressModel in listArray) {
            [weakself.addresssArray addObject:addressModel];
        }
        
        if (weakself.addresssArray.count == 0) {
            [weakself.remindButton setHidden:NO];
        }else{
            [weakself.remindButton setHidden:YES];
        }
        
        [weakself.addressTableView reloadData];
        
    } andFailedBlock:^{
        
    }];
}
- (void)rightAction
{
    AddNewAddressViewController *addNewAddressVC = [[AddNewAddressViewController alloc] init];
    [self.navigationController pushViewController:addNewAddressVC animated:YES];
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
