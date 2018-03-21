//
//  SunSegmentedControl.h
//  分段控件
//
//  Created by 刘小椿 on 16/12/2.
//  Copyright © 2016年 刘小椿. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

typedef void(^btnClikBlock)(NSInteger index);

@interface XCSegmentedControl : UIScrollView

@property(nonatomic,strong)btnClikBlock block ;

/**
 初始化分段控件

 @param frame 大小
 @param titleArray 分段内容
 @param itemWidth 分段长度
 @param block 点击回调
 @return 返回实例
 */
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titleArray andItemWidth:(NSInteger)itemWidth backblock:(void (^)(NSInteger))block;

/**
 移动滚动条

 @param offset 偏移量
 */
- (void)moveLine:(CGFloat)offset;

@end
