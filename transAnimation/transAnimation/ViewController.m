//
//  ViewController.m
//  transAnimation
//
//  Created by shareit on 15/9/9.
//  Copyright © 2015年 shareit. All rights reserved.
//

#import "ViewController.h"
#import "MyTransition.h"
@interface ViewController ()

{
    UIView * subview1;
    UIView * subview2;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0, 400, 100, 100);
    [self.view addSubview:button];
    [button setTitle:@"next" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(Next) forControlEvents:UIControlEventTouchUpInside];
    
    subview1=[[UIView alloc]initWithFrame:CGRectMake(0, 70, 300, 300)];
    subview1.backgroundColor=[UIColor grayColor];
    [self.view addSubview:subview1];
    subview2=[[UIView alloc]initWithFrame:CGRectMake(0, 70, 300, 300)];
    subview2.backgroundColor=[UIColor cyanColor];
    [self.view addSubview:subview2];
    
}
-(void)Next
{
    MyTransition * tranistion=[MyTransition catransitionWithType:@"cameraIrisHollowOpen" subType:@"fromRight" duration:1.3 timingFunction:@"easeInEaseOut"];
    
    
    [subview2.layer addAnimation:tranistion forKey:@"animation"];
    [UIView transitionFromView:subview1 toView:subview2 duration:1 options:UIViewAnimationOptionBeginFromCurrentState completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
