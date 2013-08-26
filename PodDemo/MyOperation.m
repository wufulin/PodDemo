//
//  MyOperation.m
//  PodDemo
//
//  Created by wufulin on 13-8-26.
//  Copyright (c) 2013年 netease. All rights reserved.
//

#import "MyOperation.h"

typedef NS_ENUM(NSInteger, MyOperationState) {
	MyOperationReadyState = 1,
	MyOperationExecutingState,
	MyOperationFinishedState
};

@interface MyOperation () {
	MyOperationAction _action;
	MyOperationState _state;
}
@property (nonatomic, copy) MyOperationAction action;
@property (nonatomic, assign) MyOperationState state;
@end

@implementation MyOperation

- (id)initWithAction:(MyOperationAction)action {
	self = [super init];
	if (self) {
		self.action = action;
	}
	return self;
}

+ (void)keepThreadAlive {
	do {
		@autoreleasepool {
			[[NSRunLoop currentRunLoop] run];
		}
	} while (YES);
}

+ (NSThread *)threadForMyOperation {
	static NSThread *_threadInstance = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		_threadInstance = [[NSThread alloc] initWithTarget:self
												  selector:@selector(keepThreadAlive) object:nil];
		_threadInstance.name = @"MyOperation.Thread";
		[_threadInstance start];
	});
	return _threadInstance;
}

#pragma mark - Override
- (BOOL)isConcurrent {
	return  YES;
}

- (BOOL)isExecuting {
	return self.state = MyOperationExecutingState;
}

- (BOOL)isFinished {
	return self.state = MyOperationFinishedState;
}

- (void)start {
	if ([self isReady]) {
		self.state = MyOperationExecutingState;
		[self performSelector:@selector(operationDidStart)
					 onThread:[[self class] threadForMyOperation]
				   withObject:nil
				waitUntilDone:NO];
	}
}

- (void)operationDidStart {
	if (self.isCancelled) {
		self.state = MyOperationFinishedState;
	}else {
		NSLog(@"Operation is running %@ thread",[NSThread currentThread]);
		self.action();
		self.state = MyOperationFinishedState;
	}
}
@end
