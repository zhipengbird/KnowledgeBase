//
//  ViewController.m
//  AnimationPropertyDemo
//
//  Created by shareit on 15/9/14.
//  Copyright (c) 2015年 shareit. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.view.layer addAnimation:[self backGroundAnimation] forKey:@"backgroundColor"];
//    self.view.layer.borderWidth=4;
//    [self.view.layer addAnimation:[self boderColorAnimation] forKey:@"borderColor"];
    
    UIView *subview=[[UIView alloc]initWithFrame:CGRectMake(20, 200, 200, 200)];
    UIView *subview1=[[UIView alloc]initWithFrame:CGRectMake(20, 200, 200, 200)];
    subview1.layer.anchorPoint=CGPointMake(0, 0);
    subview1.backgroundColor=[UIColor cyanColor];
    [self.view addSubview:subview1];
    [self.view addSubview:subview];
    
    subview.layer.cornerRadius=10;
    subview.layer.shadowRadius=10;
    subview.backgroundColor=[UIColor purpleColor];
    subview.layer.shadowOpacity=1;//隐阴的默认值是0
    subview.layer.shadowOffset=CGSizeMake(10, 10);
    subview.layer.shadowColor=[UIColor redColor].CGColor;
//    [subview.layer addAnimation:[self backGroundAnimation] forKey:@"backgroundColor"];
//    [subview.layer addAnimation:[self shadowColorAnimation] forKey:@"shadowColor"];
//    [subview .layer addAnimation:[self anchorPointAnimation] forKey:@"anchorPoint"];
//    [subview.layer addAnimation:[self frameAnimation] forKey:@"frame"];
    [subview.layer addAnimation:[self positionAnimation] forKey:@"position"];
    [subview.layer addAnimation:[self boundsAnimation] forKey:@"bounds"];
    
    // Do any additional setup after loading the view, typically from a nib.
}
-(CABasicAnimation *)boundsAnimation
{
    CABasicAnimation *boundAnimation=[CABasicAnimation animationWithKeyPath:@"bounds"];
    [boundAnimation setDuration:5];
    [boundAnimation setFromValue:[NSValue valueWithCGRect:CGRectMake(0, 0, 20, 20)]];
    [boundAnimation setToValue:[NSValue valueWithCGRect:CGRectMake(0, 0, 300, 300)]];
    return boundAnimation;
    
}
-(CABasicAnimation *)positionAnimation
{
    CABasicAnimation *positonAnimation=[CABasicAnimation animationWithKeyPath:@"position"];
    [positonAnimation setDuration:5];
    [positonAnimation setFromValue:[NSValue valueWithCGPoint:CGPointMake(0, 0)]];
    [positonAnimation setToValue:[NSValue valueWithCGPoint:CGPointMake(250, 300)]];
    [positonAnimation setRemovedOnCompletion:NO];
    return positonAnimation;
    
    
}
-(CABasicAnimation *)anchorPointAnimation
{
    CABasicAnimation * anchorPointAnimation=[CABasicAnimation animationWithKeyPath:@"anchorPoint"];
    
    [anchorPointAnimation setDuration:5];
    [anchorPointAnimation setFromValue: [NSValue valueWithCGPoint:CGPointMake(.5, .5) ]];
    [anchorPointAnimation setToValue:[NSValue valueWithCGPoint:CGPointMake(0, 0)]];
    [anchorPointAnimation setRemovedOnCompletion:NO];
    return  anchorPointAnimation;
}
-(CABasicAnimation *)shadowColorAnimation
{
    CABasicAnimation * shadowColorAnimation=[CABasicAnimation animationWithKeyPath:@"shadowColor"];
    
    [shadowColorAnimation setDuration:5];
    [shadowColorAnimation setFromValue:(__bridge id)[UIColor purpleColor].CGColor];
    [shadowColorAnimation setToValue:(__bridge id)[UIColor yellowColor].CGColor];
    [shadowColorAnimation setRemovedOnCompletion:NO];
    return  shadowColorAnimation;
}
-(CABasicAnimation *)backGroundAnimation
{
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    [animation setDuration:5.0];
    
    CGColorRef red=CGColorCreateCopyWithAlpha([UIColor redColor ].CGColor, 1);
    CGColorRef green=CGColorCreateCopyWithAlpha([UIColor greenColor].CGColor, 1);
    [animation setFromValue:(__bridge id)red];
    [animation setToValue:(__bridge id)green];
    
    [animation setRemovedOnCompletion:NO];
    CFRelease(red);
    CFRelease(green);
    
    return animation;
}
-(CABasicAnimation*)frameAnimation
{
#warning  对于框架的属性在层中不能做动画，可以设置这个参数和层内部改变的值，如果要改变边框的大小可以使用bounds做动画，改变位置可以使用position属性做动画
    CABasicAnimation *frameAnimation=[CABasicAnimation animationWithKeyPath:@"frame"];
    [frameAnimation setDuration:4];
    [frameAnimation setFromValue:[NSValue valueWithCGRect:CGRectMake(20, 200, 200, 200)]];
    [frameAnimation setToValue:[NSValue valueWithCGRect:CGRectMake(20, 400, 20, 200)]];
    return frameAnimation;
    
}
-(CABasicAnimation*)boderColorAnimation
{
    CABasicAnimation * boderColorAnimation=[CABasicAnimation animationWithKeyPath:@"borderColor"];
    
    [boderColorAnimation setDuration:5];
    [boderColorAnimation setFromValue:(__bridge id)[UIColor purpleColor].CGColor];
    [boderColorAnimation setToValue:(__bridge id)[UIColor yellowColor].CGColor];
    
    return  boderColorAnimation;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
