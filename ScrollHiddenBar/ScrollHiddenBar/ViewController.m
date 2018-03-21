//
//  ViewController.m
//  ScrollHiddenBar
//
//  Created by IOS技术专用 on 2018/3/21.
//  Copyright © 2018年 LXC. All rights reserved.
//

#import "ViewController.h"
#import "XCSegumentionView.h"
#import "BaseListViewController.h"
#import "CollectionTestOneViewController.h"
#import "CollectionTestTwoViewController.h"
#import "XCSearchView.h"

@interface ViewController ()<UIScrollViewDelegate, XCScrollDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;

@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, strong) XCSegumentionView* segumentionView;

@property (nonatomic, strong) BaseListViewController* baseOneTableViewController;

@property (nonatomic, strong) CollectionTestOneViewController* collectionOneViewController;

@property (nonatomic, strong) CollectionTestTwoViewController* collectionTwoViewController;
@property (nonatomic, strong) XCSearchView* searchView;

@property (nonatomic, assign) CGFloat offsetY;
@property (nonatomic, assign) BOOL isShowSearch;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

#pragma mark - Delegate Method
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scrollY = scrollView.contentOffset.y;
    if (scrollY > scrollView.contentSize.height) return;
    if (scrollView.isDragging) {
        if (fabs(self.offsetY - scrollY) > 50) {
            if (self.offsetY > scrollY) {
                if (!self.isShowSearch) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.segumentionView refreshSubViewFrame];
                        [UIView animateWithDuration:0.6
                                         animations:^{
                                             CGRect newFrame = self.searchView.frame;
                                             newFrame.origin.y = 0;
                                             self.searchView.frame = newFrame;
                                             
                                             newFrame = self.segumentionView.frame;
                                             newFrame.origin.y = 60;
                                             self.segumentionView.frame = CGRectMake(0, newFrame.origin.y, self.view.frame.size.width, self.scrollView.frame.size.height * 2);
                                             [self.segumentionView refreshSubViewFrame];
                                         }completion:^(BOOL finished) {
                                             self.segumentionView.frame = CGRectMake(0, self.segumentionView.frame.origin.y, self.view.frame.size.width, self.scrollView.frame.size.height - 60);
                                             self.isShowSearch = YES;
                                         }];
                    });
                }
            }else{
                if (self.isShowSearch) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [UIView animateWithDuration:0.6
                                         animations:^{
                                             CGRect newFrame = self.searchView.frame;
                                             newFrame.origin.y = -60;
                                             self.searchView.frame = newFrame;
                                             
                                             newFrame = self.segumentionView.frame;
                                             newFrame.origin.y = 0;
                                             self.segumentionView.frame = CGRectMake(0, newFrame.origin.y, self.view.frame.size.width, self.scrollView.frame.size.height);
                                             [self.segumentionView refreshSubViewFrame];
                                         }completion:^(BOOL finished) {
                                             self.isShowSearch = NO;
                                         }];
                    });
                }
            }
            self.offsetY = scrollY;
        }
    }
}

#pragma mark - Private Method
- (void)initUI
{
    self.isShowSearch = YES;
    self.view.backgroundColor = [UIColor redColor];
    self.scrollView.backgroundColor = [UIColor blackColor];
    
    UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hfqbackview"]];
    imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, [UIApplication sharedApplication].statusBarFrame.size.height);
    [self.view addSubview:imageView];
    
    [self.view insertSubview:self.scrollView belowSubview:imageView];
    
    self.searchView = [[NSBundle mainBundle] loadNibNamed:@"XCSearchView" owner:nil options:nil].lastObject;
    self.searchView.frame = CGRectMake(0, 0, self.view.frame.size.width, 60);
    [self.scrollView addSubview:self.searchView];
    
    //第一个控制器
    self.baseOneTableViewController = (BaseListViewController*)[self instantiateViewControllerWithStoryboardName:@"PageViewController" identifier:@"BaseListViewController"];
    self.baseOneTableViewController.delegate = self;
    [self.baseOneTableViewController refreshTableView:0];
    //第二个控制器
    self.collectionOneViewController = (CollectionTestOneViewController*)[self instantiateViewControllerWithStoryboardName:@"PageViewController" identifier:@"CollectionTestOneViewController"];
    //第三个控制器
    self.collectionTwoViewController = [[CollectionTestTwoViewController alloc] init];
    
    self.segumentionView = [[XCSegumentionView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.scrollView.frame.size.height - 60) viewControllers:@[
                                                                                                                                                                                                                                                                                                    self.baseOneTableViewController,
                                                                                                                                                                                                                                                                                                    self.collectionOneViewController,
                                                                                                                                                                                                                                                                                                    self.collectionTwoViewController,
                                                                                                                                                                                                                                                                                                    self.collectionTwoViewController,
                                                                                                                                                                                                                                                                                                    self.collectionTwoViewController,
                                                                                                                                                                                                                                                                                                    self.collectionTwoViewController,
                                                                                                                                                                                                                                                                                                    ]
                                                             titles:@[@"1",@"2",@"3",@"4",@"5",@"6",@""]
                                                          itemWidth:CGRectGetWidth(self.view.bounds) / 4
                                                           andBlock:^(NSInteger index) {
                                                               NSLog(@"到第%ld个界面。。。",(long)index);
                                                           }];
    [self.scrollView addSubview:self.segumentionView];
}

- (UIViewController *)instantiateViewControllerWithStoryboardName:(NSString *)storyboardName identifier:(NSString *)identifier
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:[NSBundle mainBundle]];
    UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:identifier];
    return viewController;
}

#pragma mark - Setter/getter
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, [UIApplication sharedApplication].statusBarFrame.size.height, self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height - [UIApplication sharedApplication].statusBarFrame.size.height)];
//        _scrollView.scrollIndicatorInsets = UIEdgeInsetsMake([UIApplication sharedApplication].statusBarFrame.size.height + 60, 0, 0, 0);
    }
    return _scrollView;
}

@end
