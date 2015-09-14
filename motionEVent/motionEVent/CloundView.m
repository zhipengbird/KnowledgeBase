//
//  CloundView.m
//
//  Code generated using QuartzCode 1.21 on 15/9/8.
//  www.quartzcodeapp.com
//

#import "CloundView.h"
#import "QCMethod.h"


@interface CloundView ()

@property (nonatomic, strong) CAShapeLayer *cloud;
@property (nonatomic, strong) CAShapeLayer *cloud2;
@property (nonatomic, strong) CAShapeLayer *cloud3;
@property (nonatomic, strong) CAShapeLayer *cloud4;

@end

@implementation CloundView

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		[self setupLayers];
	}
	return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
	self = [super initWithCoder:coder];
	if (self) {
		[self setupLayers];
	}
	return self;
}


- (void)setupLayers{
	CAShapeLayer * cloud = [CAShapeLayer layer];
	cloud.anchorPoint   = CGPointMake(0.6, 0.5);
	cloud.frame         = CGRectMake(62.5, 125.48, 160, 111.48);
	cloud.fillColor     = nil;
	cloud.strokeColor   = [UIColor blackColor].CGColor;
	cloud.lineWidth     = 3;
	cloud.strokeEnd     = 0;
	cloud.lineDashPhase = 1.5;
	cloud.path          = [self cloudPath].CGPath;
	[self.layer addSublayer:cloud];
	_cloud = cloud;
	
	CAShapeLayer * cloud2 = [CAShapeLayer layer];
	cloud2.anchorPoint   = CGPointMake(0.6, 0.5);
	cloud2.frame         = CGRectMake(62, 124.98, 160, 111.48);
	cloud2.fillColor     = nil;
	cloud2.strokeColor   = [UIColor blackColor].CGColor;
	cloud2.lineWidth     = 3;
	cloud2.strokeStart   = 1;
	cloud2.shadowColor   = [UIColor colorWithRed:0 green: 0 blue:0 alpha:0.333].CGColor;
	cloud2.shadowOpacity = 0.33;
	cloud2.shadowOffset  = CGSizeMake(4, 4);
	cloud2.shadowRadius  = 5;
	cloud2.path          = [self cloud2Path].CGPath;
	[self.layer addSublayer:cloud2];
	_cloud2 = cloud2;
	
	CAShapeLayer * cloud3 = [CAShapeLayer layer];
	cloud3.frame       = CGRectMake(97.35, 152.26, 160, 111.48);
	cloud3.fillColor   = [UIColor whiteColor].CGColor;
	cloud3.strokeColor = [UIColor blackColor].CGColor;
	cloud3.lineWidth   = 3;
	cloud3.strokeStart = 1;
	cloud3.path        = [self cloud3Path].CGPath;
	[self.layer addSublayer:cloud3];
	_cloud3 = cloud3;
	
	CAShapeLayer * cloud4 = [CAShapeLayer layer];
	cloud4.frame       = CGRectMake(97.37, 152.23, 160, 111.48);
	cloud4.lineJoin    = kCALineJoinRound;
	cloud4.fillColor   = nil;
	cloud4.strokeColor = [UIColor blackColor].CGColor;
	cloud4.lineWidth   = 3;
	cloud4.strokeEnd   = 0;
	cloud4.path        = [self cloud4Path].CGPath;
	[self.layer addSublayer:cloud4];
	_cloud4 = cloud4;
}


- (IBAction)startAllAnimations:(id)sender{
	[self.cloud  addAnimation:[self cloudAnimation] forKey:@"cloudAnimation"];
	[self.cloud2 addAnimation:[self cloud2Animation] forKey:@"cloud2Animation"];
	[self.cloud3 addAnimation:[self cloud3Animation] forKey:@"cloud3Animation"];
	[self.cloud4 addAnimation:[self cloud4Animation] forKey:@"cloud4Animation"];
}

- (CAAnimationGroup*)cloudAnimation{
	CABasicAnimation * strokeEndAnim = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
	strokeEndAnim.fromValue          = @0;
	strokeEndAnim.toValue            = @1;
	strokeEndAnim.duration           = 2;
	strokeEndAnim.beginTime          = 1.68;
	strokeEndAnim.timingFunction     = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
	
	CAAnimationGroup *cloudAnimGroup   = [CAAnimationGroup animation];
	cloudAnimGroup.animations          = @[strokeEndAnim];
	[cloudAnimGroup.animations setValue:kCAFillModeForwards forKeyPath:@"fillMode"];
	cloudAnimGroup.fillMode            = kCAFillModeForwards;
	cloudAnimGroup.removedOnCompletion = NO;
	cloudAnimGroup.duration = [QCMethod maxDurationFromAnimations:cloudAnimGroup.animations];
	
	
	return cloudAnimGroup;
}

- (CAAnimationGroup*)cloud2Animation{
	CABasicAnimation * strokeStartAnim = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
	strokeStartAnim.fromValue          = @0.7;
	strokeStartAnim.toValue            = @0;
	strokeStartAnim.duration           = 2;
	strokeStartAnim.beginTime          = 1.56;
	strokeStartAnim.timingFunction     = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
	
	CABasicAnimation * fillColorAnim = [CABasicAnimation animationWithKeyPath:@"fillColor"];
	fillColorAnim.toValue            = (id)[UIColor colorWithRed:0.373 green: 0.75 blue:0.93 alpha:1].CGColor;
	fillColorAnim.duration           = 0.778;
	fillColorAnim.beginTime          = 2.54;
	fillColorAnim.timingFunction     = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
	
	CAAnimationGroup *cloud2AnimGroup   = [CAAnimationGroup animation];
	cloud2AnimGroup.animations          = @[strokeStartAnim, fillColorAnim];
	[cloud2AnimGroup.animations setValue:kCAFillModeForwards forKeyPath:@"fillMode"];
	cloud2AnimGroup.fillMode            = kCAFillModeForwards;
	cloud2AnimGroup.removedOnCompletion = NO;
	cloud2AnimGroup.duration = [QCMethod maxDurationFromAnimations:cloud2AnimGroup.animations];
	
	
	return cloud2AnimGroup;
}

- (CABasicAnimation*)cloud3Animation{
	CABasicAnimation * strokeStartAnim = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
	strokeStartAnim.fromValue          = @1;
	strokeStartAnim.toValue            = @0;
	strokeStartAnim.duration           = 1.8;
	strokeStartAnim.timingFunction     = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
	strokeStartAnim.fillMode = kCAFillModeForwards;
	strokeStartAnim.removedOnCompletion = NO;
	
	return strokeStartAnim;
}

- (CAAnimationGroup*)cloud4Animation{
	CABasicAnimation * strokeEndAnim = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
	strokeEndAnim.fromValue          = @0;
	strokeEndAnim.toValue            = @1;
	strokeEndAnim.duration           = 1.8;
	strokeEndAnim.timingFunction     = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
	
	CABasicAnimation * fillColorAnim = [CABasicAnimation animationWithKeyPath:@"fillColor"];
	fillColorAnim.toValue            = (id)[UIColor colorWithRed:0.397 green: 0.797 blue:0.989 alpha:1].CGColor;
	fillColorAnim.duration           = 2;
	fillColorAnim.beginTime          = 1.24;
	fillColorAnim.timingFunction     = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
	
	CAKeyframeAnimation * shadowColorAnim  = [CAKeyframeAnimation animationWithKeyPath:@"shadowColor"];
	shadowColorAnim.values                 = @[(id)[UIColor blackColor].CGColor, 
		(id)[UIColor blackColor].CGColor, 
		(id)[UIColor colorWithRed:0.451 green: 0.451 blue:0.451 alpha:1].CGColor];
	shadowColorAnim.duration               = 1.62;
	shadowColorAnim.beginTime              = 2.8;
	shadowColorAnim.timingFunction         = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
	CAKeyframeAnimation * shadowOpacityAnim = [CAKeyframeAnimation animationWithKeyPath:@"shadowOpacity"];
	shadowOpacityAnim.values               = @[@0.216, @0.34, @0.601];
	shadowOpacityAnim.duration             = 1.62;
	shadowOpacityAnim.beginTime            = 2.8;
	shadowOpacityAnim.timingFunction       = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
	CAKeyframeAnimation * shadowOffsetAnim = [CAKeyframeAnimation animationWithKeyPath:@"shadowOffset"];
	shadowOffsetAnim.values                = @[[NSValue valueWithCGSize:CGSizeMake(0, 3)], 
		[NSValue valueWithCGSize:CGSizeMake(0, 10)], 
		[NSValue valueWithCGSize:CGSizeMake(8, 12)]];
	shadowOffsetAnim.duration              = 1.62;
	shadowOffsetAnim.beginTime             = 2.8;
	shadowOffsetAnim.timingFunction        = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
	
	CAAnimationGroup *cloud4AnimGroup   = [CAAnimationGroup animation];
	cloud4AnimGroup.animations          = @[strokeEndAnim, fillColorAnim, shadowColorAnim, shadowOpacityAnim, shadowOffsetAnim];
	[cloud4AnimGroup.animations setValue:kCAFillModeForwards forKeyPath:@"fillMode"];
	cloud4AnimGroup.fillMode            = kCAFillModeForwards;
	cloud4AnimGroup.removedOnCompletion = NO;
	cloud4AnimGroup.duration = [QCMethod maxDurationFromAnimations:cloud4AnimGroup.animations];
	
	
	return cloud4AnimGroup;
}

#pragma mark - Bezier Path

- (UIBezierPath*)cloudPath{
	UIBezierPath *cloudPath = [UIBezierPath bezierPath];
	[cloudPath moveToPoint:CGPointMake(139.84, 50.2)];
	[cloudPath addLineToPoint:CGPointMake(139.84, 48.6)];
	[cloudPath addCurveToPoint:CGPointMake(139.84, 41.08) controlPoint1:CGPointMake(139.84, 48.6) controlPoint2:CGPointMake(139.84, 48.28)];
	[cloudPath addCurveToPoint:CGPointMake(101.44, 0.6) controlPoint1:CGPointMake(139.84, 33.88) controlPoint2:CGPointMake(136, 5.4)];
	[cloudPath addCurveToPoint:CGPointMake(55.52, 23) controlPoint1:CGPointMake(71.04, -3.56) controlPoint2:CGPointMake(57.92, 15)];
	[cloudPath addCurveToPoint:CGPointMake(19.52, 54.68) controlPoint1:CGPointMake(55.52, 23) controlPoint2:CGPointMake(17.6, 16.28)];
	[cloudPath addCurveToPoint:CGPointMake(0, 82.2) controlPoint1:CGPointMake(19.52, 54.68) controlPoint2:CGPointMake(0, 64.28)];
	[cloudPath addCurveToPoint:CGPointMake(27.68, 111.48) controlPoint1:CGPointMake(0, 100.28) controlPoint2:CGPointMake(12.32, 111.48)];
	[cloudPath addCurveToPoint:CGPointMake(136, 111.48) controlPoint1:CGPointMake(43.04, 111.48) controlPoint2:CGPointMake(128.8, 111.48)];
	[cloudPath addCurveToPoint:CGPointMake(160, 82.68) controlPoint1:CGPointMake(143.2, 111.48) controlPoint2:CGPointMake(160, 100.28)];
	[cloudPath addCurveToPoint:CGPointMake(139.84, 50.2) controlPoint1:CGPointMake(160, 65.08) controlPoint2:CGPointMake(148.64, 55)];
	[cloudPath closePath];
	[cloudPath moveToPoint:CGPointMake(139.84, 50.2)];
	
	return cloudPath;
}

- (UIBezierPath*)cloud2Path{
	UIBezierPath *cloud2Path = [UIBezierPath bezierPath];
	[cloud2Path moveToPoint:CGPointMake(139.84, 50.2)];
	[cloud2Path addLineToPoint:CGPointMake(139.84, 48.6)];
	[cloud2Path addCurveToPoint:CGPointMake(139.84, 41.08) controlPoint1:CGPointMake(139.84, 48.6) controlPoint2:CGPointMake(139.84, 48.28)];
	[cloud2Path addCurveToPoint:CGPointMake(101.44, 0.6) controlPoint1:CGPointMake(139.84, 33.88) controlPoint2:CGPointMake(136, 5.4)];
	[cloud2Path addCurveToPoint:CGPointMake(55.52, 23) controlPoint1:CGPointMake(71.04, -3.56) controlPoint2:CGPointMake(57.92, 15)];
	[cloud2Path addCurveToPoint:CGPointMake(19.52, 54.68) controlPoint1:CGPointMake(55.52, 23) controlPoint2:CGPointMake(17.6, 16.28)];
	[cloud2Path addCurveToPoint:CGPointMake(0, 82.2) controlPoint1:CGPointMake(19.52, 54.68) controlPoint2:CGPointMake(0, 64.28)];
	[cloud2Path addCurveToPoint:CGPointMake(27.68, 111.48) controlPoint1:CGPointMake(0, 100.28) controlPoint2:CGPointMake(12.32, 111.48)];
	[cloud2Path addCurveToPoint:CGPointMake(136, 111.48) controlPoint1:CGPointMake(43.04, 111.48) controlPoint2:CGPointMake(128.8, 111.48)];
	[cloud2Path addCurveToPoint:CGPointMake(160, 82.68) controlPoint1:CGPointMake(143.2, 111.48) controlPoint2:CGPointMake(160, 100.28)];
	[cloud2Path addCurveToPoint:CGPointMake(139.84, 50.2) controlPoint1:CGPointMake(160, 65.08) controlPoint2:CGPointMake(148.64, 55)];
	[cloud2Path closePath];
	[cloud2Path moveToPoint:CGPointMake(139.84, 50.2)];
	
	return cloud2Path;
}

- (UIBezierPath*)cloud3Path{
	UIBezierPath *cloud3Path = [UIBezierPath bezierPath];
	[cloud3Path moveToPoint:CGPointMake(20.16, 50.2)];
	[cloud3Path addLineToPoint:CGPointMake(20.16, 48.6)];
	[cloud3Path addCurveToPoint:CGPointMake(20.16, 41.08) controlPoint1:CGPointMake(20.16, 48.6) controlPoint2:CGPointMake(20.16, 48.28)];
	[cloud3Path addCurveToPoint:CGPointMake(58.56, 0.6) controlPoint1:CGPointMake(20.16, 33.88) controlPoint2:CGPointMake(24, 5.4)];
	[cloud3Path addCurveToPoint:CGPointMake(104.48, 23) controlPoint1:CGPointMake(88.96, -3.56) controlPoint2:CGPointMake(102.08, 15)];
	[cloud3Path addCurveToPoint:CGPointMake(140.48, 54.68) controlPoint1:CGPointMake(104.48, 23) controlPoint2:CGPointMake(142.4, 16.28)];
	[cloud3Path addCurveToPoint:CGPointMake(160, 82.2) controlPoint1:CGPointMake(140.48, 54.68) controlPoint2:CGPointMake(160, 64.28)];
	[cloud3Path addCurveToPoint:CGPointMake(132.32, 111.48) controlPoint1:CGPointMake(160, 100.28) controlPoint2:CGPointMake(147.68, 111.48)];
	[cloud3Path addCurveToPoint:CGPointMake(24, 111.48) controlPoint1:CGPointMake(116.96, 111.48) controlPoint2:CGPointMake(31.2, 111.48)];
	[cloud3Path addCurveToPoint:CGPointMake(0, 82.68) controlPoint1:CGPointMake(16.8, 111.48) controlPoint2:CGPointMake(0, 100.28)];
	[cloud3Path addCurveToPoint:CGPointMake(20.16, 50.2) controlPoint1:CGPointMake(0, 65.08) controlPoint2:CGPointMake(11.36, 55)];
	[cloud3Path closePath];
	[cloud3Path moveToPoint:CGPointMake(20.16, 50.2)];
	
	return cloud3Path;
}

- (UIBezierPath*)cloud4Path{
	UIBezierPath *cloud4Path = [UIBezierPath bezierPath];
	[cloud4Path moveToPoint:CGPointMake(20.16, 50.2)];
	[cloud4Path addLineToPoint:CGPointMake(20.16, 48.6)];
	[cloud4Path addCurveToPoint:CGPointMake(20.16, 41.08) controlPoint1:CGPointMake(20.16, 48.6) controlPoint2:CGPointMake(20.16, 48.28)];
	[cloud4Path addCurveToPoint:CGPointMake(58.56, 0.6) controlPoint1:CGPointMake(20.16, 33.88) controlPoint2:CGPointMake(24, 5.4)];
	[cloud4Path addCurveToPoint:CGPointMake(104.48, 23) controlPoint1:CGPointMake(88.96, -3.56) controlPoint2:CGPointMake(102.08, 15)];
	[cloud4Path addCurveToPoint:CGPointMake(140.48, 54.68) controlPoint1:CGPointMake(104.48, 23) controlPoint2:CGPointMake(142.4, 16.28)];
	[cloud4Path addCurveToPoint:CGPointMake(160, 82.2) controlPoint1:CGPointMake(140.48, 54.68) controlPoint2:CGPointMake(160, 64.28)];
	[cloud4Path addCurveToPoint:CGPointMake(132.32, 111.48) controlPoint1:CGPointMake(160, 100.28) controlPoint2:CGPointMake(147.68, 111.48)];
	[cloud4Path addCurveToPoint:CGPointMake(24, 111.48) controlPoint1:CGPointMake(116.96, 111.48) controlPoint2:CGPointMake(31.2, 111.48)];
	[cloud4Path addCurveToPoint:CGPointMake(0, 82.68) controlPoint1:CGPointMake(16.8, 111.48) controlPoint2:CGPointMake(0, 100.28)];
	[cloud4Path addCurveToPoint:CGPointMake(20.16, 50.2) controlPoint1:CGPointMake(0, 65.08) controlPoint2:CGPointMake(11.36, 55)];
	[cloud4Path closePath];
	[cloud4Path moveToPoint:CGPointMake(20.16, 50.2)];
	
	return cloud4Path;
}

@end