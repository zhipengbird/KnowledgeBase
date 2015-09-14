//
//  ASDatabaseAgent.h
//  anyshare
//
//  Created by Luan Ma on 13-7-4.
//  Copyright (c) 2013年 Lenovo. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <sqlite3.h>

typedef void(^VoidResponseBlock)(void);


@interface PlayGameDatabaseAgent : NSThread
@property (assign, atomic) BOOL cancel;
+(PlayGameDatabaseAgent*) databaseAgent;

- (void)syncExecuteBlock:(VoidResponseBlock)blocker;
- (void)asyncExecuteBlock:(VoidResponseBlock)blocker;

- (sqlite3_stmt*)prepare:(const char*)sql;

- (int)exec:(const char*)sql;
@end
