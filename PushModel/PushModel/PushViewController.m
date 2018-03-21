//
//  PushViewController.m
//  PushModel
//
//  Created by IOS技术专用 on 2018/3/20.
//  Copyright © 2018年 LXC. All rights reserved.
//

#import "PushViewController.h"
#import "XWDrawerAnimator.h"
#import "UIViewController+XWTransition.h"

@interface PushViewController ()<CAAnimationDelegate>

@end

@implementation PushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    XWInteractiveTransitionGestureDirection direction = XWInteractiveTransitionGestureDirectionDown;
    __weak typeof(self)weakSelf = self;
    [self xw_registerBackInteractiveTransitionWithDirection:direction transitonBlock:^(CGPoint startPoint){
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    } edgeSpacing:0];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

@end
