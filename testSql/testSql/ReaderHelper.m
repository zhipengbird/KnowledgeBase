//
//  ReaderHelper.m
//  NYWCGame
//
//  Created by shareit on 15/7/6.
//
//

#import "ReaderHelper.h"

@implementation ReaderHelper
+(long long)readLongLong:(NSDictionary*)dic forKey:(NSString*)key {
    if ([dic isKindOfClass:[NSDictionary class]]) {
        id value = dic[key];
        if ([value isKindOfClass:[NSNumber class]]) {
            return [(NSNumber*)value longLongValue];
        } else if ([value isKindOfClass:[NSString class]]){
            return [(NSString*)value longLongValue];
        }
    }
    return 0;
}
+(float)readfloat:(NSDictionary*)dic forKey:(NSString*)key {
    if ([dic isKindOfClass:[NSDictionary class]]) {
        id value = dic[key];
        if ([value isKindOfClass:[NSNumber class]]) {
            return [(NSNumber*)value floatValue];
        } else if ([value isKindOfClass:[NSString class]]){
            return [(NSString*)value floatValue];
        }
    }
    return 0;
}
+(int)readInt:(NSDictionary *)dic forKey:(NSString *)key
{
    if ([dic isKindOfClass:[NSDictionary class]]) {
        id value=dic[key];
        if ([value isKindOfClass:[NSNumber class]]) {
            
            return [(NSNumber*)value intValue];
        }else if([value isKindOfClass:[NSString class]])
        {
            return [(NSString*)value intValue];
        }
    }
    return 0;
}
+(NSString *)readString:(NSDictionary *)dic forKey:(NSString *)key
{
    if ([dic isKindOfClass:[NSDictionary class]]) {
        id value=dic[key];
        if ([value isKindOfClass:[NSString class]]) {
            
            return (NSString*)value;
        }else if([value isKindOfClass:[NSNumber class]])
        {
            return  [(NSNumber*)value stringValue];
        }
    }
    return nil;
}
+(NSArray *)readArray:(NSDictionary *)dic forKey:(NSString *)key
{
    if ([dic isKindOfClass:[NSDictionary class]]) {
        id value=dic[key];
        if ([value isKindOfClass:[NSArray class]]) {
            
            return (NSArray*)value;
        }
    }
    return nil;

}
+(NSDictionary *)readDictionary:(NSDictionary *)dic forKey:(NSString *)key
{
    if ([dic isKindOfClass:[NSDictionary class]]) {
        id value=dic[key];
        if ([value isKindOfClass:[NSDictionary class]]) {
            
            return (NSDictionary*)value;
        }
    }
    return nil;

}
+(long long)readLongLong:(NSArray*)dic forIndex:(NSString*)index{

    if ([dic isKindOfClass:[NSArray class]]) {
        id value = [(NSArray*)dic objectAtIndex:index];
        if ([value isKindOfClass:[NSNumber class]]) {
            return [(NSNumber*)value longLongValue];
        } else if ([value isKindOfClass:[NSString class]]){
            return [(NSString*)value longLongValue];
        }
    }
    return 0;
}
+(float)readfloat:(NSArray *)dic forIndex:(NSString *)index
{
    if ([dic isKindOfClass:[NSArray class]]) {
        id value = [(NSArray*)dic objectAtIndex:index];
        if ([value isKindOfClass:[NSNumber class]]) {
            return [(NSNumber*)value floatValue];
        } else if ([value isKindOfClass:[NSString class]]){
            return [(NSString*)value floatValue];
        }
    }
    return 0;
}
+(int)readInt:(NSArray*)dic forIndex:(NSString*)index{
    if ([dic isKindOfClass:[NSArray class]]) {
        id value=[(NSArray*)dic objectAtIndex:index];
        if ([value isKindOfClass:[NSNumber class]]) {
            
            return [(NSNumber*)value intValue];
        }else if([value isKindOfClass:[NSString class]])
        {
            return [(NSString*)value intValue];
        }
    }
    return 0;
}
+(NSString*)readString:(NSArray*)dic forIndex:(NSString*)index{

    if ([dic isKindOfClass:[NSArray class]]) {
        id value= [(NSArray*)dic objectAtIndex:index];
        if ([value isKindOfClass:[NSString class]]) {
            
            return (NSString*)value;
        }else if([value isKindOfClass:[NSNumber class]])
        {
            return  [(NSNumber*)value stringValue];
        }
    }
    return nil;
}
+(NSDictionary*)readDictionary:(NSArray*)dic forIndex:(NSString*)index{
    if ([dic isKindOfClass:[NSArray class]]) {
        id value=[(NSArray*)dic objectAtIndex:index];
        if ([value isKindOfClass:[NSDictionary class]]) {
            
            return (NSDictionary*)value;
        }
    }
    return nil;
}
+(NSArray*)readArray:(NSArray*)dic forIndex:(NSString*)index{

    if ([dic isKindOfClass:[NSArray class]]) {
        id value=[(NSArray*)dic objectAtIndex:index];
        if ([value isKindOfClass:[NSArray class]]) {
            
            return (NSArray*)value;
        }
    }
    return nil;
}

@end
