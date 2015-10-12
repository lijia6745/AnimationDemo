//
//  ComplexAnimationViewController.m
//  TimAnimationDemo
//
//  Created by 李佳 on 15/9/16.
//  Copyright © 2015年 LiJia. All rights reserved.
//

#import "ComplexAnimationViewController.h"
#import "SpreadPathAnimationView.h"
#import "SnowPathAnimationView.h"
#import "WaterWaveView.h"
#import "BlockFallAnimationView.h"

@interface ComplexAnimationViewController ()
@property(nonatomic, strong)SpreadPathAnimationView* spreadView;
@property(nonatomic, strong)SnowPathAnimationView* snowView;
@property(nonatomic, strong)WaterWaveView* waterVaveView;
@property(nonatomic, strong)BlockFallAnimationView* blockFallView;
@end

@implementation ComplexAnimationViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

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
    [self addSpringAnimationBtns];
}

- (void)addSpringAnimationBtns
{
    NSArray* basicAnimationArr = [self complexAnimationNames];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat btnWidth = (screenRect.size.width - 2 * btnMargins) / 5.5;
    
    for (int i = 0; i < basicAnimationArr.count; ++i)
    {
        UIButton* btn = [[UIButton alloc] init];
        btn.frame = CGRectMake(btnMargins + i % 4 * btnWidth * 1.5, screenRect.size.height / 2 + viewSize + (i / 4) * 2 * btnHeight , btnWidth, btnHeight);
        btn.backgroundColor = [UIColor grayColor];
        btn.tag = i;
        [btn setTitle:basicAnimationArr[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(addViewToViewController:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}

- (void)addViewToViewController: (id)sender
{
    UIButton* btn = sender;
    NSArray* keyframeFunctions = [self complexAnimationFunctionNames];
    NSString* functionName = keyframeFunctions[btn.tag];
    
    SEL sel = NSSelectorFromString(functionName);
    if ([self respondsToSelector:sel])
        [self performSelector:sel];
}

- (void)addSpreadPathAnimationView
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    SpreadPathAnimationView* view = [[SpreadPathAnimationView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, screenRect.size.height / 2 + viewSize)];
    
    view.backgroundColor = [UIColor whiteColor];
    self.spreadView = view;
    [self.view addSubview:self.spreadView];
}

- (void)AddSnowPathAnimationView
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    SnowPathAnimationView* view = [[SnowPathAnimationView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, screenRect.size.height / 2 + viewSize)];
    
    self.snowView = view;
    [self.view addSubview:self.snowView];
}

- (void)addWaterWaveAnimationView
{
    WaterWaveView* view = [[WaterWaveView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x + viewSize, self.view.frame.origin.y, self.view.frame.size.width - viewSize * 2, self.view.frame.size.width - viewSize * 2)];
    
    self.waterVaveView = view;
    [self.view addSubview:self.waterVaveView];
}

- (void)addBlockFallAnimationView
{
    BlockFallAnimationView* view = [[BlockFallAnimationView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width - viewSize * 2)];
    
    self.blockFallView = view;
    [self.view addSubview:self.blockFallView];
}


- (NSArray*)complexAnimationNames
{
    return @[@"spreadPathAnimation", @"snowPathAnimation", @"waterWave", @"blockFall"];
}

- (NSArray*)complexAnimationFunctionNames
{
    return @[@"addSpreadPathAnimationView", @"AddSnowPathAnimationView", @"addWaterWaveAnimationView",
             @"addBlockFallAnimationView"];
}

@end
