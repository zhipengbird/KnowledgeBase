//
//  ReaderHelper.h
//  NYWCGame
//
//  Created by shareit on 15/7/6.
//
//

#import <Foundation/Foundation.h>

@interface ReaderHelper : NSObject
/**
 *  读取字典里对应键的值，如果不存在返回0
 *
 *  @param dic 字典
 *  @param key 键
 *
 *  @return 长整型整数
 */
+(long long)readLongLong:(NSDictionary*)dic forKey:(NSString*)key;
/**
 *  读取字典里对应键的值，如果不存在返回0
 *
 *  @param dic 字典
 *  @param key 键
 *
 *  @return 浮点数
 */
+(float)readfloat:(NSDictionary*)dic forKey:(NSString*)key ;
/**
 *  读取字典里对应键的值，如果不存在返回0
 *
 *  @param dic 字典
 *  @param key 键
 *
 *  @return 整数
 */
+(int)readInt:(NSDictionary*)dic forKey:(NSString*)key;
/**
 *  读取字典里对应键的值，如果不存在返回nil
 *
 *  @param dic 字典
 *  @param key 键
 *
 *  @return 字符串
 */
+(NSString*)readString:(NSDictionary*)dic forKey:(NSString*)key;
/**
 *  读取字典里对应键的值，如果不存在返回nil
 *
 *  @param dic 字典
 *  @param key 键
 *
 *  @return 字典对象
 */
+(NSDictionary*)readDictionary:(NSDictionary*)dic forKey:(NSString*)key;
/**
 *  读取字典里对应键的值，如果不存在返回nil
 *
 *  @param dic 字典
 *  @param key 键
 *
 *  @return 数组对象
 */
+(NSArray*)readArray:(NSDictionary*)dic forKey:(NSString*)key;
/**
 *  读取数组里对应下的的值，不存在为0
 *
 *  @param dic   数组对象
 *  @param index 数组下标
 *
 *  @return 长整型
 */
+(long long)readLongLong:(NSArray*)dic forIndex:(NSString*)index;
/**
 *  读取数组里对应下的的值，不存在为0
 *
 *  @param dic   数组对象
 *  @param index 数组下标
 *
 *  @return 浮点数
 */
+(float)readfloat:(NSArray*)dic forIndex:(NSString*)index;
/**
 *  读取数组里对应下的的值，不存在为0
 *
 *  @param dic   数组对象
 *  @param index 数组下标
 *
 *  @return 整型
 */
+(int)readInt:(NSArray*)dic forIndex:(NSString*)index;
/**
 *  读取数组里对应下的的值，不存在为nil
 *
 *  @param dic   数组对象
 *  @param index 数组下标
 *
 *  @return 字符串
 */
+(NSString*)readString:(NSArray*)dic forIndex:(NSString*)index;
/**
 *  读取数组里对应下的的值，不存在为nil
 *
 *  @param dic   数组对象
 *  @param index 数组下标
 *
 *  @return 字典对象
 */
+(NSDictionary*)readDictionary:(NSArray*)dic forIndex:(NSString*)index;
/**
 *  读取数组里对应下的的值，不存在为nil
 *
 *  @param dic   数组对象
 *  @param index 数组下标
 *
 *  @return 数组对象
 */
+(NSArray*)readArray:(NSArray*)dic forIndex:(NSString*)index;


@end
