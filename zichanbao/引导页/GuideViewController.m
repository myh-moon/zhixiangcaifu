//
//  GuideViewController.m
//  zichanbao
//
//  Created by zhixiang on 16/1/26.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import "GuideViewController.h"
#import "ViewController.h"

@interface GuideViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *pageControl;

@property (nonatomic,strong) NSArray *imageArray;


@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.pageControl];
}

#pragma markk - target
-(void)goToTabBarViewController
{
    ViewController *VC = [[ViewController alloc]init];
    [self changeTabBarStyle];
    self.view.window.rootViewController = VC;
}

#pragma mark - 修改TabBar样式
-(void)changeTabBarStyle
{
    [[UITabBar appearance] setBackgroundColor:RGBCOLOR(0.9216, 0.9255, 0.9294)];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} forState:0];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:kNavigationColor} forState:UIControlStateSelected];
}

#pragma mark - init view
-(UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,20, kScreenWidth, kScreenHeight)];
        _scrollView.contentSize = CGSizeMake(kScreenWidth * 2, kScreenHeight);
        _scrollView.bounces = YES;
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.scrollEnabled = YES;
        self.automaticallyAdjustsScrollViewInsets = NO;
        
        for (int i=0;i<2; i++) {
            
            //背景图片
            UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth*i, 0, kScreenWidth, kScreenHeight)];
            imageView1.image = [UIImage imageNamed:@"beging"];
            [_scrollView addSubview:imageView1];
            
            //图片
            UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(50+kScreenWidth*i, 60, kScreenWidth-50*2, kScreenHeight-20-60*2)];
            imageView2.image = [UIImage imageNamed:self.imageArray[i]];
            [_scrollView addSubview:imageView2];
            
            if (i == 1) {//添加手势进入首页
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToTabBarViewController)];
            tapGesture.numberOfTapsRequired = 1;
            imageView2.userInteractionEnabled = YES;
            [imageView2 addGestureRecognizer:tapGesture];
            }
        }
        
    }
    return _scrollView;
}

-(UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(50, self.scrollView.bottom-70, kScreenWidth-100, 20)];
        _pageControl.numberOfPages = 2;
        _pageControl.currentPage = 0;
        
        [_pageControl addTarget:self action:@selector(pageTurn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pageControl;
}

-(void)pageTurn:(UIPageControl *)sender
{
    CGSize viewSize = self.scrollView.frame.size;
    CGRect rect = CGRectMake(sender.currentPage * viewSize.width, 0, viewSize.width, viewSize.height);
    [self.scrollView scrollRectToVisible:rect animated:YES];
}

#pragma mark - scrollView delegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.frame;
    [self.pageControl setCurrentPage:offset.x/bounds.size.width];
}

#pragma mark - init array
-(NSArray *)imageArray
{
    if (!_imageArray) {
        _imageArray = @[@"font",@"fontss"];
    }
    return _imageArray;
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
