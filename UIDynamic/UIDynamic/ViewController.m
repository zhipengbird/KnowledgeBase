//
//  ViewController.m
//  UIDynamic
//
//  Created by shareit on 15/9/10.
//  Copyright (c) 2015年 shareit. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,strong)UIDynamicAnimator * animator;
@property(nonatomic,strong)UISnapBehavior *snap;
@property(nonatomic,strong)UIView *snapview;
@property(nonatomic,strong)UIView *snapview1;
@property(nonatomic,strong)UIGravityBehavior *gravity;
@property(nonatomic,strong)UIDynamicItemBehavior *itemBehavior;
@property(nonatomic,strong)UICollisionBehavior * collistionBehavior;

@property(nonatomic,strong)UIAttachmentBehavior *attachBehavior;

@property(nonatomic,strong)UIPushBehavior * pushBehavior;
@end

@implementation ViewController

-(void)viewDidAppear:(BOOL)animated
{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    

    _animator=[[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    _snapview=[[UIView alloc]initWithFrame:CGRectMake(20, 200, 100, 100)];
    _snapview.backgroundColor=[UIColor redColor];
    [self.view addSubview:_snapview];
    _snapview1=[[UIView alloc]initWithFrame:CGRectMake(200, 200, 100, 100)];
    _snapview1.backgroundColor=[UIColor purpleColor];
    [self.view addSubview:_snapview1];
 
    _snap=[[UISnapBehavior alloc]initWithItem:_snapview snapToPoint:self.view.center];
    _snap.damping=.3;
    
//    [_animator addBehavior:_snap];
    _itemBehavior=[[UIDynamicItemBehavior alloc]initWithItems:@[_snapview,_snapview1]];
    _itemBehavior.elasticity=0.7;
    [_animator addBehavior:_itemBehavior];
    _gravity=[[UIGravityBehavior alloc]initWithItems:@[_snapview,_snapview1]];
    _gravity.gravityDirection=CGVectorMake(0, 1);
    _gravity.magnitude=.4;
    [_animator addBehavior:_gravity];
    _collistionBehavior=[[UICollisionBehavior alloc]initWithItems:@[_snapview,_snapview1]];
    [_collistionBehavior setTranslatesReferenceBoundsIntoBoundary:true];
    [_animator addBehavior:_collistionBehavior];
    
    
    _attachBehavior=[[UIAttachmentBehavior alloc]initWithItem:_snapview attachedToAnchor:self.view.center];
    _attachBehavior.length=100;
    _attachBehavior.damping=1;
    _attachBehavior.frequency=1;
//    [_animator addBehavior:_attachBehavior];
    
    _pushBehavior =[[UIPushBehavior alloc]initWithItems:@[_snapview1] mode:UIPushBehaviorModeContinuous];
    [_animator addBehavior:_pushBehavior];
    UITapGestureRecognizer *gesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer:gesture];
   
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)tap:(UITapGestureRecognizer*)gesture
{
    CGPoint point= [gesture locationInView:self.view];
    
    CGPoint viewcente=_snapview1.center;
    
    
    CGFloat deltaX=point.x-viewcente.x;
    CGFloat deltaY=point.y-viewcente.y;
    
    CGFloat angle=atan2(deltaY, deltaX);
    
    [self.pushBehavior setAngle:angle];
    
    CGFloat distance=sqrt(pow(point.x-viewcente.x, 2.0)+pow(point.y-viewcente.y, 2.0));
    [self.pushBehavior setMagnitude:distance/20.0f];
    [self.animator removeBehavior:_snap];
    _snap=[[UISnapBehavior alloc]initWithItem:_snapview snapToPoint:point];
    [_animator addBehavior:_snap];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
