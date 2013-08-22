//
//  Car.h
//  PodDemo
//
//  Created by wufulin on 13-8-21.
//  Copyright (c) 2013年 netease. All rights reserved.
//

#import <Foundation/Foundation.h>

// Define a new type for the block
typedef double (^SpeedFunction)(double);

@interface Car : NSObject

@property double odometer;

- (void)driveForDuration:(double)duration
	   withVariableSpeed:(SpeedFunction)speedFunction
				   steps:(int)numStep;

@end
