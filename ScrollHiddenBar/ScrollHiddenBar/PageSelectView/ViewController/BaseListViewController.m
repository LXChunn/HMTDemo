//
//  TestOneViewController.m
//  MVVM-ViewModel-NetWork-Model
//
//  Created by 刘小椿 on 16/11/30.
//  Copyright © 2016年 刘小椿. All rights reserved.
//

#import "BaseListViewController.h"
#import "BaseTableViewCell.h"

@interface BaseListViewController ()<UIScrollViewDelegate>

@property (nonatomic,assign) NSInteger count;

@property (nonatomic, strong) NSMutableArray* datas;

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation BaseListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableview.decelerationRate = 0;
}

#pragma mark -- Delegate Method
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([self.delegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [self.delegate scrollViewDidScroll:scrollView];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseTableViewCell* cell = [BaseTableViewCell cellWithTableView:tableView];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"????");
}

- (void)refreshTableView:(NSInteger)index
{
    NSLog(@"刷新第%lu个界面",index);
    //TODO:网络请求哪个界面
    switch (index) {
        case 0:
            self.count = 50;
            break;
        case 1:
            self.count = 30;
            break;
        case 2:
            self.count = 40;
            break;
        default:
            break;
    }
    [self.tableview reloadData];
}

#pragma mark --Set/Get
- (NSMutableArray *)datas
{
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}

@end
