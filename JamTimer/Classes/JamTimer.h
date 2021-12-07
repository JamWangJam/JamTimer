//
//  JamTimer.h
//  detection_demo
//
//  Created by Jam on 2021/12/7.
//  Copyright © 2021 Li,Xiaoyang(SYS). All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JamTimer : NSObject

/** 初始化一个定时器 ，必须调用- (void)resume 方法 让定时器启动
 *@param start 定时器启动时间 如果想要立即启动 传值0 即可。
 *@param ti 间隔多久开始执行selector
 *@param  s     执行的任务
 *@param  ui     绑定信息
 *@param   rep   是否重复执行
 */
- (instancetype)initWithTimeInterval:(NSTimeInterval)start interval:(NSTimeInterval)ti target:(id)t selector:(SEL)s userInfo:(nullable id)ui repeats:(BOOL)rep;
/** 构造器初始化定时器  不过自动开始执行 不需要主动调用- (void)resume 方法
 */
+ (JamTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo;

/// 扩充block 自动开始执行 不需要主动调用- (void)resume 方法
+ (JamTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(JamTimer *timer))block;

/// 启动
- (void)resume;

/// 暂停
- (void)suspend;
/// 关闭
- (void)invalidate;
@property (readonly) BOOL repeats;
@property (readonly) NSTimeInterval timeInterval;
@property (readonly, getter=isValid) BOOL valid;
@property (nullable, readonly, retain) id userInfo;


@end

NS_ASSUME_NONNULL_END
