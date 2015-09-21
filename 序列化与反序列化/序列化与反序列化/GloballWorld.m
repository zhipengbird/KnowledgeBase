//
//  GloballWorld.m
//  序列化与反序列化
//
//  Created by shareit on 15/9/21.
//  Copyright (c) 2015年 shareit. All rights reserved.
//

#import "GloballWorld.h"
#import <objc/runtime.h>
@implementation GloballWorld
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super init]) {
        
        unsigned  count=0;
//        获取变量列表及变量的个数
        Ivar *ivars=class_copyIvarList([self class], &count);
        for (int i=0; i<count; i++) {
            Ivar ivar=ivars[i];
//            取出对应变量的名字
            const char * name =ivar_getName(ivar);
//            转成对应的key
            NSString * key=[NSString stringWithUTF8String:name];
//            解档
            id value= [aDecoder decodeObjectForKey:key];
//            设置到成员变量的值
            [self setValue:value forKey:key];
        }
        free(ivars);
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    unsigned  count=0;
    //        获取变量列表及变量的个数
    Ivar *ivars=class_copyIvarList([self class], &count);
    
    for (int i=0; i<count; i++) {
        Ivar ivar=ivars[i];
        //            取出对应变量的名字
        const char * name =ivar_getName(ivar);
//        归档
        NSString * key=[NSString stringWithUTF8String:name];
        id value= [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
    free(ivars);
    
}
@end
