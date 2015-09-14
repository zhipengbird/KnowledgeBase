//
//  ViewController.h
//  UIEmotionEffect
//
//  Created by shareit on 15/9/1.
//  Copyright (c) 2015年 shareit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIAccelerometerDelegate>
{
    UIAccelerationValue myAccelerometer[3];
    BOOL  _canShake;  
}


@end

