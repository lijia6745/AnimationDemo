//
//  TransitionAnimationViewController.m
//  TimAnimationDemo
//
//  Created by 李佳 on 15/9/16.
//  Copyright © 2015年 LiJia. All rights reserved.
//

#import "TransitionAnimationViewController.h"

@interface TransitionAnimationViewController ()
@property(nonatomic, strong)UIView* showView;
@end

@implementation TransitionAnimationViewController

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
    self.showView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, viewSize, viewSize)];
    self.showView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.showView];
    self.showView.backgroundColor = [UIColor redColor];
    [self addSpringAnimationBtns];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)addSpringAnimationBtns
{
    NSArray* basicAnimationArr = [self transitionAnimationNames];
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
    NSArray* keyframeFunctions = [self transitionAnimationFunctionNames];
    NSString* functionName = keyframeFunctions[btn.tag];
    [self.showView.layer removeAllAnimations];
    
    SEL sel = NSSelectorFromString(functionName);
    if ([self respondsToSelector:sel])
        [self performSelector:sel];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

/*四种公用API*/
- (void)fadeTransitionAnimation
{
    [self.showView.layer setBackgroundColor:[UIColor greenColor].CGColor];
    self.showView.center = CGPointMake(300, 400);
    
    CATransition* fade = [CATransition animation];
    fade.type = kCATransitionFade;
    fade.subtype = kCATransitionFromLeft;
    fade.duration = 2.0f;
//    fade.startProgress = 0.2f; //开始时间
//    fade.endProgress = 0.8f;
    [self.showView.layer addAnimation:fade forKey:@"fade"];
}

- (void)moveInTransitionAnimation
{
    [self.showView.layer setBackgroundColor:[UIColor blueColor].CGColor];
    CATransition* moveIn = [CATransition animation];
    moveIn.type = kCATransitionMoveIn;
    moveIn.subtype = kCATransitionFromBottom;
    moveIn.duration = 3.0f;
    [self.showView.layer addAnimation:moveIn forKey:@"moveIn"];
}

- (void)pushTransitionAnimation
{
    //self.showView.center = CGPointMake(100, 200);
    CATransition* push = [CATransition animation];
    push.type = kCATransitionPush;
    push.subtype = kCATransitionFromTop;
    push.duration = 2.0f;
    
    [self.showView.layer addAnimation:push forKey:@"push"];
}

- (void)revealTransitionAnimation
{
    CATransition* reveal = [CATransition animation];
    reveal.type = kCATransitionReveal;
    reveal.subtype = kCATransitionFromRight;
    reveal.duration = 2.0f;
    [self.showView.layer addAnimation:reveal forKey:@"reveal"];
}

/*私用API*/

- (void)cubeTransitionAnimation
{
    int r = arc4random() % 255;
    int g = arc4random() % 255;
    int b = arc4random() % 255;
    UIColor* color = [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:1];
    self.showView.backgroundColor = color;
    CATransition* cube = [CATransition animation];
    cube.type = @"cube";
    cube.subtype = kCATransitionFromLeft;
    cube.duration = 2.0f;
    
    [self.showView.layer addAnimation:cube forKey:@"cube"];
}

- (void)oglFlipTransitionAnimation
{
    [self addLableToShowView];
    CATransition* oglFlip = [CATransition animation];
    oglFlip.type = @"oglFlip";
    oglFlip.subtype = kCATransitionFromTop;
    oglFlip.duration = 2.0f;
    
    [self.showView.layer addAnimation:oglFlip forKey:@"oglFilp"];
}

- (void)pageCurlTransitonAnimation
{
    [self addLableToShowView];
    CATransition* pageCurl = [CATransition animation];
    pageCurl.type = @"pageCurl";
    pageCurl.subtype = kCATransitionFromLeft;
    
    pageCurl.duration = 2.0f;
    
    [self.showView.layer addAnimation:pageCurl forKey:@"pageCurl"];
}

- (void)pageUnCurlTransitionAnimation
{
    [self addLableToShowView];
    CATransition* pageUnCurl = [CATransition animation];
    pageUnCurl.type = @"pageUnCurl";
    pageUnCurl.subtype = kCATransitionFromBottom;
    pageUnCurl.duration = 2.0f;
    
    [self.showView.layer addAnimation:pageUnCurl forKey:@"pageUnCurl"];
}


//私用 不支持过渡方向
- (void)suckEffectTransitionAnimation
{
    [self addLableToShowView];
    CATransition* suckEffect = [CATransition animation];
    suckEffect.type = @"suckEffect";
    suckEffect.subtype = kCATransitionFromRight;
    suckEffect.duration = 2.0f;
    
    [self.showView.layer addAnimation:suckEffect forKey:@"suckEffect"];
}

- (void)cameraIrisHollowOpenTransitionAnimation
{
    [self addLableToShowView];
    CATransition* cameraIrisHollowOpen = [CATransition animation];
    cameraIrisHollowOpen.type = @"cameraIrisHollowOpen";
    cameraIrisHollowOpen.subtype = kCATransitionFromTop;
    cameraIrisHollowOpen.duration = 2.0f;
    
    [self.showView.layer addAnimation:cameraIrisHollowOpen forKey:@"cameraIrisHollowOpen"];
}

- (void)cameraIrisHollowCloseTransitionAnimation
{
    [self addLableToShowView];
    CATransition* cameraIrisHollowClose = [CATransition animation];
    cameraIrisHollowClose.type = @"cameraIrisHollowOpen";
    cameraIrisHollowClose.subtype = kCATransitionFromTop;
    cameraIrisHollowClose.duration = 2.0f;
    
    [self.showView.layer addAnimation:cameraIrisHollowClose forKey:@"cameraIrisHollowClose"];
}


- (NSArray*)transitionAnimationNames
{
    return @[@"fade", @"MoveIn", @"push", @"reveal", @"cube", @"oglFlip", @"pageCurl", @"pageUnCurl", @"suckEffect", @"cameraIrisHollowOpen", @"cameraIrisHollowClose"];
}

- (NSArray*)transitionAnimationFunctionNames
{
    return @[@"fadeTransitionAnimation", @"moveInTransitionAnimation", @"pushTransitionAnimation",
             @"revealTransitionAnimation", @"cubeTransitionAnimation", @"oglFlipTransitionAnimation",
             @"pageCurlTransitonAnimation", @"pageUnCurlTransitionAnimation", @"suckEffectTransitionAnimation",
             @"cameraIrisHollowOpenTransitionAnimation", @"cameraIrisHollowCloseTransitionAnimation"];
}

- (void)addLableToShowView
{
    UILabel* label = [[UILabel alloc] init];
    label.frame = CGRectMake(viewSize / 2 - viewSize / 4, viewSize / 2 - viewSize / 4, viewSize / 2, viewSize / 2);
    label.backgroundColor = [UIColor grayColor];
    int x = arc4random() % 10;
    
    label.text = [NSString stringWithFormat:@"%d", x];
    label.textAlignment = NSTextAlignmentCenter;
    [self.showView addSubview:label];
}

@end
