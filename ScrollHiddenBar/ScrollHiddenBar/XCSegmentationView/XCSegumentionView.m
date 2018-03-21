//
//  SegumentionView.m
//  MVVM-ViewModel-NetWork-Model
//
//  Created by 刘小椿 on 16/12/1.
//  Copyright © 2016年 刘小椿. All rights reserved.
//

#import "XCSegumentionView.h"
#import "XCSegmentedControl.h"

@interface XCSegumentionView ()<UIScrollViewDelegate>

@property (nonatomic,strong) XCSegmentedControl* segmentionView;

@property (nonatomic,strong) UIScrollView* scrollView;

@property (nonatomic,strong) NSMutableArray<UIView*>* controllerViews;

@property (nonatomic,assign) BOOL isButtonAction;

@property (nonatomic,assign) NSInteger index;

@property (nonatomic,strong) NSArray* titles;

@property (nonatomic,copy) clickBlock block;

@property (nonatomic, assign) CGFloat itemWidth;

@end

@implementation XCSegumentionView

- (instancetype)initWithFrame:(CGRect)frame viewControllers:(NSArray<UIViewController *> *)viewControllers titles:(NSArray *)titles itemWidth:(CGFloat)itemWidth andBlock:(clickBlock)block
{
    if (self = [super initWithFrame:frame]) {
        self.index = 0;
        self.titles = titles;
        self.block = block;
        self.itemWidth = itemWidth;
        __weak typeof(self) weakself = self;
        self.segmentionView = [[XCSegmentedControl alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45) titles:titles andItemWidth:itemWidth backblock:^(NSInteger index) {
            if ([self.titles[index] isEqual:@""]) {
                return;
            }
            weakself.isButtonAction = YES;
            [UIView animateWithDuration:0.5 animations:^{
                weakself.scrollView.contentOffset = CGPointMake(index * CGRectGetWidth(self.frame), 0);
            } completion:nil];
            if (self.block) {
                self.block(weakself.scrollView.contentOffset.x / SCREEN_WIDTH);
            }
        }];
        [self addSubview:self.segmentionView];
        
        [self initControllerView:viewControllers];
        [self addControllerView];
        
        self.scrollView.delegate = self;
        self.scrollView.contentSize = CGSizeMake(([self.titles.lastObject isEqual:@""] ? self.titles.count - 1 : self.titles.count) * CGRectGetWidth(self.frame), 0);
        self.scrollView.pagingEnabled = YES;
    }
    return self;
}

#pragma mark --Delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.isButtonAction = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x < 0 || scrollView.contentOffset.x / (self.titles.count - 1 - ([self.titles.lastObject isEqual:@""] ? 1: 0)) > CGRectGetWidth(self.frame)) return;
    [self.segmentionView moveLine:scrollView.contentOffset.x / SCREEN_WIDTH * self.itemWidth];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([self.titles[(NSInteger)(scrollView.contentOffset.x / (SCREEN_WIDTH  / self.itemWidth) / self.itemWidth)] isEqual:@""]) {
        return;
    }
    if (self.block) {
        self.block(scrollView.contentOffset.x / SCREEN_WIDTH);
    }
}

#pragma mark - Public Method
- (void)scrollToPage:(NSInteger)pageIndex
{
    self.scrollView.contentOffset = CGPointMake(SCREEN_WIDTH * pageIndex, 0);
}

- (void)refreshSubViewFrame
{
    self.scrollView.frame = CGRectMake(0, 45, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - 45);
    __weak typeof(self) weakself = self;
    [self.controllerViews enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.frame = CGRectMake(CGRectGetWidth(weakself.frame) * idx, 0, CGRectGetWidth(weakself.frame), weakself.scrollView.frame.size.height);
    }];
}

#pragma mark --Private Method
- (void)addControllerView
{
    [self addSubview:self.scrollView];
    __weak typeof(self) weakself = self;
    [self.controllerViews enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.frame = CGRectMake(CGRectGetWidth(weakself.frame) * idx, 0, CGRectGetWidth(weakself.frame), self.scrollView.frame.size.height);
        [weakself.scrollView addSubview:obj];
    }];
}

- (void)initControllerView:(NSArray*)viewControllers
{
    [self.controllerViews removeAllObjects];
    for (UIViewController* viewController in viewControllers) {
        [[self belongViewController] addChildViewController:viewController];
        [self.controllerViews addObject:viewController.view];
    }
}

- (UIViewController *)belongViewController {
    for (UIView *next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    
    return nil;
}

#pragma mark --Get/Set
- (NSMutableArray<UIView *> *)controllerViews
{
    if (!_controllerViews) {
        _controllerViews = [NSMutableArray array];
    }
    return _controllerViews;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 45, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - 45)];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.backgroundColor = [UIColor brownColor];
    }
    return _scrollView;
}

@end
