//
//  SunSegmentedControl.m
//  分段控件
//
//  Created by 刘小椿 on 16/12/2.
//  Copyright © 2016年 刘小椿. All rights reserved.
//

#import "XCSegmentedControl.h"

#define MYHEIGHT self.frame.size.height - 2//宏定义（全局定义）

@interface XCSegmentedControl ()

@property (nonatomic, strong)NSMutableArray* buttons;

@end

@implementation XCSegmentedControl
{
    UIView *lineview;
    NSInteger width;
}

-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titleArray andItemWidth:(NSInteger)itemWidth  backblock:(void (^)(NSInteger index))block
{
    self = [super initWithFrame:frame];
    if (self) {
        width = itemWidth;
        self.contentSize = CGSizeMake(itemWidth * titleArray.count, frame.size.height);
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.backgroundColor = [UIColor whiteColor];
        [self setUI:titleArray block:block];
    }
    return self;
}

#pragma mark --Private Method
-(void)setUI:(NSArray *)array block:(void(^)(NSInteger))block
{
    [self.buttons removeAllObjects];
    
    lineview = [[UIView alloc]initWithFrame:CGRectMake(0, MYHEIGHT , width, 2)];
    lineview.backgroundColor = [UIColor redColor];
    [self addSubview:lineview];
    for (int i = 0; i < array.count; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(i * width, 0,width, MYHEIGHT)];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        if (0 == i) {
            btn.selected = YES;
        }else{
            btn.backgroundColor = [UIColor whiteColor];
        }
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:array[i] forState:UIControlStateNormal];
        btn.tag = 100 + i;
        [self addSubview:btn];
        [self.buttons addObject:btn];
        [btn addTarget:self action:@selector(btnCliked:) forControlEvents:UIControlEventTouchUpInside];
    }
    self.block = block;
    self.block(0);
}

#pragma mark --Public Method
- (void)moveLine:(CGFloat)offset
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.3 animations:^{
            lineview.frame = CGRectMake(offset, MYHEIGHT , width, 2);
        }completion:^(BOOL finished) {
            for (UIButton* button in self.buttons) {
                button.backgroundColor = [UIColor whiteColor];
                button.selected = NO;
            }
            UIButton* button = self.buttons[(int)(offset / width)];
            button.selected = YES;
            NSInteger screencount = SCREEN_WIDTH / width;
            
            if (self.contentSize.width > SCREEN_WIDTH) {
                if ((int)(offset / width) > (screencount > 2 ? 1 :0) && (int)(offset / width) < self.buttons.count - (screencount - (screencount > 3 ? 2 :1))) {
                    [UIView animateWithDuration:0.1 animations:^{
                        self.contentOffset = CGPointMake(offset - (screencount - (screencount >= 5 ? screencount - 2: 2)) * width, 0);
                    }];
                }else{
                    if ((int)(offset / width) <= 1) {
                        [UIView animateWithDuration:0.1 animations:^{
                            self.contentOffset = CGPointMake(0, 0);
                        }];
                    }else{
                        [UIView animateWithDuration:0.1 animations:^{
                            self.contentOffset = CGPointMake(self.contentSize.width - screencount * width, 0);
                        }];
                    }
                }
            }else{
                
            }
        }];
    });
}

#pragma mark --Responder Method
-(void)btnCliked:(UIButton*)sender
{
    UIButton *btn = sender;
    for (UIButton *button in [self subviews]) {
        if ([button isKindOfClass:[UIButton class]]) {
            if (btn == button) {
                button.selected = YES;
            }else{
                button.selected = NO;
            }
        }
    }
    
    if (self.block) {
        self.block(btn.tag - 100);
    }
    [self moveLine:btn.frame.origin.x];
    
//    [UIView animateWithDuration:0.5 animations:^{
//        lineview.frame = CGRectMake(btn.frame.origin.x, MYHEIGHT , btn.frame.size.width, 2);
//    } completion:nil];
}

#pragma mark - Setter/Getter
- (NSMutableArray *)buttons
{
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

@end
