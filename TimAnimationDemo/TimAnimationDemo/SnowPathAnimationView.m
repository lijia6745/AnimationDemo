//
//  SnowPathAnimationView.m
//  TimAnimationDemo
//
//  Created by 李佳 on 15/9/16.
//  Copyright © 2015年 LiJia. All rights reserved.
//

#import "SnowPathAnimationView.h"

@interface  SnowPathAnimationView()
@property(nonatomic, strong)CAEmitterLayer *emitter;
@end


@implementation SnowPathAnimationView

- (instancetype)init
{
    if (self = [super init])
    {
        [self initSnowEmitter];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor blackColor];
        [self initSnowEmitter];
        [self initAnimationBtn];
    }
    return self;
}

- (void)initAnimationBtn
{
    UIButton* btn = [[UIButton alloc] init];
    btn.frame = CGRectMake(50, self.bounds.size.height - btnWidth - 20, btnWidth, btnWidth);
    btn.backgroundColor = [UIColor greenColor];
    [btn addTarget:self action:@selector(addAnimationToEmitter:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
}

- (void)addAnimationToEmitter: (id)sender
{
    CAKeyframeAnimation* keyframeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 50, 50);
    CGPathAddLineToPoint(path, NULL, 100, 100);
    CGPathAddLineToPoint(path, NULL, self.center.x, self.center.y);
    CGPathAddArc(NULL, NULL, self.center.x, self.center.y, 100, 0, 2 * M_PI, 1);
    keyframeAnimation.path = path;
    
   // keyframeAnimation.keyTimes = @[@0.0, @0.2, @1];
    keyframeAnimation.duration = 4.0f;
    CGPathRelease(path);
    
    [self.emitter addAnimation:keyframeAnimation forKey:nil];
}

- (void)initSnowEmitter
{
    _emitter = [CAEmitterLayer layer];
    _emitter.frame = CGRectMake(self.center.x, self.center.y, btnWidth, btnWidth);
    [self.layer addSublayer:_emitter];
    
    //configure emitter
    _emitter.renderMode = kCAEmitterLayerAdditive;
    _emitter.emitterPosition = CGPointMake(_emitter.frame.size.width / 4.0, _emitter.frame.size.height / 4.0);
    
    //create a particle template
    CAEmitterCell *cell = [[CAEmitterCell alloc] init];
    cell.contents = (__bridge id)[UIImage imageNamed:@"flake.png"].CGImage;
    cell.birthRate = 20;
    cell.lifetime = 2.0;
    cell.color = [UIColor whiteColor].CGColor;
    cell.alphaSpeed = -0.4;
    cell.velocity = 50;
    cell.velocityRange = 20;
    cell.emissionRange = M_PI;
    
    //add particle template to emitter
    _emitter.emitterCells = @[cell];
}

@end
