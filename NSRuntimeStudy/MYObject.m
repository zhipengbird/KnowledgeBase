//
//  MYObject.m
//  NSRuntimeStudy
//
//  Created by shareit on 15/9/15.
//  Copyright (c) 2015年 shareit. All rights reserved.
//

#import "MYObject.h"

@interface MYObject()
{
    NSString *sex;
    int weight;
    struct myself
    {
        int age;
        int weight;
    } sss;
}
@end

@implementation MYObject

-(instancetype)init {
    self = [super init];
    if(self) {
        sss.age = 1;
        sss.weight = 2;
    }
    return self;
}
@end
