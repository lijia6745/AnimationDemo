//
//  SpreadPathAnimationView.m
//  TimAnimationDemo
//
//  Created by 李佳 on 15/9/16.
//  Copyright © 2015年 LiJia. All rights reserved.
//

#import "SpreadPathAnimationView.h"


@interface SpreadPathAnimationView()
@property(nonatomic, strong)UIButton* spreadBtn;
@property(nonatomic, strong)NSMutableArray* itemBtns;
@property(nonatomic, assign)BOOL isSpreadState;
@end

@implementation SpreadPathAnimationView

- (instancetype)init
{
    if (self = [super init])
    {
        self.itemBtns = [[NSMutableArray alloc] init];
        //[self initView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.itemBtns = [[NSMutableArray alloc] init];
        [self initView];
    }
    return self;
}

- (void)initView
{
    self.spreadBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.center.x, self.center.y, btnWidth, btnWidth)];
    self.spreadBtn.layer.anchorPoint = CGPointMake(0.5, 0.5);
    self.spreadBtn.backgroundColor = [UIColor redColor];
    [self addSubview:self.spreadBtn];
    [self.spreadBtn addTarget:self action:@selector(clickAnimationBtn) forControlEvents:UIControlEventTouchUpInside];
    [self setBackgroundColor:[UIColor whiteColor]];
    [self initSpreadBtns:5];
    self.isSpreadState = NO;
}

- (void)initSpreadBtns: (int)count
{
    for (int i = 0; i < count; ++i)
    {
        UIButton* btn = [[UIButton alloc] init];
        btn.frame = CGRectMake(self.center.x, self.center.y, btnWidth, btnWidth);
        int r = arc4random() % 255;
        int g = arc4random() % 255;
        int b = arc4random() % 225;
        
        UIColor* color = [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.9 alpha:1];
        btn.backgroundColor = color;
        [btn setTitle:[NSString stringWithFormat:@"%d", i + 1] forState:UIControlStateNormal];
        [self insertSubview:btn belowSubview:self.spreadBtn];
        btn.layer.anchorPoint = CGPointMake(0.5, 0.5);
        [self.itemBtns addObject:btn];
    }
}

- (void)clickAnimationBtn
{
    self.isSpreadState ? [self hiddenSpreadBtns] : [self addSpreadAnimation];
}

- (void)addSpreadAnimation
{
    CGFloat spreadAngle = 180.f / (self.itemBtns.count + 1);
    CGFloat spreadRadius = 105.f;
    
    for (int i = 0; i < self.itemBtns.count; ++i)
    {
        UIButton* btn = self.itemBtns[i];
        CGFloat curAngle = (i + 1) * spreadAngle / 180;
        CGPoint curPoint = btn.center;
        CGPoint nearPoint = CGPointMake(curPoint.x - (spreadRadius - 5.0f) * cosf(curAngle * M_PI),
                                        curPoint.y - (spreadRadius - 5.0f) * sinf(curAngle * M_PI));
        
        CGPoint endPoint = CGPointMake(curPoint.x - (spreadRadius) * cosf(curAngle * M_PI),
                                       curPoint.y - (spreadRadius) * sinf(curAngle * M_PI));
        
        CGPoint farPoint = CGPointMake(curPoint.x - (spreadRadius + 10.0f) * cosf(curAngle * M_PI),
                                       curPoint.y - (spreadRadius + 10.0f) * sinf(curAngle * M_PI));
        
        
        CAKeyframeAnimation* posiAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, curPoint.x, curPoint.y);
        CGPathAddLineToPoint(path, NULL, nearPoint.x, nearPoint.y);
        CGPathAddLineToPoint(path, NULL, farPoint.x, farPoint.y);
        CGPathAddLineToPoint(path, NULL, endPoint.x, endPoint.y);
        posiAnimation.path = path;
        
        CGPathRelease(path);
        posiAnimation.keyTimes = @[@(0.0), @(0.5), @(0.7), @(1.0)];
        posiAnimation.duration = 0.5f;
        //posiAnimation.autoreverses = YES;
        
        CAKeyframeAnimation* rotationAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation.duration = 0.5f;
        rotationAnimation.keyTimes = @[@(0.0), @(0.5), @(0.7), @(1.0)];
        rotationAnimation.values = @[@(0.0), @(- M_PI), @(- M_PI * 1.5), @(- M_PI * 2)];
        
        CAAnimationGroup* animationGroup = [CAAnimationGroup animation];
        animationGroup.animations = @[rotationAnimation, posiAnimation];
        animationGroup.duration = 0.5f;
        btn.center = endPoint;
        [btn.layer addAnimation:animationGroup forKey:@"ddd"];
    }
    self.isSpreadState = YES;
}

- (void)hiddenSpreadBtns
{
    for (int i = 0; i < self.itemBtns.count; ++i)
    {
        UIButton* btn = self.itemBtns[i];
        CGPoint curPoint = btn.center;
        CGPoint endPoint = self.spreadBtn.center;
        
        CABasicAnimation* posAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
        posAnimation.fromValue = [NSValue valueWithCGPoint:curPoint];
        posAnimation.toValue = [NSValue valueWithCGPoint:endPoint];
        posAnimation.duration = 0.3f;
        
        CAKeyframeAnimation* rotationAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation.values = @[@(0.0), @(- M_PI), @(- M_PI * 1.5), @(- M_PI * 2)];
        rotationAnimation.keyTimes = @[@(0.0), @(0.5), @(0.7), @(1.0)];
        rotationAnimation.duration = 0.3f;
        
        btn.center = endPoint;
        
        CAAnimationGroup* groupAnimation = [CAAnimationGroup animation];
        groupAnimation.animations = @[posAnimation, rotationAnimation];
        groupAnimation.duration = 0.3;
        [btn.layer addAnimation:groupAnimation forKey:@"ff"];
    }
    
    self.isSpreadState = NO;
}



@end
