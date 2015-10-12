//
//  springAnimationViewController.m
//  TimAnimationDemo
//
//  Created by 李佳 on 15/9/16.
//  Copyright © 2015年 LiJia. All rights reserved.
//

#import "springAnimationViewController.h"

@interface springAnimationViewController ()
@property(nonatomic, strong)UIView* showView;
@end

@implementation springAnimationViewController

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
    [self addSpringAnimationBtns];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)addSpringAnimationBtns
{
    NSArray* basicAnimationArr = [self springAnimationNames];
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
    NSArray* keyframeFunctions = [self springAnimationFunctionNames];
    NSString* functionName = keyframeFunctions[btn.tag];
    
    SEL sel = NSSelectorFromString(functionName);
    if ([self respondsToSelector:sel])
        [self performSelector:sel];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)positionSpringAnimationFunction
{
    CASpringAnimation* positionSpringAnimation = [CASpringAnimation animationWithKeyPath:@"position.x"];
    
    positionSpringAnimation.fromValue = @(self.showView.center.x - 50);
    positionSpringAnimation.toValue = @(self.showView.center.x + 50);
    positionSpringAnimation.duration = positionSpringAnimation.settlingDuration;
    positionSpringAnimation.damping = 1;
    positionSpringAnimation.initialVelocity = 0;
    positionSpringAnimation.stiffness = 200;
    positionSpringAnimation.mass = 10;
    positionSpringAnimation.removedOnCompletion = NO;
    [self.showView.layer addAnimation:positionSpringAnimation forKey:nil];
}

- (NSArray*)springAnimationNames
{
    return @[@"pisition"];
}

- (NSArray*)springAnimationFunctionNames
{
    return @[@"positionSpringAnimationFunction"];
}



@end
