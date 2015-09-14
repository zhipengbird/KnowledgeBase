//
//  ViewController.m
//  NSSlide
//
//  Created by shareit on 15/8/5.
//  Copyright (c) 2015年 shareit. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor blackColor];
    //左右轨的图片
    UIImage *stetchLeftTrack= [UIImage imageNamed:@"slide.png"];
    UIImage *stetchRightTrack = [UIImage imageNamed:@"timestrip.png"];
    //滑块图片
    UIImage *thumbImage = [UIImage imageNamed:@"白色小圆.png"];
    
    UISlider *sliderA=[[UISlider alloc]initWithFrame:CGRectMake(30, 320, 300, 7)];
    sliderA.backgroundColor = [UIColor clearColor];
    sliderA.value=1.0;
    sliderA.minimumValue=1;
    sliderA.maximumValue=100;
    
    [sliderA setMinimumTrackImage:stetchLeftTrack forState:UIControlStateNormal];
    [sliderA setMaximumTrackImage:stetchRightTrack forState:UIControlStateNormal];
    //注意这里要加UIControlStateHightlighted的状态，否则当拖动滑块时滑块将变成原生的控件
    [sliderA setThumbImage:thumbImage forState:UIControlStateHighlighted];
    [sliderA setThumbImage:thumbImage forState:UIControlStateNormal];
    //滑块拖动时的事件
    [sliderA addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    //滑动拖动后的事件
    [sliderA addTarget:self action:@selector(sliderDragUp:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:sliderA];

    // Do any additional setup after loading the view, typically from a nib.
}
-(void)sliderValueChanged:(UISlider *)slide
{
    NSLog(@"%f",slide.value);
}
-(void)sliderDragUp:(UISlider *)slide
{
    NSLog(@"%f",slide.value);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
