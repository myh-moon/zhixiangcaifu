//
//  UIViewController+BlurView.m
//  zichanbao
//
//  Created by zhixiang on 16/12/28.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import "UIViewController+BlurView.h"
#import "BlurTableView.h"

@implementation UIViewController (BlurView)

//有标题
- (void)showBlurInView:(UIView *)view withArray:(NSArray *)array andTitle:(NSString *)title finishBlock:(void (^)(NSString *text,NSInteger row))finishBlock
{
    [self hiddenBlurView];
    UIView *tagView = [self.view viewWithTag:99999];
    BlurTableView *tableView = [self.view viewWithTag:99998];
    
    if (!tagView) {
        tagView = [UIView newAutoLayoutView];
        tagView.backgroundColor = kAlphaBackColor;
        tagView.tag = 99999;
        [view addSubview:tagView];
        [tagView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
        
        tableView = [BlurTableView newAutoLayoutView];
        tableView.tableType = @"有";
        [tagView addSubview:tableView];
        
        [tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
        if (array.count > 7) {
            tableView.heightTableConstraints.constant = 6*40;
        }else{
            tableView.heightTableConstraints.constant = (array.count+1) * 40;
        }
        [tableView setBlurDataList:array];
        tableView.upwardTitleString = title;
    }
    
    if (tagView) {//点击蒙板，界面消失
        UIButton *control = [UIButton newAutoLayoutView];
        [tagView addSubview:control];
        [control autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
        [control autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:tableView];
        [control addAction:^(UIButton *btn) {
            [tagView removeFromSuperview];
        }];
    }
    
    if (finishBlock) {
        [tableView setDidSelectedRow:^(NSString *text,NSInteger row) {
            [tagView removeFromSuperview];
            finishBlock(text,row);
        }];
        
        [tableView setDidSelectedButton:^(NSInteger tag) {
            [tagView removeFromSuperview];
        }];
    }
}

//无标题，有topconstraints－－－产品页面的选择功能
- (void)showBlurInView:(UIView *)view withArray:(NSArray *)array withTop:(CGFloat)top finishBlock:(void (^)(NSString *, NSInteger))finishBlock
{
    [self hiddenBlurView];
    UIView *tagView = [self.view viewWithTag:99999];
    BlurTableView *tableView = [self.view viewWithTag:99998];
    if (!tagView) {
        tagView = [UIView newAutoLayoutView];
        tagView.backgroundColor = kAlphaBackColor;
        tagView.tag = 99999;
        if (!view) {
            view = self.view;
        }
        [view addSubview:tagView];
        [tagView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
        [tagView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:top];
        
        tableView = [BlurTableView newAutoLayoutView];
        tableView.tableType = @"无";
        
        [tagView addSubview:tableView];
        
        [tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
        tableView.heightTableConstraints.constant = array.count*40;
        [tableView setBlurDataList:array];
    }
    
    if (tagView) {//点击蒙板，界面消失
        UIButton *control = [UIButton newAutoLayoutView];
        [tagView addSubview:control];
        [control autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
        [control autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:tableView];
        [control addAction:^(UIButton *btn) {
            [tagView removeFromSuperview];
        }];
    }
    
    if (finishBlock) {
        [tableView setDidSelectedRow:^(NSString *text,NSInteger row) {
            [tagView removeFromSuperview];
            finishBlock(text,row);
        }];
    }
}

- (void)hiddenBlurView
{
    UIView *tagView = [self.view viewWithTag:99999];
    [tagView removeFromSuperview];
}



@end
