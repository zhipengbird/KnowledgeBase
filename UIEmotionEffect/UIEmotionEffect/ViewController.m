//
//  ViewController.m
//  UIEmotionEffect
//
//  Created by shareit on 15/9/1.
//  Copyright (c) 2015年 shareit. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    NSMutableString * string=[NSMutableString stringWithString:@"9BBC7D7E-0633-4A3E-AB44-E1C6C5212B93"];
//    [string replaceOccurrencesOfString:@"-" withString:@"" options:0 range:NSMakeRange(0, string.length)];
    
    UIImageView *imageview_1=[[UIImageView alloc]initWithFrame:CGRectMake(20, 100, 100, 100)];
    [imageview_1 setCenter:self.view.center];
    imageview_1.image=[UIImage imageNamed:@"btn-b-1.png"];
    [self.view addSubview:imageview_1];
    [self registerEffectForView:imageview_1 depth:150];
    
    UIImageView *imageview_2=[[UIImageView alloc]initWithFrame:CGRectMake(20, 100, 100, 100)];
    [imageview_2 setCenter:self.view.center];
    imageview_2.image=[UIImage imageNamed:@"btn-b-2.png"];
    [self.view addSubview:imageview_2];
    [self registerEffectForView:imageview_2 depth:50];
    
    UIGestureRecognizer
    // Do any additional setup after loading the view, typically from a nib.
}


  
-(void)registerEffectForView:(UIView *)view depth:(float)deep
{
    UIInterpolatingMotionEffect *effectX;
    UIInterpolatingMotionEffect *effectY;
    UIInterpolatingMotionEffect *effectShadowoffset;
    effectShadowoffset=[[UIInterpolatingMotionEffect alloc]initWithKeyPath:@"layer.shadowOffset" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    effectX=[[UIInterpolatingMotionEffect alloc]initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    effectY=[[UIInterpolatingMotionEffect alloc]initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    effectX.minimumRelativeValue=@(deep);
    effectX.maximumRelativeValue=@(-deep);
    effectY.minimumRelativeValue=@(deep);
    effectY.maximumRelativeValue=@(-deep);
    effectShadowoffset.minimumRelativeValue=[NSValue valueWithCGSize:CGSizeMake(-40, 5)];
    effectShadowoffset.maximumRelativeValue=[NSValue valueWithCGSize:CGSizeMake(40, 5)];
    [view addMotionEffect:effectShadowoffset];
    [view addMotionEffect:effectX];
    [view addMotionEffect:effectY];

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches) {
        NSLog(@"1%lf",touch.timestamp);
    }
//     NSLog(@"%@", [event touchesForWindow:self.view.window]);
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches) {
        NSLog(@"2%lf",touch.timestamp);
    }
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches) {
        NSLog(@"3%lf",touch.timestamp);
    }
}
//-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
//{
//
//    NSLog(@"%ld,%@",(long)motion,event);
//    NSLog(@"%@", [event touchesForWindow:self.view.window]);
//}
//
//-(void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
//{
//    NSLog(@"%ld,%@",(long)motion,event);
//}
//-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
//{
//    NSLog(@"%ld,%@",(long)motion,event);
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
