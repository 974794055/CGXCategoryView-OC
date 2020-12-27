//
//  CGXCategoryView-OCAnimator.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategoryViewAnimator.h"

@interface CGXCategoryViewAnimator ()
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) CFTimeInterval firstTimestamp;
@end

@implementation CGXCategoryViewAnimator

- (void)dealloc
{
    self.progressCallback = nil;
    self.completeCallback = nil;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _duration = 0.25;
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(processDisplayLink:)];
    }
    return self;
}

- (void)start {
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)stop {
    [self.displayLink invalidate];
    !self.completeCallback ?: self.completeCallback();
}

- (void)processDisplayLink:(CADisplayLink *)sender {
    if (self.firstTimestamp == 0) {
        self.firstTimestamp = sender.timestamp;
    }
    CGFloat percent = (sender.timestamp - self.firstTimestamp)/self.duration;
    if (percent >= 1) {
        !self.progressCallback ?: self.progressCallback(percent);
        [self.displayLink invalidate];
        !self.completeCallback ?: self.completeCallback();
    }else {
        !self.progressCallback ?: self.progressCallback(percent);
    }
}

@end
