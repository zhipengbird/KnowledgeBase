//
//  YPHSnapPushAnimator.m
//  UIDynamicDemo
//
//  Created by shareit on 15/9/11.
//  Copyright (c) 2015年 shareit. All rights reserved.
//

#import "YPHSnapPushAnimator.h"

@implementation YPHSnapPushAnimator
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.8f;
}
-(UIDynamicAnimator *)animateForTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext
{
//    UIViewController * fromViewController=[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//    UIViewController * toViewController=[transitionContext viewControllerForKey: UITransitionContextToViewControllerKey];
//    toViewController.view.frame=CGRectOffset(fromViewController.view.frame, 0.6*fromViewController.view.frame.size.width, 0);
//    [[transitionContext containerView]addSubview:toViewController.view];
//    
//    
//    UIDynamicAnimator * animator=[[UIDynamicAnimator alloc]initWithReferenceView:[transitionContext containerView]];
//    UISnapBehavior * snapBehavior=[[UISnapBehavior alloc]initWithItem:toViewController.view snapToPoint:fromViewController.view.center];
//    [animator addBehavior:snapBehavior];
//    return animator;
    // Get the view controllers for the transition
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    // Prepare the view of the toViewController
    toViewController.view.frame = CGRectOffset(fromViewController.view.frame, 0.6f*fromViewController.view.frame.size.width, 0);
    
    // Add the view of the toViewController to the containerView
    [[transitionContext containerView] addSubview:toViewController.view];
    
    // Create animator
    UIDynamicAnimator *animator = [[UIDynamicAnimator alloc] initWithReferenceView:[transitionContext containerView]];
    
    // Add behaviors
    UISnapBehavior* snapBehavior = [[UISnapBehavior alloc] initWithItem:toViewController.view snapToPoint:fromViewController.view.center];
    [animator addBehavior:snapBehavior];
    
    return animator;
    
}
@end
