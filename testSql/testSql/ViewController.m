//
//  ViewController.m
//  testSql
//
//  Created by shareit on 15/8/25.
//  Copyright (c) 2015年 shareit. All rights reserved.
//

#import "ViewController.h"
#import "PlayGameDefaultCard.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [PlayGameDefaultCard loadDefaultCard:nil AndCardID:0];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
