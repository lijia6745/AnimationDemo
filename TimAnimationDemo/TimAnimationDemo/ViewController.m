//
//  ViewController.m
//  TimAnimationDemo
//
//  Created by 李佳 on 15/9/14.
//  Copyright © 2015年 LiJia. All rights reserved.
//


#import "ViewController.h"
#import "BasicAnimationViewController.h"
#import "KeyframeAnimationViewController.h"
#import "springAnimationViewController.h"
#import "GroupAnimationViewController.h"
#import "TransitionAnimationViewController.h"
#import "ComplexAnimationViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIButton* basicAnimationBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 80, 20)];
    [basicAnimationBtn setBackgroundColor:[UIColor redColor]];
    [basicAnimationBtn setTitle:@"基础动画" forState:UIControlStateNormal];
    
    [basicAnimationBtn addTarget:self action:@selector(pushBasicAnimationViewController:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:basicAnimationBtn];
    
    UIButton* keyFrameAnimationBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 140, 80, 20)];
    [keyFrameAnimationBtn setBackgroundColor:[UIColor redColor]];
    [keyFrameAnimationBtn setTitle:@"关键帧" forState:UIControlStateNormal];
    
    [keyFrameAnimationBtn addTarget:self action:@selector(pushkeyFrameAnimationAnimationViewController:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:keyFrameAnimationBtn];
    
    UIButton* springAnimationBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 180, 80, 20)];
    [springAnimationBtn setBackgroundColor:[UIColor redColor]];
    [springAnimationBtn setTitle:@"弹簧动画" forState:UIControlStateNormal];
    
    [springAnimationBtn addTarget:self action:@selector(pushSpringAnimationAnimationViewController:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:springAnimationBtn];

    UIButton* groupAnimationBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 220, 80, 20)];
    [groupAnimationBtn setBackgroundColor:[UIColor redColor]];
    [groupAnimationBtn setTitle:@"组合动画" forState:UIControlStateNormal];
    
    [groupAnimationBtn addTarget:self action:@selector(pushGroupAnimationViewController:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:groupAnimationBtn];
    
    UIButton* transitionAnimationBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 260, 80, 20)];
    [transitionAnimationBtn setBackgroundColor:[UIColor redColor]];
    [transitionAnimationBtn setTitle:@"过渡动画" forState:UIControlStateNormal];
    [transitionAnimationBtn addTarget:self action:@selector(pushTransitionAnimationViewController:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:transitionAnimationBtn];
    
    UIButton* complexAnimationBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 80, 20)];
    [complexAnimationBtn setBackgroundColor:[UIColor redColor]];
    [complexAnimationBtn setTitle:@"复杂动画" forState:UIControlStateNormal];
    [complexAnimationBtn addTarget:self action:@selector(pushComplexAnimationViewController:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:complexAnimationBtn];
}

- (void)pushBasicAnimationViewController:(id)sender
{
    BasicAnimationViewController* baseAnimationViewCrl = [[BasicAnimationViewController alloc] init];
    [self.navigationController pushViewController:baseAnimationViewCrl animated:YES];
}

- (void)pushkeyFrameAnimationAnimationViewController:(id)sender
{
    KeyframeAnimationViewController* keyFrameAnimationViewCrl = [[KeyframeAnimationViewController alloc] init];
    [self.navigationController pushViewController:keyFrameAnimationViewCrl animated:NO];
}

- (void)pushSpringAnimationAnimationViewController:(id)sender
{
    springAnimationViewController* springAnimationViewCrl = [[springAnimationViewController alloc] init];
    [self.navigationController pushViewController:springAnimationViewCrl animated:NO];
}

- (void)pushGroupAnimationViewController: (id)sender
{
    GroupAnimationViewController* groupAnimationViewCrl = [[GroupAnimationViewController alloc] init];
    [self.navigationController pushViewController:groupAnimationViewCrl animated:NO];
}

- (void)pushTransitionAnimationViewController: (id)sender
{
    TransitionAnimationViewController* transitionAnimationViewCrl = [[TransitionAnimationViewController alloc] init];
    [self.navigationController pushViewController:transitionAnimationViewCrl animated:NO];
}

- (void)pushComplexAnimationViewController: (id)sender
{
    ComplexAnimationViewController* complexAnimationViewCrl = [[ComplexAnimationViewController alloc] init];
    [self.navigationController pushViewController:complexAnimationViewCrl animated:NO];
}


@end
