//
//  UIView+jakeAnimationTools.m
//  jakeView
//
//  Created by RHINO on 3/6/13.
//  Copyright (c) 2013 RHINO. All rights reserved.
//

#import "UIView+jakeAnimationTools.h"

@implementation UIView (jakeAnimationTools)

-(void)shakeIt
{
    CGPoint center = self.center;
    CGPoint leftOfCenter = CGPointMake(self.center.x - 30, self.center.y);
    CGPoint rightOfCenter = CGPointMake(self.center.x + 30, self.center.y);
    
    [UIView animateWithDuration:0.1 animations:^{ self.center = leftOfCenter;} completion:^(BOOL finished){
        [UIView animateWithDuration:0.1 animations:^{ self.center = rightOfCenter;} completion:^(BOOL finished){
            self.center = center;
        }];
    }];
    
}

@end
