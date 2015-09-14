//
//  ViewController.m
//  CALayerDemo
//
//  Created by shareit on 15/8/3.
//  Copyright (c) 2015年 shareit. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,strong)CALayer *layer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.layer.borderColor=[UIColor cyanColor].CGColor;
    self.view.layer.borderWidth=10;
    self.view.layer.cornerRadius=20;
    self.view.backgroundColor=[UIColor whiteColor];
    self.view.layer.contentsGravity=@"resizeAspect";
    self.layer=[CALayer layer];
    [self.view.layer addSublayer:self.layer];
    
    self.layer.bounds=CGRectMake(0,0, 200, 300);
    self.layer.anchorPoint=CGPointMake(.5, .5);
    self.layer.position=self.view.center;
    self.layer.borderColor=[UIColor purpleColor].CGColor;
    self.layer.borderWidth=2;
    UIImage *image=[UIImage imageNamed:@"羊羊.png"];
    self.layer.contents= (__bridge id)(image.CGImage);
    self.layer.contentsScale=0.1;
    
//    self.layer.cornerRadius=50;
//    self.layer.shadowColor=[UIColor redColor].CGColor;
//    self.layer.shadowOffset=CGSizeMake(2, 3);
//    self.layer.shadowOpacity=.5;
//    self.layer.shadowRadius=1;
   
    self.layer.doubleSided=YES;
    
//    self.view.layer.backgroundColor=[UIColor blueColor].CGColor;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
