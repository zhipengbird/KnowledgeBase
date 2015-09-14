//
//  MyTransition.m
//  transAnimation
//
//  Created by shareit on 15/9/9.
//  Copyright © 2015年 shareit. All rights reserved.
//

#import "MyTransition.h"

@implementation MyTransition
+ (MyTransition *)catransitionWithType:(NSString *)type subType:(NSString *)subType duration:(double)duration timingFunction:(NSString *)timingName {
    
    // 转场动画
    
    MyTransition * animation = [MyTransition animation];
    
    animation.type = type;
    
    animation.subtype = subType;
    
    animation.duration = duration;
    
    animation.timingFunction = [CAMediaTimingFunction functionWithName:timingName];
    
    return animation;
    
}
@end
