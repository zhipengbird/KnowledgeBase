//
//  ASDatabaseAgent.m
//  anyshare
//
//  Created by Luan Ma on 13-7-4.
//  Copyright (c) 2013年 Lenovo. All rights reserved.
//

#import "PlayGameDatabaseAgent.h"
#include <string.h>


#define DB_NAME @"PlayGame.sqlite"

@implementation PlayGameDatabaseAgent {
    sqlite3* _db;
    int _error;
    char* _errorDesc;
}

-(void)main {
    @autoreleasepool {
    
            [self openDb];


        
        [NSTimer scheduledTimerWithTimeInterval:100 target:self selector:@selector(timer) userInfo:nil repeats:YES];
        do {
            // Start the run loop but return after each source is handled.
            SInt32    result = CFRunLoopRunInMode(kCFRunLoopDefaultMode, 10, YES);
            
            // If a source explicitly stopped the run loop, or if there are no
            // sources or timers, go ahead and exit.
            if ((result == kCFRunLoopRunStopped) || (result == kCFRunLoopRunFinished))
                _cancel = true;
            
            // Check for any other exit conditions here and set the
            // done variable as needed.
        }
        while (!_cancel);
        
        [self closeDb];
    }
}

-(void)dealloc {
}

-(void)timer {
}

+(PlayGameDatabaseAgent*) databaseAgent {
    static PlayGameDatabaseAgent* agent = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        agent = [[PlayGameDatabaseAgent alloc] init];
        [agent start];
    });
    return agent;
}

- (void)closeDb{
    if (_db)
        sqlite3_close(_db);
    _db = nil;
    if (_errorDesc) free(_errorDesc);
}
- (BOOL)isExistDB
{
    NSFileManager* fm = [[NSFileManager alloc] init];
    return [fm fileExistsAtPath:[self getDBPath]];
}
- (NSString *)getDBPath
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString* databasePath = (NSString *) [paths lastObject];
    NSFileManager* manager = [[NSFileManager alloc] init];
    if (![manager fileExistsAtPath:databasePath]) {
        NSError *error;
        [manager createDirectoryAtPath:databasePath withIntermediateDirectories:YES attributes:nil error:&error];
        if (error)
            NSLog(@"error: %@", error);
    }
    databasePath = [databasePath stringByAppendingPathComponent:DB_NAME];
    NSLog(@"databasePath===%@",databasePath);
    return databasePath;
}
- (void)openDb {
    int ret = sqlite3_open([[self getDBPath] UTF8String], &_db);
    if (ret != SQLITE_OK)
    {
        if (_errorDesc) free(_errorDesc);
        _error = -1;
        static const char* e = "sqlite3_open";
        _errorDesc = (char*)malloc(strlen(e)+1);
        strcpy(_errorDesc, e);
    }
}

- (void)syncExecuteBlock:(VoidResponseBlock)blocker {
    if (blocker) {
        if ([NSThread currentThread] == self) {
            blocker();
        } else {
            [self performSelector:@selector(syncExecuteBlock:) onThread:self withObject:blocker waitUntilDone:YES];
        }
    }
}

- (void)asyncExecuteBlock:(VoidResponseBlock)blocker {
    [self performSelector:@selector(syncExecuteBlock:) onThread:self withObject:blocker waitUntilDone:NO];
}

- (sqlite3_stmt*)prepare:(const char*)sql {
    
    sqlite3_stmt *stmt = NULL;
    int result = sqlite3_prepare_v2(_db, sql, -1, &stmt, NULL);
    if (result != SQLITE_OK)
    {
        _error = -1;
        if (_errorDesc) free(_errorDesc);
        _errorDesc = nil;
        static const char* e = "sqlite3_prepare_v2";
        static size_t len = 0;
        if (len == 0)
            len = strlen(e);
        char* temp = (char*)malloc(len+1);
        memcpy(temp, e, len+1);
        _errorDesc = temp;
        
        if (stmt) sqlite3_finalize(stmt);
        stmt = NULL;
    }
    return stmt;
}

- (int)exec:(const char*)sql {
    char* errormsg = NULL;
    int result = sqlite3_exec(_db, sql, NULL, NULL, &errormsg);
    if (result != SQLITE_OK)
    {
        _error = -1;
        if (_errorDesc) free(_errorDesc);
        _errorDesc = nil;
        if (errormsg) {
            size_t len = strlen(errormsg);
            char* temp = (char*)malloc(len+1);
            memcpy(temp, errormsg, len+1);
            _errorDesc = temp;
            sqlite3_free(errormsg);
        }
    }
    return result;
}
@end
