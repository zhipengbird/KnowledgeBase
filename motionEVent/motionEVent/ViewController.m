//
//  ViewController.m
//  motionEVent
//
//  Created by shareit on 15/9/1.
//  Copyright © 2015年 shareit. All rights reserved.
//

#import "ViewController.h"
#import "CloundView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self becomeFirstResponder];
    CloundView *view=[[CloundView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    [self.view addSubview:view];
    [view startAllAnimations:nil];
//    NSProcessInfo


    // Do any additional setup after loading the view, typically from a nib.
}
-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
}
-(void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    
}
-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
