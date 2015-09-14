//
//  YPHNavigatioinControllerDelegate.h
//  UIDynamicDemo
//
//  Created by shareit on 15/9/11.
//  Copyright (c) 2015年 shareit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, YPH_TRANSITION_TYPE)
{
    YPH_TRANSITION_TYPE_SNAP
};

@interface YPHNavigatioinControllerDelegate : NSObject<UINavigationControllerDelegate>
@property (nonatomic,assign)NSInteger transitionType;
-(instancetype)initWithTransitionType:(NSInteger)transitionType;
@end
