//
//  YPHTransitionAnimator.m
//  UIDynamicDemo
//
//  Created by shareit on 15/9/11.
//  Copyright (c) 2015年 shareit. All rights reserved.
//

#import "YPHTransitionAnimator.h"

@implementation YPHTransitionAnimator
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 1.0f;
}
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    __block UIDynamicAnimator * animator=[self animateForTransitionContext:transitionContext];
    
//    dispatch_after_f(dispatch_time(DISPATCH_TIME_NOW, [self transitionDuration:transitionContext]), dispatch_get_main_queue(), <#void *context#>, <#dispatch_function_t work#>)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)([self transitionDuration:transitionContext] * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        animator=nil;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    });

}
-(UIDynamicAnimator *)animateForTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return nil;
}
@end
