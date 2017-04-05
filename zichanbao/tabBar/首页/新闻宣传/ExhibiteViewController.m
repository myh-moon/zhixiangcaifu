//
//  ExhibiteViewController.m
//  zichanbao
//
//  Created by zhixiang on 16/12/27.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import "ExhibiteViewController.h"

@interface ExhibiteViewController ()

@property (nonatomic,assign) BOOL didSetupConstraints;
@property (nonatomic,strong) UIScrollView *exhibiteScrollView;
@property (nonatomic,strong) UIButton *exhibiteButton;

@end

@implementation ExhibiteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = self.leftItem;
    self.title = @"【圣诞来袭】惊喜好礼免费送";
    
    [self.view addSubview:self.exhibiteScrollView];
    
    [self.view setNeedsUpdateConstraints];
}

- (void)updateViewConstraints
{
    if (!self.didSetupConstraints) {
        
        [self.exhibiteScrollView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
        
        self.didSetupConstraints = YES;
    }
    [super updateViewConstraints];
}

- (UIScrollView *)exhibiteScrollView
{
    if (!_exhibiteScrollView) {
        _exhibiteScrollView = [UIScrollView newAutoLayoutView];
        
        UIImage *imgewww = [UIImage imageNamed:@"erweima.jpg"];
        _exhibiteScrollView.contentSize = CGSizeMake(kScreenWidth, imgewww.size.height);
        
        [_exhibiteScrollView addSubview:self.exhibiteButton];
        
        [self.exhibiteButton autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_exhibiteScrollView];
        [self.exhibiteButton autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_exhibiteScrollView];
        [self.exhibiteButton autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_exhibiteScrollView];
        [self.exhibiteButton autoSetDimension:ALDimensionWidth toSize:kScreenWidth];
    }
    return _exhibiteScrollView;
}

- (UIButton *)exhibiteButton
{
    if (!_exhibiteButton) {
        _exhibiteButton = [UIButton newAutoLayoutView];
        [_exhibiteButton setBackgroundImage:[UIImage imageNamed:@"erweima.jpg"] forState:0];
    }
    return _exhibiteButton;
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
