//
//  BasicAnimationViewController.m
//  TimAnimationDemo
//
//  Created by 李佳 on 15/9/14.
//  Copyright © 2015年 LiJia. All rights reserved.
//

#import "BasicAnimationViewController.h"


@interface BasicAnimationViewController ()
@property(nonatomic, strong)UIView* showView;
@end

@implementation BasicAnimationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (instancetype)init
{
    if (self = [super init])
    {
        [self initView];
    }
    return self;
}

- (void)initView
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    _showView = [[UIView alloc] initWithFrame:CGRectMake((screenRect.size.width - viewSize) / 2, (screenRect.size.width - viewSize) / 2, viewSize, viewSize)];
    _showView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_showView];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initAnimationBtn];
}

- (void)initAnimationBtn
{
    NSArray* basicAnimationArr = [self basicAnimationNames];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat btnWidth = (screenRect.size.width - 2 * btnMargins) / 5.5;
    
    for (int i = 0; i < basicAnimationArr.count; ++i)
    {
        UIButton* btn = [[UIButton alloc] init];
        btn.frame = CGRectMake(btnMargins + i % 4 * btnWidth * 1.5, screenRect.size.height / 2 + viewSize + (i / 4) * 2 * btnHeight , btnWidth, btnHeight);
        btn.backgroundColor = [UIColor grayColor];
        btn.tag = i;
        [btn setTitle:basicAnimationArr[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(addAnimationToView:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}

- (void)addAnimationToView: (id)sender
{
    UIButton* btn = sender;
    [self.showView.layer removeAllAnimations];
    NSArray* animationFunctionArr = [self animationFunctionNames];
    NSString* functionName = animationFunctionArr[btn.tag];
    SEL sel = NSSelectorFromString(functionName);
    if ([self respondsToSelector:sel])
        [self performSelector:sel withObject:nil];
}

- (void)positionAnimation
{
    //创建基础动画。
    CABasicAnimation* positiontAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    positiontAnimation.duration = 2.0f;
    positiontAnimation.toValue = [NSValue valueWithCGPoint: CGPointMake(100, 100)];
    positiontAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(200, 400)];
    
    [self.showView.layer addAnimation:positiontAnimation forKey:@"positionAnimation"];
    
    //block 模式
    self.showView.frame = CGRectMake(50, 50, viewSize, viewSize);
    [UIView animateWithDuration:2.0 animations:^()
    {
        self.showView.frame = CGRectMake(200, 200, viewSize, viewSize);
    }
    completion:^(BOOL finished)
    {
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        self.showView.frame = CGRectMake((screenRect.size.width - viewSize) / 2, (screenRect.size.width - viewSize) / 2, viewSize, viewSize);
    }];
    
    //begin commit模式
    self.showView.frame = CGRectMake(50, 50, viewSize, viewSize);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:2];
    
    self.showView.frame = CGRectMake(300, 400, viewSize, viewSize);
    [UIView commitAnimations];
}

- (void)scaleAnimation
{
    CABasicAnimation* scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat: 1.0f];
    scaleAnimation.toValue = [NSNumber numberWithFloat:0.2f];
    scaleAnimation.duration = 2.0f;
    
    [self.showView.layer addAnimation:scaleAnimation forKey:@"scaleAnimation"];
}

- (void)alphaAnimation
{
    self.showView.alpha = 1;
    [UIView animateWithDuration:2.0f animations:^()
    {
        self.showView.alpha = 0;
    }completion:^(BOOL finished)
    {
        self.showView.alpha = 0.5;
    }];
}

- (void)backgroundColorAnimation
{
//    self.showView.backgroundColor = [UIColor redColor];
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:2.0f];
//    self.showView.backgroundColor = [UIColor greenColor];
//    
//    [UIView commitAnimations];
    CABasicAnimation* backGroundAnimation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    backGroundAnimation.duration = 2.0f;
    backGroundAnimation.toValue = (__bridge id _Nullable)([UIColor greenColor].CGColor);
    backGroundAnimation.fromValue = (__bridge id _Nullable)([UIColor redColor].CGColor);
    backGroundAnimation.delegate = self;
    [self.showView.layer addAnimation:backGroundAnimation forKey:nil];
}

- (void)rotationAnimation
{
    CABasicAnimation* rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotation.toValue = [NSNumber numberWithFloat:M_PI];
    rotation.duration = 2.0f;
    [self.showView.layer addAnimation:rotation forKey:@"rotation"];
}

- (void)boundsAnimation
{
    self.showView.bounds = CGRectMake(0, 0, viewSize, viewSize);
    [UIView animateWithDuration:1.0f animations:^{
        self.showView.bounds = CGRectMake(0, 0, viewSize * 2, viewSize * 2);
    }];
}

- (void)zPositionAnimation
{
    self.view.backgroundColor = [UIColor greenColor];
    CABasicAnimation* zPosition = [CABasicAnimation animationWithKeyPath:@"zPosition"];
    zPosition.fromValue = [NSNumber numberWithFloat:0];
    zPosition.toValue = [NSNumber numberWithFloat:100];
    zPosition.duration = 2.0f;
    [self.showView.layer addAnimation:zPosition forKey:@"zPositionAnimation"];
}

- (void)anchorPointAnimation
{
    [UIView animateWithDuration:2.0f animations:^{
        self.showView.layer.anchorPoint = CGPointMake(0, 0);
    }];
}

- (void)anchorPointZAnimation
{
    [UIView animateWithDuration:2.0f animations:^{
        self.showView.layer.anchorPointZ = 1.0f;
    }];
}

- (void)cornerRadiusAnimation
{
    CABasicAnimation* cornerRadius = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    cornerRadius.toValue = [NSNumber numberWithFloat:10.0f];
    cornerRadius.fromValue = [NSNumber numberWithFloat:0.0f];
    cornerRadius.duration = 2.0f;
    cornerRadius.removedOnCompletion = NO;
    [self.showView.layer addAnimation:cornerRadius forKey:@"cornerRadiusAniamtion"];
}


- (NSArray*)basicAnimationNames
{
    return @[@"position", @"scale", @"alpha", @"color", @"rotation", @"bounds", @"zPosition",
             @"anchorPoint", @"anchorPointZ", @"cornerRadius"];
}

- (NSArray*)animationFunctionNames
{
    return @[@"positionAnimation", @"scaleAnimation", @"alphaAnimation", @"backgroundColorAnimation",
             @"rotationAnimation", @"boundsAnimation", @"zPositionAnimation", @"anchorPointAnimation",
             @"anchorPointZAnimation", @"cornerRadiusAnimation"];
}


- (void)animationDidStart:(CAAnimation *)anim
{
    NSLog(@"基本动画开始");
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSLog(@"基本动画结束");
}

@end
