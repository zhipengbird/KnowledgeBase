//
//  ViewController.m
//  HttpTest
//
//  Created by shareit on 15/9/10.
//  Copyright © 2015年 shareit. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)test {
    //2c1a58ef 82206e5c 85c7ffa5 8cbd7aef 437f8917 1c86e9b7 cca9e54e bd334369
    
    NSMutableURLRequest * request =[[NSMutableURLRequest alloc]init];
    [request setURL:[NSURL URLWithString:@"http://192.168.5.247:8092/command/1.0/iostoken"]];
    NSDictionary *dict=@{@"appId":@"com.qzkc.cleanit",@"deviceId":@"89789789789789789789789",@"token":@"2c1a58ef 82206e5c 85c7ffa5 8cbd7aef 437f8917 1c86e9b7 cca9e54e bd334369",@"language":@"zh-hans",@"country":@"cn",@"osVersion":@"ios7",@"appVersion":@"1.2.0",@"deviceType":@"ipad"};
//    @{@"appId":@"com.qzkc.cleanit",@"deviceId":@"89789789789789789789789",@"token":@"46164c8f 735ad070 1f7b5056 d65651b3 ff2a182c 3635b459 6779c998 fc3aed5d",@"language":@"zh-hans",@"country":@"cn",@"osVersion":@"ios7",@"appVersion":@"1.2.0",@"deviceType":@"ipad"}
    //    dict=@{"appId":"com.qzkc.cleanit","deviceId":"89789789789789789789789","token":"46164c8f 735ad070 1f7b5056 d65651b3 ff2a182c 3635b459 6779c998 fc3aed5d","language":"zh-hans","country":"cn","osVersion":"ios7","appVersion":"1.2.0","deviceType":"ipad"}
   
    NSData *data=[NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];

    [request setHTTPBody:data];
     [request setHTTPMethod:@"POST"];
 
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *  response, NSData * data, NSError * connectionError) {
        
        NSLog(@"%@",response);
        NSDictionary *dic= [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
    }];
}

-(void)tst
{

    static NSString *urlString = @"http://192.168.5.247:8092/command/1.0/iostoken";
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    
    NSDictionary * dict=@{@"appId":@"com.qzkc.cleanit",@"deviceId":@"89789789789789789789789",@"token":@"46164c8f 735ad070 1f7b5056 d65651b3 ff2a182c 3635b459 6779c998 fc3aed5d",@"language":@"zh-hans",@"country":@"cn",@"osVersion":@"ios7",@"appVersion":@"1.2.0",@"deviceType":@"ipad"};
    NSMutableDictionary *dlist = [[NSMutableDictionary alloc] initWithDictionary:dict];
    NSData * body = [NSJSONSerialization dataWithJSONObject:dlist options:NSJSONWritingPrettyPrinted error:nil];
    [request setHTTPBody:body];
    [request setHTTPMethod:@"POST"];
 
    NSError *error = nil;
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (error) {
            NSLog(@"Something wrong: %@",[error description]);
        }else {
            if (response) {
                NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@"get %@",response);
                
            }
        }
        
    }];
}

-(void)why
{
    NSMutableURLRequest * request =[[NSMutableURLRequest alloc]init];
    [request setURL:[NSURL URLWithString:@"http://192.168.5.247:8092/command/1.0/iostoken"]];
    NSDictionary * dict=@{@"appId":@"com.qzkc.cleanit",@"deviceId":@"89789789789789789789789",@"token":@"46164c8f 735ad070 1f7b5056 d65651b3 ff2a182c 3635b459 6779c998 fc3aed5d",@"language":@"zh-hans",@"country":@"cn",@"osVersion":@"ios7",@"appVersion":@"1.2.0",@"deviceType":@"ipad"};
    [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setValue:@"UTF-8" forHTTPHeaderField:@"Accept-Charset"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSLog(@"%@",response);
        NSDictionary *dic= [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
        
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self test];
#if 0
    AFHTTPRequestOperationManager *mananger=[AFHTTPRequestOperationManager manager];
    NSDictionary *dict=@{@"appId":@"com.qzkc.cleanit",@"deviceId":@"89789789789789789789789",@"token":@"46164c8f 735ad070 1f7b5056 d65651b3 ff2a182c 3635b459 6779c998 fc3aed5d",@"language":@"zh-hans",@"country":@"cn",@"osVersion":@"ios7",@"appVersion":@"1.2.0",@"deviceType":@"ipad"};
//    mananger.requestSerializer=[AFHTTPRequestSerializer serializer];
    mananger.responseSerializer=[AFHTTPResponseSerializer serializer];
   
    [mananger POST:@"http://192.168.5.247:8092/command/1.0/iostoken" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
#endif
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
