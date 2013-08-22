//
//  Car.m
//  PodDemo
//
//  Created by wufulin on 13-8-21.
//  Copyright (c) 2013年 netease. All rights reserved.
//

#import "Car.h"

@implementation Car

@synthesize odometer = _odometer;

- (void)driveForDuration:(double)duration
	   withVariableSpeed:(double (^)(double))speedFunction
				   steps:(int)numStep {
	double dt = duration / numStep;
	for (int i=1; i<=numStep; i++) {
		_odometer += speedFunction(dt*i) * dt;
	}
}

@end
