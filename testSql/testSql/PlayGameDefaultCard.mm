//
//  PlayGameDefaultCard.m
//  NYWCGame
//
//  Created by shareit on 15/7/14.
//
//

#import "PlayGameDefaultCard.h"
#import "PlayGameDatabaseAgent.h"
#import "ReaderHelper.h"
#include <iostream>

@implementation PlayGameDefaultCard

+(void)initialize
{
    PlayGameDatabaseAgent* agent = [PlayGameDatabaseAgent databaseAgent];
    [agent asyncExecuteBlock:^{
        [agent exec:"CREATE TABLE IF NOT EXISTS Card ("
         "id INTEGER PRIMARY KEY AUTOINCREMENT,"
         "cardID INTEGER,"
         "cardType INTEGER,"
         "CardName TEXT,"
         "CardDes TEXT,"
         "cardLastUpdateTime INTEGER,"
         "cardContentNum INTEGER,"
         "cardCharge_type INTEGER,"
         "cardBgImage TEXT,"
         "cardCoverimage TEXT,"
         "cardDownload_url TEXT,"
         "cardpass_soud TEXT,"
         "cardok_sound TEXT,"
         "cardcountdown_sound TEXT,"
         "cardendtime_sound TEXT,"
         "cardIndex INTEGER,"
         "cardPlayIndex INTEGER DEFAULT 0,"
         "cardCreateTime INTEGER DEFAULT 10000,"
         "cardLanuage TEXT,"
         "cardPrice TEXT,"
         "cardField1 TEXT,"
         "cardField2 TEXT,"
         "cardField3 TEXT,"
         "cardField4 TEXT,"
         "cardField5 TEXT,"
         "cardField6 TEXT,"
         "cardField7 TEXT,"
         "cardField8 TEXT,"
         "cardField9 INTEGER,"
         "cardField10 INTEGER,"
         "cardField11 INTEGER)"];
        [agent exec:"CREATE TABLE IF NOT EXISTS CardContent ("
         "id INTEGER PRIMARY KEY AUTOINCREMENT,"
         "cardID INTEGER,"
         "contentID INTEGER,"
         "contentName TEXT,"
         "contentimg TEXT default null,"
         "contentIndex INTEGER,"
         "contentField1 TEXT,"
         "contentField2 TEXT,"
         "contentField3 TEXT,"
         "contentField4 INTEGER,"
         "contentField5 INTEGER)"];
    }];
}

void loadArray(int *array , int length)
{
    for (int i=0; i<length; i++) {
        array[i]=i;
    }
    //    std::random_shuffle(array, array+length);
    int i,r,t;
    srand((unsigned)time(NULL));//保证每次产生的随机数是唯一
    for (i=1; i<length; i++) {
        r=rand()%(length-i)+i;
        t=array[i-1];
        array[i-1]=array[r];
        array[r]=t;
    }
}
+(void)loadDefaultCard:(NSString *)language AndCardID:(int )cardID
{
    NSString * path = [[NSBundle mainBundle]pathForResource:@"card.plist" ofType:nil];
    NSDictionary *dictionary=[NSDictionary dictionaryWithContentsOfFile:path];
    
    PlayGameDatabaseAgent *agent=[PlayGameDatabaseAgent databaseAgent];
    long i=0;
    do {
        
        
        [agent syncExecuteBlock:^{
            [agent exec:"begin transaction"];
            for (NSString *key in [dictionary allKeys])
            {
                //            if (language != NULL)
                //            {
                //                if ([key isEqualToString:language] == NO)
                //                {
                //                    continue;
                //                }
                //            }
                NSArray *array = [dictionary objectForKey:key];
                for (NSDictionary *dic in array)
                {
                    int cardid=[ReaderHelper readInt:dic forKey:@"id"];
                    //                if (cardID != 0)
                    //                {
                    //                    if (cardid != cardID)
                    //                    {
                    //                        continue;
                    //                    }
                    //                }
                    //                sqlite3_stmt *stmt=[agent prepare:[[NSString stringWithFormat:@"SELECT * FROM Card WHERE cardID =%d",cardid] UTF8String]];
                    //                if (stmt) {
                    //                    if (sqlite3_step(stmt)==SQLITE_ROW) {
                    //                        char *cardSQL = sqlite3_mprintf("DELETE FROM Card WHERE  cardID = %d",cardid);
                    //                        char *contentSQL = sqlite3_mprintf("DELETE FROM CardContent WHERE  cardID = %d", cardid);
                    //                        [agent exec:cardSQL];
                    //                        [agent exec:contentSQL];
                    //                        sqlite3_free(cardSQL);
                    //                        sqlite3_free(contentSQL);
                    //                    }
                    //                }
                    //                if (stmt) {
                    //                    sqlite3_finalize(stmt);
                    //
                    //                }
                    
                    NSString * des= [ReaderHelper readString:dic forKey:@"des"];
                    NSString * name =[ReaderHelper readString:dic forKey:@"name"];
                    NSArray *array=[ReaderHelper readArray:dic forKey:@"cardContent"];
                    NSString *img =[ReaderHelper readString:dic forKey:@"img"];
                    NSString * cTime=[ReaderHelper readString:dic forKey:@"createTime"];
                    char *zSQL = sqlite3_mprintf("INSERT INTO Card ('cardID','CardName','CardDes','cardContentNum','cardBgImage','cardCreateTime','cardLanuage') VALUES (%d,'%q','%q',%d,'%q',%d, '%q')",cardid,[name UTF8String],[des UTF8String],array.count,[img UTF8String],[cTime integerValue],[key UTF8String]);
                    [agent exec:zSQL];
                    sqlite3_free(zSQL);
                    
                    
                    int length=(int)array.count;
                    int *indexarray=new int[length];
                    loadArray(indexarray, length);
                    int i = 0;
                    for (NSDictionary *card in array) {
                        int contentid=[ReaderHelper readInt:card forKey:@"id"];
                        NSString * name=[ReaderHelper readString:card forKey:@"name"];
                        NSString *image=[ReaderHelper readString:card forKey:@"img"];
                        int index=indexarray[i++];
                        char *zSQL = nil;
                        
                        
                        if (image) {
                            zSQL = sqlite3_mprintf("INSERT INTO CardContent ('cardID', 'contentID', 'contentName','contentimg','contentIndex')VALUES (%d,%d,'%q','%q',%d)",cardid,contentid,[name UTF8String],[image UTF8String],index);
                        }
                        else
                        {
                            zSQL = sqlite3_mprintf("INSERT INTO CardContent ('cardID', 'contentID', 'contentName','contentIndex')VALUES (%d,%d,'%q',%d)",cardid,contentid,[name UTF8String],index);
                        }
                        
                        [agent exec:zSQL];
                        
                        sqlite3_free(zSQL);
                        
                    }
                }
            }
            
            [agent exec:"commit transaction"];
            
        }];
        
    } while (i++<LONG_LONG_MAX);
    //    [agent syncExecuteBlock:^{
    //        char *distinct =sqlite3_mprintf("delete from CardContent where contentName  in (select  cardID,contentName  from CardContent  group  by  cardID   having  count(contentName) > 1)"
    //                                        " and rowid not in (select min(rowid) from  CardContent  group by cardID having count(contentName )>1)");
    //        [agent exec:distinct];
    //        sqlite3_free(distinct);
    //        //        http://www.68design.net/Development/Database/27842-1.html
    //    }];
}
@end
