//
//  WaterWaveView.m
//  TimAnimationDemo
//
//  Created by 李佳 on 15/9/17.
//  Copyright © 2015年 LiJia. All rights reserved.
//

#import "WaterWaveView.h"

@interface WaterWaveView()
@property(nonatomic, assign)CGFloat waterLineYPos;
@property(nonatomic, assign)CGFloat waterWaveControl1;
@property(nonatomic, assign)CGFloat waterWaveControl2;
@property(nonatomic, assign)BOOL isAdd;
@property(nonatomic, assign)BOOL isBeginAnimation;
@property(nonatomic, strong)NSTimer* beginWaveTimer;
@property(nonatomic, assign)BOOL isStoping;
@end

@implementation WaterWaveView

- (instancetype)initWithFrame: (CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        self.waterColor = [UIColor blueColor];
        
        self.isBeginAnimation = NO;
        self.percent = 0.5;
        self.layer.cornerRadius = frame.size.width/2;
        self.layer.masksToBounds = YES;
        self.isStoping = NO;
        
        UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(20, self.frame.size.height - 20, 20, 20)];
        btn.backgroundColor = [UIColor greenColor];
        [btn addTarget:self action:@selector(waveAnimationControl:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    return self;
}

- (void)setPercent:(CGFloat)percent
{
    _percent = percent;
    self.waterLineYPos = self.frame.size.height * (1 - self.percent);
}

- (void)waveAnimationControl: (id)sender
{
    self.isBeginAnimation ? [self stopWaveAnimation:sender] : [self beginWaveAnimation:sender];
}

- (void)beginWaveAnimation: (id)sender
{
    self.waterWaveControl1 = 1.5;
    self.waterWaveControl2 = 0;
    self.isAdd = NO;
    self.isBeginAnimation = YES;
    self.beginWaveTimer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(beginAnimateWave) userInfo:nil repeats:YES];
}

- (void)stopWaveAnimation: (id)sender
{
    self.isBeginAnimation = NO;
    self.isStoping = YES;
}

-(void)beginAnimateWave
{
    if (self.isAdd && !self.isStoping)
        self.waterWaveControl1 += 0.01;
    else
        self.waterWaveControl1 -= 0.01;
    
    if (!self.isStoping)
    {
        if (self.waterWaveControl1 <= 1)
            self.isAdd = YES;
        
        if (self.waterWaveControl1 >= 3)
            self.isAdd = NO;
        
        self.waterWaveControl2 += 0.1;
    }
    else
    {
        if (fabs(self.waterWaveControl1 - 0.0) < 0.00001)
        {
            [self.beginWaveTimer invalidate];
            self.beginWaveTimer = nil;
            self.isStoping = NO;
        }
        self.waterWaveControl2 -= 0.1;
    }
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    
    //画水
    CGContextSetLineWidth(context, 1);
    CGContextSetFillColorWithColor(context, [self.waterColor CGColor]);
    
    float y = self.waterLineYPos;
    CGPathMoveToPoint(path, NULL, 0, y);
    for(float x = 0;x <= self.frame.size.width; x++){
        y = self.waterWaveControl1 * sin(x / 180 * M_PI + 4 * self.waterWaveControl2 / M_PI ) * 5 + self.waterLineYPos;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    
    CGPathAddLineToPoint(path, nil, self.frame.size.width, rect.size.height);
    CGPathAddLineToPoint(path, nil, 0, rect.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.waterLineYPos);
    
    CGContextAddPath(context, path);
    CGContextFillPath(context);
    CGContextDrawPath(context, kCGPathStroke);
    CGPathRelease(path);
}

@end
