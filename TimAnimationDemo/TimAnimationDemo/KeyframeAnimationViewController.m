//
//  KeyframeAnimationViewController.m
//  TimAnimationDemo
//
//  Created by 李佳 on 15/9/15.
//  Copyright © 2015年 LiJia. All rights reserved.
//

#import "KeyframeAnimationViewController.h"

@interface KeyframeAnimationViewController ()
@property(nonatomic, strong)UIImageView* showView;
@end

@implementation KeyframeAnimationViewController

- (instancetype) init
{
    if (self = [super init])
    {
        [self initShowView];
    }
    return self;
}

- (void)initShowView
{
    self.showView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
    self.showView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.showView];
    self.showView.backgroundColor = [UIColor redColor];
    [self addKeyframeAnimationBtns];
}

- (void)addKeyframeAnimationBtns
{
    NSArray* basicAnimationArr = [self keyframeAnimationNames];
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
    NSArray* keyframeFunctions = [self keyframeAnimationFunctions];
    NSString* functionName = keyframeFunctions[btn.tag];
    
    SEL sel = NSSelectorFromString(functionName);
    if ([self respondsToSelector:sel])
        [self performSelector:sel];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)positionKeyframeAnimation
{
    CAKeyframeAnimation* posKeyframeAnimation = [[CAKeyframeAnimation alloc] init];
    
    posKeyframeAnimation.keyPath = @"position";
    NSValue* value = [NSValue valueWithCGPoint:CGPointMake(self.view.center.x, self.view.center.y)];
    NSValue* value1 = [NSValue valueWithCGPoint:CGPointMake(50, 50)];
    NSValue* value2 = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
    NSValue* value3 = [NSValue valueWithCGPoint:CGPointMake(100, 0)];
    NSValue* value4 = [NSValue valueWithCGPoint:CGPointMake(200, 200)];

    posKeyframeAnimation.values = @[value, value1, value2, value3, value4];
    posKeyframeAnimation.keyTimes = @[@0.1, @0.2, @0.4, @0.75, @1];
    posKeyframeAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    posKeyframeAnimation.fillMode = kCAFillModeForwards;
    posKeyframeAnimation.duration = 8.0;
    posKeyframeAnimation.delegate = self;
    posKeyframeAnimation.removedOnCompletion = NO;
    
    [self.showView.layer addAnimation:posKeyframeAnimation forKey:@"positionKeyframeAnimation"];
}

- (void)rotationKeyframeAnimation
{
    CAKeyframeAnimation* rotationKeyframeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    rotationKeyframeAnimation.values = @[@(-4 * M_PI / 180), @(4 * M_PI / 180),@(-4 * M_PI / 180)];
    rotationKeyframeAnimation.repeatCount = 5.0;
    rotationKeyframeAnimation.delegate = self;
    rotationKeyframeAnimation.duration = 1;
    rotationKeyframeAnimation.removedOnCompletion = NO;
    rotationKeyframeAnimation.fillMode = kCAFillModeForwards;
    
    [self.showView.layer addAnimation:rotationKeyframeAnimation forKey:@"rotationKeyframeAnimation"];
}

- (void)pathRefkeyframeAnimation
{
    CAKeyframeAnimation* pathKeyframeAnimation = [CAKeyframeAnimation animation];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 100, 100);
    CGPathAddLineToPoint(path, NULL, 300, 300);
    CGPathAddArc(path, NULL, 100, 100, 100, 0, 2 * M_PI, 0);
    pathKeyframeAnimation.keyPath = @"position";
    //CGPathAddEllipseInRect(path, NULL, CGRectMake(150, 100, 100, 100));
    pathKeyframeAnimation.path = path;
    pathKeyframeAnimation.repeatCount = 6;
    pathKeyframeAnimation.duration = 4.0f;
    pathKeyframeAnimation.delegate = self;
    pathKeyframeAnimation.removedOnCompletion = NO;
    pathKeyframeAnimation.fillMode = kCAFillModeForwards;
    //CGPathRelease(path);
    
    [self.showView.layer addAnimation:pathKeyframeAnimation forKey:nil];
}


- (NSArray*)keyframeAnimationNames
{
    return @[@"position", @"transform.rotation", @"CGPathRef"];
}

- (NSArray*)keyframeAnimationFunctions
{
    return @[@"positionKeyframeAnimation", @"rotationKeyframeAnimation", @"pathRefkeyframeAnimation"];
}

- (void)animationDidStart:(CAAnimation *)anim
{
    NSLog(@"开始动画");
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSLog(@"结束动画");
}
@end
