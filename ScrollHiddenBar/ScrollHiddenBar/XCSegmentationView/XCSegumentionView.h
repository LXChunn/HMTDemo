//
//  SegumentionView.h
//  MVVM-ViewModel-NetWork-Model
//
//  Created by 刘小椿 on 16/12/1.
//  Copyright © 2016年 刘小椿. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^clickBlock)(NSInteger index);

@interface XCSegumentionView : UIView

@property (nonatomic, strong)NSArray* viewControllers;

/**
 滚动菜单init (超出屏幕 : 3段以上的联动)

 @param frame 大小
 @param titles 菜单数组
 @param viewControllers 控制器数组
 @param itemWidth 平均宽度
 @param block 点击选项回调
 @return 实例
 */
- (instancetype)initWithFrame:(CGRect)frame viewControllers:(NSArray<UIViewController*>*)viewControllers titles:(NSArray*)titles itemWidth:(CGFloat)itemWidth andBlock:(clickBlock)block;

/**
 滚动到指定类别

 @param pageIndex 指定页
 */
- (void)scrollToPage:(NSInteger)pageIndex;

/**
 适用于隐藏顶部内容
 */
- (void)refreshSubViewFrame;

@end
