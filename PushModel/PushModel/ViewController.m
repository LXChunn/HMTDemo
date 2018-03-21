//
//  ViewController.m
//  PushModel
//
//  Created by IOS技术专用 on 2018/3/20.
//  Copyright © 2018年 LXC. All rights reserved.
//

#import "ViewController.h"
#import "PushViewController.h"
#import "XWDrawerAnimator.h"
#import "UIViewController+XWTransition.h"

@interface ViewController ()<CAAnimationDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    XWInteractiveTransitionGestureDirection direction = XWInteractiveTransitionGestureDirectionUp;
    [self xw_registerToInteractiveTransitionWithDirection:direction transitonBlock:^(CGPoint startPoint){
    } edgeSpacing:0];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (IBAction)pushAction:(id)sender {
    [self xw_transition];
}

- (void)xw_transition{
    XWDrawerAnimatorDirection direction = XWDrawerAnimatorDirectionBottom;
    XWDrawerAnimator *animator = [XWDrawerAnimator xw_animatorWithDirection:direction moveDistance:[UIScreen mainScreen].bounds.size.height - [UIApplication sharedApplication].statusBarFrame.size.height];
    animator.toDuration = 0.5;
    animator.backDuration = 0.5;
    animator.scaleRatio = 0.9;
    animator.flipEnable = YES;
    PushViewController *toVC = [PushViewController new];
    [self xw_presentViewController:toVC withAnimator:animator];
    
    __weak typeof(self)weakSelf = self;
    [animator xw_enableEdgeGestureAndBackTapWithConfig:^{
        [weakSelf _xw_back];
    }];
}

- (void)_xw_back{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
