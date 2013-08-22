//
//  main.m
//  PodDemo
//
//  Created by wufulin on 13-8-8.
//  Copyright (c) 2013年 netease. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VIPAppDelegate.h"
#import "Car.h"

int main(int argc, char *argv[])
{
    @autoreleasepool {
		
		// Declare the block variable
		double (^distanceFromRateAndTime)(double reate, double time);
		
		// Create and assign the block
		distanceFromRateAndTime = ^(double rate, double time){
			return rate * time;
		};
		
		// Call the block
		double dx = distanceFromRateAndTime(35,1.5);
		
		NSLog(@"A car driving 35 mph will travel %.2f miles in 1.5 hours.",dx);
		
		NSString *make = @"Honda";
		NSString *(^getFullCarName)(NSString *) = ^(NSString *model){
			return [make stringByAppendingFormat:@" %@",model];
		};
		
		NSLog(@"%@",getFullCarName(@"Accord"));;
		
		make = @"Porsche";
		NSLog(@"Non-Local Variable: %@",make);
		// Try changing the non-local variable (it won't change the block)
		NSLog(@"%@",getFullCarName(@"911 Turbo"));
		
		// Direct link
		__block int i = 0;
		int (^count)(void) = ^int(){
			i += 1;
			return i;
		};
		NSLog(@"%d",count());	// 1
		NSLog(@"%d",count());	// 2
		NSLog(@"%d",count());	// 3
		
		Car *theCar = [[Car alloc] init];
		[theCar driveForDuration:10.0
			   withVariableSpeed:^double(double time) {
				   return 5.0;
			   } steps:100];
		NSLog(@"The car has now driven %.2f meters",theCar.odometer);
		
		[theCar driveForDuration:10.0
			   withVariableSpeed:^double(double time) {
				   return time + 5.0;
			   } steps:100];
		NSLog(@"The car has now driven %.2f meters",theCar.odometer);
		
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([VIPAppDelegate class]));
    }
}
