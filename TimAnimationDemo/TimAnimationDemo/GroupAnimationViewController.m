//
//  GroupAnimationViewController.m
//  TimAnimationDemo
//
//  Created by 李佳 on 15/9/16.
//  Copyright © 2015年 LiJia. All rights reserved.
//

#import "GroupAnimationViewController.h"

@interface GroupAnimationViewController ()
@property(nonatomic, strong)UIView* showView;
@end

@implementation GroupAnimationViewController

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
    NSArray* basicAnimationArr = [self groupAnimationNames];
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
    NSArray* keyframeFunctions = [self groupAnimationFunctionNames];
    NSString* functionName = keyframeFunctions[btn.tag];
    
    SEL sel = NSSelectorFromString(functionName);
    if ([self respondsToSelector:sel])
        [self performSelector:sel];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)positionAndColorGroupAnimation
{
    CAAnimationGroup* groupAnimation = [[CAAnimationGroup alloc] init];
    CABasicAnimation* positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    positionAnimation.duration = 2.0f;
    positionAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(300, 400)];
    positionAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
    
    CABasicAnimation* backGroundAnimation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    backGroundAnimation.duration = 3.0f;
    backGroundAnimation.toValue = (__bridge id _Nullable)([UIColor greenColor].CGColor);
    backGroundAnimation.fromValue = (__bridge id _Nullable)([self.showView backgroundColor].CGColor);
    
    groupAnimation.animations = @[backGroundAnimation, positionAnimation];
    groupAnimation.duration = 3.0f;
    [self.showView.layer addAnimation:groupAnimation forKey:nil];
}


- (NSArray*)groupAnimationNames
{
    return @[@"positionAndColor"];
}

- (NSArray*)groupAnimationFunctionNames
{
    return @[@"positionAndColorGroupAnimation"];
}

@end
