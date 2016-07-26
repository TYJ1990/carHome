


//
//  OnlyOne.m
//  Product-B
//
//  Created by lanou on 16/7/14.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "OnlyOne.h"
static OnlyOne *onlyOne;
@implementation OnlyOne

+ (OnlyOne *)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        onlyOne = [[OnlyOne alloc] init];
    });
    return onlyOne;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.titleArray = [NSMutableDictionary dictionary];
    }
    return self;
}

@end
