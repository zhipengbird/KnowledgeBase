//
//  Animal.m
//  序列化与反序列化
//
//  Created by shareit on 15/9/21.
//  Copyright (c) 2015年 shareit. All rights reserved.
//

#import "Animal.h"

@implementation Animal
-(id)initWithCoder:(NSCoder *)aDecoder
{
    
    if (self=[super init]) {
        [self setName:[aDecoder decodeObjectForKey:@"name"]];
        [self setDesciption:[aDecoder decodeObjectForKey:@"desciption"]];
        [self setKemu:[aDecoder decodeObjectForKey:@"kemu"]];
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_desciption forKey:@"desciption"];
    [aCoder encodeObject:_kemu forKey:@"kemu"];
}
-(NSString *)description
{
    return [[NSString alloc ]initWithFormat:@"name==%@,desciption=%@,kemu=%@",_name,_desciption,_kemu ];
}
@end
