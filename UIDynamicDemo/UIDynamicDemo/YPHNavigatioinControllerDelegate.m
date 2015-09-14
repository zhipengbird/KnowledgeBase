//
//  YPHNavigatioinControllerDelegate.m
//  UIDynamicDemo
//
//  Created by shareit on 15/9/11.
//  Copyright (c) 2015年 shareit. All rights reserved.
//

#import "YPHNavigatioinControllerDelegate.h"
#import "YPHSnapPushAnimator.h"
@implementation YPHNavigatioinControllerDelegate
-(instancetype)initWithTransitionType:(NSInteger)transitionType
{
    self =[super init];
    if (self) {
        if (transitionType>YPH_TRANSITION_TYPE_SNAP) {
            transitionType=0;
        }
        self.transitionType=transitionType;
    }
    return self;
}

-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    
    
    if (operation==UINavigationControllerOperationPush) {
        if (self.transitionType==0) {
            return [[YPHSnapPushAnimator alloc]init];
        }
        else
            return nil;
    }
    else
        return nil;
}
@end
