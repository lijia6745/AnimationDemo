//
//  BlockFallAnimationView.m
//  TimAnimationDemo
//
//  Created by 李佳 on 15/9/18.
//  Copyright © 2015年 LiJia. All rights reserved.
//

#import "BlockFallAnimationView.h"

@interface BlockFallAnimationView()
@property(nonatomic, strong)UIView* blockView;
@end

@implementation BlockFallAnimationView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame: frame])
    {
        self.blockView = [[UIView alloc] init];
        self.blockView.frame = CGRectMake(self.center.x - btnWidth / 2, self.center.y + btnWidth , btnWidth, btnWidth);
        self.blockView.backgroundColor = [UIColor redColor];
        NSLog(@"XXXanchorPoint%@", NSStringFromCGPoint(self.blockView.layer.anchorPoint));
        NSLog(@"XXXview frame%@", NSStringFromCGRect(self.blockView.frame));
        NSLog(@"XXXlayer frame%@", NSStringFromCGRect(self.blockView.layer.frame));
        NSLog(@"XXXlayer center%@", NSStringFromCGPoint(self.blockView.center));
        
        self.blockView.layer.anchorPoint = CGPointMake(0, 1);
        
        NSLog(@"YYYanchorPoint%@", NSStringFromCGPoint(self.blockView.layer.anchorPoint));
        NSLog(@"YYYview frame%@", NSStringFromCGRect(self.blockView.frame));
        NSLog(@"YYYlayer frame%@", NSStringFromCGRect(self.blockView.layer.frame));
        NSLog(@"YYYlayer center%@", NSStringFromCGPoint(self.blockView.center));
        
        [self addSubview:self.blockView];
        
        UIButton* btn = [[UIButton alloc] init];
        btn.frame = CGRectMake(50, self.bounds.size.height - btnWidth, btnWidth, btnWidth);
        btn.backgroundColor = [UIColor grayColor];
        [self addSubview:btn];
        [btn addTarget:self action:@selector(doBlockFallAnimation) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)doBlockFallAnimation
{
    CABasicAnimation* boundsAniamtion = [CABasicAnimation animationWithKeyPath:@"bounds"];
    boundsAniamtion.fromValue = [NSValue valueWithCGRect:self.blockView.bounds];
    boundsAniamtion.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, self.blockView.bounds.size.width, self.blockView.bounds.size.height * 2)];
    boundsAniamtion.duration = 1.0f;
    [boundsAniamtion setBeginTime:0.0f];
    self.blockView.bounds = CGRectMake(0, 0, self.blockView.bounds.size.width, self.blockView.bounds.size.height * 2);
    
    CABasicAnimation* boundsAnimation2 = [CABasicAnimation animationWithKeyPath:@"bounds"];
    boundsAnimation2.fromValue = [NSValue valueWithCGRect:self.blockView.bounds];
    boundsAnimation2.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, self.blockView.bounds.size.width * 2, self.blockView.bounds.size.height)];
    boundsAnimation2.duration = 1.0f;
    [boundsAnimation2 setBeginTime:1.0f];
    self.blockView.bounds = CGRectMake(0, 0, self.blockView.bounds.size.width * 2, self.blockView.bounds.size.height);
    
    CABasicAnimation* backgroundColor = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    backgroundColor.fromValue = (__bridge id _Nullable)(self.blockView.backgroundColor.CGColor);
    backgroundColor.toValue = (__bridge id _Nullable)([UIColor greenColor].CGColor);
    backgroundColor.duration = 1.0f;
    //[backgroundColor setBeginTime:0.0f];
    
    CABasicAnimation* rotationZ = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationZ.fromValue = @0;
    rotationZ.toValue = @M_PI_2;
    rotationZ.duration = 1.0f;
    //[rotationZ setBeginTime:1.0f];
    
    CABasicAnimation* positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    positionAnimation.fromValue = [NSValue valueWithCGPoint:self.blockView.center];
    positionAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.blockView.frame.origin.x, self.blockView.frame.origin.y + 200)];
    positionAnimation.duration = 1.0f;
    //[positionAnimation setBeginTime:2.0f];
    
    CAAnimationGroup* groupMin = [CAAnimationGroup animation];
    groupMin.animations = @[backgroundColor, rotationZ, positionAnimation];
    groupMin.duration = 3.0f;
    [groupMin setBeginTime:2.0f];
    
    CAAnimationGroup* group = [CAAnimationGroup animation];
    group.animations = @[boundsAniamtion, boundsAnimation2,groupMin];
    group.duration = 5.0f;
    [self.blockView.layer addAnimation:group forKey:nil];
}

- (void)animationWithArray: (NSArray*)animations
{
    if (animations.count > 0)
    {
        CAAnimation* animation = animations[0];
        [UIView animateWithDuration:1.0f animations:^(){
            [self.blockView.layer addAnimation:animation forKey:nil];
        } completion:^(BOOL finished) {
            if (animations.count > 1 && finished)
            {
                NSArray* lastAnimations = [animations subarrayWithRange:NSMakeRange(1, animations.count - 1)];
                [self animationWithArray:lastAnimations];
            }
        }];
    }
}
@end
