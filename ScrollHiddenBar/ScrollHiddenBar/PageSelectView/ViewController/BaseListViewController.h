//
//  TestOneViewController.h
//  MVVM-ViewModel-NetWork-Model
//
//  Created by 刘小椿 on 16/11/30.
//  Copyright © 2016年 刘小椿. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XCScrollDelegate<NSObject>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;

@end

@interface BaseListViewController : UIViewController

@property (nonatomic, weak) id<XCScrollDelegate>delegate;

- (void)refreshTableView:(NSInteger)index;

@end
