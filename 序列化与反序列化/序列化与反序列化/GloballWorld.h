//
//  GloballWorld.h
//  序列化与反序列化
//
//  Created by shareit on 15/9/21.
//  Copyright (c) 2015年 shareit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GloballWorld : NSObject<NSCoding>
@property (nonatomic,copy)NSString *  water;
@property(nonatomic,copy)NSString  *  plant;
@property(nonatomic,copy)NSString  *  anima;
@property(nonatomic,copy)NSString  *  people;
@property(nonatomic,copy)NSString  *  watch;
@property(nonatomic)long long area;
@property(nonatomic)long long peoplecount;
@property(nonatomic)long long old;
@property(nonatomic,copy)NSString *sun;
@property(nonatomic,copy)NSString *moon;
@property(nonatomic)float distanceToSun;
@property(nonatomic)float distanceTomoon;
@property(nonatomic,copy) NSString *earthName;
@property(nonatomic,copy) NSString *cars;
//..........
@end
