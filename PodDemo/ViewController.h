//
//  ViewController.h
//  PodDemo
//
//  Created by wufulin on 13-8-8.
//  Copyright (c) 2013年 netease. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 
 This view controller is the main controller of this application
 
 Let's do a simple bullet list:
 
 * this is the first line
 * this is the second line
 
 #Section two#
 
 Finally, a small table
 
 |header1 | hearder2 | header3|
 |---------|:--------:|--------:|
 | normal  |  center  | right   |
 | cell    |  cell    | cell    |
 */
@interface ViewController : UIViewController

/** Documenting a property */
@property (nonatomic, strong) NSString *name;

/** Documenting an instance method 
 @param name The name of the class
 @return Returns a named instance of ViewController
 */
- (id)initializeWithName:(NSString *)name;

/** Documenting a class method */
+(ViewController *)create;
@end
