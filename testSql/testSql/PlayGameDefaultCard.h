//
//  PlayGameDefaultCard.h
//  NYWCGame
//
//  Created by shareit on 15/7/14.
//
//

#import <Foundation/Foundation.h>

@interface PlayGameDefaultCard : NSObject
/**
*  加载内置的题卡数据
*
*  @param language 加载那种语言的默认题卡 NULL为加载所有语言
*  @param cardID   加载哪个cardID的题卡 0为加载当前语言所有数据
*/
+(void)loadDefaultCard:(NSString *)language AndCardID:(int )cardID;
@end
