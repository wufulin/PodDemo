//
//  ViewController.m
//  PodDemo
//
//  Created by wufulin on 13-8-8.
//  Copyright (c) 2013年 netease. All rights reserved.
//

#import "ViewController.h"

#define IMAGEURL @"http://etonvision.com/wp-content/uploads/2013/08/DSC_0693.jpg"

@interface ViewController () {
	UIImageView *imageView;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
	[imageView setContentMode:UIViewContentModeScaleAspectFit];
	[self.view addSubview:imageView];
	
	NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(downloadImage:) object:IMAGEURL];
	NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
	[operationQueue addOperation:operation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
@end
