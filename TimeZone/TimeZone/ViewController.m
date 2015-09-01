//
//  ViewController.m
//  TimeZone
//
//  Created by shareit on 15/8/4.
//  Copyright (c) 2015年 shareit. All rights reserved.
//

#import "ViewController.h"
#import <Social/Social.h>
#import <Social/SLServiceTypes.h>
@interface ViewController ()

@end

@implementation ViewController
- (IBAction)send:(id)sender {
    
      NSLog(@"%@",[NSTimeZone localTimeZone]);//当前所在时区
//    
//    UIActivityViewController *avc=[[UIActivityViewController alloc]initWithActivityItems:@[@"afdsf"] applicationActivities:nil];
//    [self presentViewController:avc animated:YES completion:nil];
    NSString *textToShare = @"请大家登录《iOS云端与网络通讯》服务网站。";
 UIImage *imageToShare = [UIImage imageNamed:@"成绩显示页面.png"];
    
    
//    w.ushareit.com/w/showme/sharepage/i.html?url=7xkuzo.media1.z0.glb.clouddn.com/0tub6Hg+vZ81uvyf7+mKvQ==?avthumb/mp4&img=7xkuzo.media1.z0.glb.clouddn.com/0tub6Hg+vZ81uvyf7+mKvQ==?vframe/jpg/offset/1/w/720/h/376
    NSURL *urlToShare = [NSURL URLWithString:@"http://w.ushareit.com/w/showme/sharepage/i.html?url=7xkuzo.media1.z0.glb.clouddn.com/QivxZEOKP0oVDH9SVePCMw==?avthumb/mp4&img=7 ... 20/h/376"];
    NSArray *ActivityItems = @[textToShare, imageToShare, urlToShare];
    UIActivityViewController *ActivityVC = [[UIActivityViewController alloc]initWithActivityItems:ActivityItems
                                                                            applicationActivities:nil];
    //不出现在活动项目
//    ActivityVC.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard,
//                                         UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll];
    [self presentViewController:ActivityVC animated:TRUE completion:nil];
    
//    SLComposeViewController *svc = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTencentWeibo];
//    SLComposeViewControllerCompletionHandler myblock = ^(SLComposeViewControllerResult result){
//        if(result == SLComposeViewControllerResultCancelled){
//            NSLog(@"cancel");
//        }else{
//            NSLog(@"done");
//        }
//        [svc dismissViewControllerAnimated:YES completion:nil];
//    };
//    svc.completionHandler = myblock;
//    [svc setInitialText:@"abc"];
//    [svc addURL:[NSURL URLWithString:@"http://www.baidu.com"]];
//    [self presentViewController:svc animated:YES completion:nil];
}

- (void)time {
    NSLog(@"%@",[NSDate date]);
    NSLog(@"%@",[NSTimeZone localTimeZone]);//当前所在时区
    NSLog(@"%@",[NSTimeZone systemTimeZone].abbreviation);
    NSLog(@"%@",[NSTimeZone localTimeZone].data);//时区的二进制数据
    NSLog(@"%@",[NSTimeZone localTimeZone].name);//时区的名字
    NSLog(@"%@",[NSTimeZone localTimeZone].abbreviation);//时区简写：GMT+8
    NSLog(@"%@",[NSTimeZone timeZoneDataVersion]);//时区的数字版本
    NSLog(@"%@",[NSTimeZone knownTimeZoneNames]);//已知时区列表
    NSLog(@"%@",[[NSTimeZone localTimeZone]abbreviationForDate:[NSDate date]]);//获取指定日期中的时区简写
    NSLog(@"%ld",(long)[[NSTimeZone localTimeZone]secondsFromGMTForDate:[NSDate date]]);
    NSLog(@"%@",[[NSTimeZone localTimeZone] localizedName:NSTimeZoneNameStyleDaylightSaving                                                locale:[NSLocale currentLocale]]);
}

-(void)timeDate
{
    NSDate *date=[NSDate date];
    NSTimeInterval time=[date timeIntervalSince1970];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT+0"]];
    NSString *stringdate=[formatter stringFromDate:date];
   date=[formatter dateFromString:stringdate];
    NSTimeInterval time1=[date timeIntervalSince1970];
}
-(void)timea
{
    NSTimeZone *zone=[NSTimeZone timeZoneWithName:@"IST"];
    NSLog(@"%@",zone.abbreviation);
    [self timeZone];
}

-(void)timeZone
{
    NSLog(@"%@",[NSTimeZone knownTimeZoneNames]);
    NSTimeZone *timezone=[NSTimeZone timeZoneWithName:@"EGST"];
    NSString * timeabr=timezone.abbreviation;
    if ([timeabr containsString:@"+"]||[timeabr containsString:@"-"]) {
        NSRange range=[timeabr rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@"+-"]];
        if (range.location!=NSNotFound) {
            timeabr= [timeabr substringFromIndex:range.location];
        }
        else
            timeabr= @"0";
        
        
    }
    else
        timeabr= @"0";

        
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSUserDefaults *defaulta =[NSUserDefaults standardUserDefaults];
    NSLog(@"%ld",[[defaulta objectForKey:@"fads"]integerValue]);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSHTTPURLResponse *response;
        NSData *returnData = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://ip.taobao.com/service/getIpInfo.php?ip=myip"]]
                                                   returningResponse:&response error:nil];
        
        if (response.statusCode == 200 && returnData) {
            NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:returnData options:0 error:nil];
            
            NSUserDefaults* userdefaults = [NSUserDefaults standardUserDefaults];
            [userdefaults setValue:dic[@"country_id"] forKey:@"bela_contry"];
            [userdefaults setValue:dic[@"region"] forKey:@"bela_region"];
            [userdefaults setValue:dic[@"city"] forKey:@"bela_city"];
            
            [userdefaults synchronize];
        }
    });
   NSLocale * locale =[NSLocale currentLocale];
    NSProcessInfo * info = [NSProcessInfo processInfo];
    NSString *osver=  [NSString stringWithFormat:@"%ld.%ld", (long)info.operatingSystemVersion.majorVersion, (long)info.operatingSystemVersion.minorVersion];
    [self timea];
//    [self timeDate];
//    NSLog(@"%@",[NSTimeZone localTimeZone]);//当前所在时区
//    [self time];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
