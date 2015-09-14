//
//  ViewController.m
//  FMDBTEST
//
//  Created by shareit on 15/8/25.
//  Copyright (c) 2015年 shareit. All rights reserved.
//

#import "ViewController.h"
#import "FMDB.h"
#import "ReaderHelper.h"
#define DB_NAME @"PlayGame.sqlite"
@interface ViewController ()

@end

@implementation ViewController
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
- (void)viewDidLoad {
    [super viewDidLoad];
    
    FMDatabase * db=[FMDatabase databaseWithPath:[self getDBPath]];
    [db open];
    [db executeUpdate:@"CREATE TABLE IF NOT EXISTS Card ("
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
     "cardField11 INTEGER)" ];
    [db executeUpdate:@"CREATE TABLE IF NOT EXISTS CardContent ("
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
    
    [self loadDefaultCard:db];
    
    // Do any additional setup after loading the view, typically from a nib.
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
-(void)loadDefaultCard:(FMDatabase *)db
{
    NSString * path = [[NSBundle mainBundle]pathForResource:@"card.plist" ofType:nil];
    NSDictionary *dictionary=[NSDictionary dictionaryWithContentsOfFile:path];
    
    long i=0;
    while (i++< INTMAX_MAX ) {
        
        
        
        
        for (NSString *key in [dictionary allKeys])
        {
            
            NSArray *array = [dictionary objectForKey:key];
            for (NSDictionary *dic in array)
            {
                int cardid=[ReaderHelper readInt:dic forKey:@"id"];
                
                
                NSString * des= [ReaderHelper readString:dic forKey:@"des"];
                NSString * name =[ReaderHelper readString:dic forKey:@"name"];
                NSArray *array=[ReaderHelper readArray:dic forKey:@"cardContent"];
                NSString *img =[ReaderHelper readString:dic forKey:@"img"];
                NSString * cTime=[ReaderHelper readString:dic forKey:@"createTime"];
                char *zSQL = sqlite3_mprintf("INSERT INTO Card ('cardID','CardName','CardDes','cardContentNum','cardBgImage','cardCreateTime','cardLanuage') VALUES (%d,'%q','%q',%d,'%q',%d, '%q')",cardid,[name UTF8String],[des UTF8String],array.count,[img UTF8String],[cTime integerValue],[key UTF8String]);
                [db executeUpdate:[NSString stringWithUTF8String:zSQL]];
                
                
                int length=(int)array.count;
                int *indexarray=new int[length];
                loadArray(indexarray, length);
                int i = 0;
                [db beginTransaction];
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
                    
                    [db executeUpdate:[NSString stringWithUTF8String:zSQL]];
                    
                }
                  [db commit];
            }
        }
        
      
        
    }
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
