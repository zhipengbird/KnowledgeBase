//
//  ViewController.m
//  UIDynamicDemo
//
//  Created by shareit on 15/9/11.
//  Copyright (c) 2015年 shareit. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setDetailItem:(NSString *)detailItem
{
    self.title=detailItem;
}
@end
