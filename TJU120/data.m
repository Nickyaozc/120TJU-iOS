//
//  data.m
//  TJU120
//
//  Created by 秦昱博 on 15/7/21.
//  Copyright (c) 2015年 TWT Studio. All rights reserved.
//

#import "data.h"

@implementation data

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (data *)shareInstance {
    static data *staticInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        staticInstance = [[self alloc] init];
    });
    return staticInstance;
}

@end
