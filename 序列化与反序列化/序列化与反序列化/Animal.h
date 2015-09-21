//
//  Animal.h
//  序列化与反序列化
//
//  Created by shareit on 15/9/21.
//  Copyright (c) 2015年 shareit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Animal : NSObject<NSCoding>
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *desciption;
@property(nonatomic,copy)NSString *kemu;
@end
