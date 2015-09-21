//
//  ViewController.m
//  UsuallMacro
//
//  Created by shareit on 15/9/18.
//  Copyright (c) 2015年 shareit. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self usuallMacro];
    
}
#pragma mark 常用宏学习

-(void)usuallMacro
{
    NSMutableString  * macroInfo=[NSMutableString string];
    [macroInfo appendFormat:@"\n__function:%s\n",__func__ ];
    [macroInfo appendFormat:@"__FUNCTION__:%s\n",__FUNCTION__ ];
     [macroInfo appendFormat:@"__PRETTY_FUNCTION__:%s\n",__PRETTY_FUNCTION__ ];
    [macroInfo appendFormat:@"__FILE__:%s\n",__FILE__];
    [macroInfo appendFormat:@"__FLT_DENORM_MIN__:%f\n",__FLT_DENORM_MIN__ ];
    [macroInfo appendFormat:@"__FOUNDATION_NSPOINTERFUNCTIONS__:%d\n",__FOUNDATION_NSPOINTERFUNCTIONS__ ];
    [macroInfo appendFormat:@"__FINITE_MATH_ONLY__:%d\n",__FINITE_MATH_ONLY__ ];
    [macroInfo appendFormat:@"__FLT_EVAL_METHOD__:%d\n",__FLT_EVAL_METHOD__];
    [macroInfo appendFormat:@"__FOUNDATION_NSMAPTABLE__:%d\n",__FOUNDATION_NSMAPTABLE__];
    [macroInfo appendFormat:@"__FOUNDATION_NSMAPTABLE__:%d\n",__FOUNDATION_NSMAPTABLE__];
    [macroInfo appendFormat:@"__LINE__:%d\n",__LINE__];
    [macroInfo appendFormat:@"__LITTLE_ENDIAN__:%d\n",__LITTLE_ENDIAN__];
    
    
    NSLog(@"%@",macroInfo);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
