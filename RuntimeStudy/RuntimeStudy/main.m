//
//  main.m
//  RuntimeStudy
//
//  Created by shareit on 15/9/14.
//  Copyright (c) 2015年 shareit. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MyObject : NSObject
@property(nonatomic,copy)NSString * name;

@end

@implementation MyObject

-(instancetype)init
{
    if (self=[super init]) {
        [self setName:nil];
    }
    return self;
}

@end


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        id obj1=[NSMutableArray alloc];
        id obj2=[[NSMutableArray alloc]init];
        
        id obj3=[NSArray alloc];
        id obj4=[[NSArray alloc]initWithObjects:@"hello", nil];
        
        NSLog(@"obj1 class is %@",NSStringFromClass([obj1 class]));
        
        NSLog(@"obj2 class is %@",NSStringFromClass([obj2 class]));
        NSLog(@"obj3 class is %@",NSStringFromClass([obj3 class]));
        NSLog(@"obj4 class is %@",NSStringFromClass([obj4 class]));
        
        id obj5 = [MyObject alloc];
        
        NSLog(@"obj5 class is %@",NSStringFromClass([obj5 class]));
        id obj6 = [[MyObject alloc]init];
        NSLog(@"obj6 class is %@",NSStringFromClass([obj6 class]));
        
        
        
        
    }
    return 0;
}
