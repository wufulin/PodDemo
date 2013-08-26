//
//  MyOperation.h
//  PodDemo
//
//  Created by wufulin on 13-8-26.
//  Copyright (c) 2013年 netease. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^MyOperationAction)(void);

@interface MyOperation : NSOperation
- (id)initWithAction:(MyOperationAction)action;
@end
