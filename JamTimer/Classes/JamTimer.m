//
//  JamTimer.m
//  detection_demo
//
//  Created by Jam on 2021/12/7.
//  Copyright © 2021 Li,Xiaoyang(SYS). All rights reserved.
//

#import "JamTimer.h"

#define Jam_lock(...) \
    dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);\
    __VA_ARGS__;\
    dispatch_semaphore_signal(_semaphore);



@interface JamTimer ()
{
    BOOL _valid;
    NSTimeInterval _timeInterval;
    BOOL _repeats;
    id _userInfo;  
    //
    __weak id _target;
    SEL _selector;
    dispatch_source_t _timer;
    dispatch_semaphore_t _semaphore;
    BOOL _running;
}

@end

@implementation JamTimer
+ (JamTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo {
    JamTimer *timer = [[JamTimer alloc] initWithTimeInterval:0 interval:ti target:aTarget selector:aSelector userInfo:userInfo repeats:yesOrNo];
    [timer resume];
    return timer;
}
+ (JamTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(JamTimer *timer))block {
    NSParameterAssert(block != nil);
    JamTimer *timer = [[JamTimer alloc] initWithTimeInterval:0 interval:interval target:self selector:@selector(ss_executeBlockFromTimer:) userInfo:[block copy] repeats:repeats];
    [timer resume];
    return timer;
}
- (instancetype)initWithTimeInterval:(NSTimeInterval)start interval:(NSTimeInterval)ti target:(id)t selector:(SEL)s userInfo:(nullable id)ui repeats:(BOOL)rep {
    self = [super init];
    if (self) {
        _valid = YES;
        _timeInterval = ti;
        _repeats = rep;
        _target = t;
        _selector = s;
        _userInfo = ui;
        _semaphore = dispatch_semaphore_create(1); // 做线程同步， 锁的作用
        __weak typeof(self) weakSelf = self;
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
        dispatch_source_set_timer(_timer, dispatch_time(DISPATCH_TIME_NOW, start * NSEC_PER_SEC), ti * NSEC_PER_SEC, 0);
        dispatch_source_set_event_handler(_timer, ^{[weakSelf fire];});
    }
    return self;
}
- (void)fire {
    if (!_valid) {return;}
    Jam_lock(id target = _target;)
    if (!target) {
        [self invalidate];
    } else {
        // 执行selector
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [target performSelector:_selector withObject:self];
#pragma clang diagnostic pop
        if (!_repeats) {
            [self invalidate];
        }
    }
}
- (void)resume {
    if (_running) return;
    dispatch_resume(_timer);
    _running = YES;
}
- (void)suspend {
    if (!_running) return;
    dispatch_suspend(_timer);
    _running = NO;
}
- (void)invalidate {
    dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
    if (_valid) {
        dispatch_source_cancel(_timer);
        _timer = NULL;
        _target = nil;
        _userInfo = nil;
        _valid = NO;
    }
    dispatch_semaphore_signal(_semaphore);
}
- (id)userInfo {
    Jam_lock(id ui = _userInfo) return ui;
}
- (BOOL)repeats {
    Jam_lock(BOOL re = _repeats) return re;
}
- (NSTimeInterval)timeInterval {
    Jam_lock(NSTimeInterval ti = _timeInterval) return ti;
}
- (BOOL)isValid {
    Jam_lock(BOOL va = _valid) return va;
}
- (void)dealloc {
    [self invalidate];
}
+ (void)ss_executeBlockFromTimer:(JamTimer *)aTimer {
    void (^block)(JamTimer *) = [aTimer userInfo];
    if (block) block(aTimer);
}

@end
