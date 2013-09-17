//
//  ViewController.m
//  PodDemo
//
//  Created by wufulin on 13-8-8.
//  Copyright (c) 2013年 netease. All rights reserved.
//

#import "ViewController.h"
#import "WEPopoverController.h"
#import "WEPopoverContentViewController.h"
#import "UIImageView+XLProgressIndicator.h"

#define IMAGEURL @"http://etonvision.com/wp-content/uploads/2013/08/DSC_0693.jpg"

@interface ViewController ()<WEPopoverControllerDelegate> {
	UIImageView *imageView;
	WEPopoverController *popoverController;
}
@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initializeWithName:(NSString *)name
{
	return nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
	[imageView setContentMode:UIViewContentModeScaleAspectFit];
	[self.view addSubview:imageView];
	
	// progress color, yellow color in the example image.
	[[XLCircleProgressIndicator appearance] setStrokeProgressColor:[UIColor yellowColor]];
	
	// remaining color, gray color in the example image
	[[XLCircleProgressIndicator appearance] setStrokeRemainingColor:[UIColor grayColor]];
	
	//In order to set up the circle stroke's width you can choose between these 2 ways.
	[[XLCircleProgressIndicator appearance] setStrokeWidth:3.0f];

	[self.view setBackgroundColor:[UIColor blackColor]];
	UIImageView *newImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, CGRectGetHeight(self.view.frame))];
	[newImageView setContentMode:UIViewContentModeScaleAspectFit];
	[newImageView setImageWithProgressIndicatorAndURL:[NSURL URLWithString:@"http://h.hiphotos.baidu.com/album/w%3D2048/sign=1b4d99a0cdbf6c81f7372be88806b335/9345d688d43f8794230d35e6d31b0ef41ad53a03.jpg"]];
	[self.view addSubview:newImageView];
	
	
	NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(downloadImage:) object:IMAGEURL];
	NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
	[operationQueue addOperation:operation];
	
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	[button setFrame:CGRectMake(0.0, 110.0, 100, 44)];
	[button setTintColor:[UIColor blueColor]];
	[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[button setTitle:@"abc" forState:UIControlStateNormal];
	[self.view addSubview:button];
	
	[button addTarget:self action:@selector(didClick:) forControlEvents:UIControlEventTouchUpInside];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didClick:(id)sender {
	UIButton *button = (UIButton *)sender;
	if (!popoverController) {
		WEPopoverContentViewController *tableView = [[WEPopoverContentViewController alloc] initWithStyle:UITableViewStylePlain];
		popoverController = [[WEPopoverController alloc] initWithContentViewController:tableView];
		popoverController.delegate = self;
	}
	
	[popoverController presentPopoverFromRect:button.frame
									   inView:self.view
					 permittedArrowDirections:UIPopoverArrowDirectionAny
									 animated:YES];
	
}

- (void)downloadImage:(NSString *)url {
	NSLog(@"Begin download  from --> %@",url);
	NSURL *nsURL = [NSURL URLWithString:url];
	NSData *data = [[NSData alloc] initWithContentsOfURL:nsURL];
	UIImage *image = [UIImage imageWithData:data];
	[self performSelectorOnMainThread:@selector(updateMainUI:) withObject:image waitUntilDone:YES];
}

- (void)updateMainUI:(UIImage *)image {
	NSLog(@"Finish download!");
	imageView.image = image;
}

+ (ViewController *)create {
	return nil;
}

#pragma mark -
#pragma mark WEPopoverController Delegate
- (void)popoverControllerDidDismissPopover:(WEPopoverController *)popoverController {
	
}

- (BOOL)popoverControllerShouldDismissPopover:(WEPopoverController *)popoverController{
	return YES;
}
@end
