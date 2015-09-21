//
//  ViewController.m
//  序列化与反序列化
//
//  Created by shareit on 15/9/21.
//  Copyright (c) 2015年 shareit. All rights reserved.
//

#import "ViewController.h"
#import "Animal.h"
#import "GloballWorld.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    NSKeyedArchiver/ NSKeyedUnarchiver
    //   NSArchiver
    //    1.使用基本数据类型存当与解档
    NSArray *array= @[@(100),@(200),@(300),@"hello",@"word"];
    [array writeToFile:[self getFilePath:@"array.plist"] atomically:YES];
    NSDictionary * diction=@{@"afd":@"affd",@"array":array};
    [diction writeToFile:[self getFilePath:@"diction.plist"] atomically:YES];
    
    
    Animal *anima=[Animal new];
    anima.name=@"zhouchong";
    anima.desciption=@"diaoshi";
    anima.kemu=@"ren";
    NSLog(@"anima==%@",[anima description]);
    //转成NSData
    NSData * animalData=  [NSKeyedArchiver archivedDataWithRootObject:anima];
    //    从NSData中解析出数据对象
    Animal * newAnima=   [NSKeyedUnarchiver unarchiveObjectWithData:animalData];
     NSLog(@"newAnima==%@",[newAnima description]);
    //    写入数据流程：
    //    1）先定义 NSMutableData 对象  data
    //    2）定义归档、压缩类 NSKeyedArchiver 并用 data进行初始化
    //    3）encodeObject 编码对象，并指定 key
    //    4）finishEncoding 完成编码
    //    5）writeToFile 写入文件
    
    
    
    NSMutableData *mutableData=[[NSMutableData alloc]init];
    NSKeyedArchiver *arvhiver=[[NSKeyedArchiver alloc]initForWritingWithMutableData:mutableData ];
    [arvhiver encodeObject:anima forKey:@"animal"];
    [arvhiver finishEncoding];
    [mutableData writeToFile:[self getFilePath:@"Data.plist"] atomically:YES];
  
    
    
    
    //    读取数据流程：
    //    1）先定义 NSData 对象  data，读取指定路径 data
    //    2）定义解压类 NSKeyedUnarchiver 并用 data进行初始化
    //    3）根据key 使用 decodeObjectForKey 获取对象
    //    4）finishDecoding 完成解码
    
    NSData *readData=[NSData dataWithContentsOfFile:[self getFilePath:@"Data.plist"]];
    
    NSKeyedUnarchiver *unarchiver=[[NSKeyedUnarchiver alloc]initForReadingWithData:readData];
    Animal * animal1= [unarchiver decodeObjectForKey:@"animal"];
    [unarchiver finishDecoding];
    NSLog(@"animal1==%@",[animal1 description]);
//    要序例化多个对象，要怎么做？？
    
    
    CGPoint point=CGPointMake(0, 0);
    CGSize size=CGSizeMake(20, 20);
    CGRect rect=CGRectMake(0, 0, 200, 200);
    CGVector vector=CGVectorMake(3, 3);
    NSInteger count =10;
    BOOL isSure= YES;
    int32_t inttype =100;
    int64_t int64type=1000;
    float floattype=3.0;
    double doubletype=3.0;
    
    
    
    
//    反序列化多个对象，又该怎么做？？
    

    
    
    
    //    将数据归档成NSData并直接写入文件
    [NSKeyedArchiver archiveRootObject:anima toFile:[self getFilePath:@"archive.plist"]];
    
    Animal *animal2=  [NSKeyedUnarchiver unarchiveObjectWithFile:[self getFilePath:@"archive.plist"]];
      NSLog(@"animal2==%@",[animal2 description]);
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}
-(NSString *)getFilePath:(NSString *)fileName
{
    NSString *path= [NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES)lastObject];
    NSFileManager * manager=[NSFileManager defaultManager];
    if (![manager fileExistsAtPath:path ]) {
        NSError *error=nil;
        [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            NSLog(@"error:%@",error.localizedDescription);
        }
    }
    path=[path stringByAppendingPathComponent:fileName];
    return path;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
