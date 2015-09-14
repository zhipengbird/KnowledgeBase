//
//  ViewController.m
//  GCD
//
//  Created by shareit on 15/8/5.
//  Copyright (c) 2015年 shareit. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UIImageView *image2;

@end

@implementation ViewController


// 根据url获取UIImage
- (UIImage *)imageWithURLString:(NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    NSData *data = [NSData dataWithContentsOfURL:url];
    // 这里并没有自动释放UIImage对象
    return [[UIImage alloc] initWithData:data];
}
-(void)downloadiMage
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       
        NSString * url1 =@"http://car0.autoimg.cn/upload/spec/9579/u_20120110174805627264.jpg";
        NSString * url2 = @"http://hiphotos.baidu.com/lvpics/pic/item/3a86813d1fa41768bba16746.jpg";
        UIImage *image1 =[ self imageWithURLString:url1];
        UIImage  *image2=[self imageWithURLString:url2];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.image1.image=image1;
            self.image2.image=image2;
        });

        
        
    });
}
-(void)downloadImage2
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        dispatch_group_t group =dispatch_group_create();
        __block UIImage *image1=nil;
        __block UIImage * image2=nil;
        dispatch_group_async(group, queue, ^{
            NSString * url1 =@"http://car0.autoimg.cn/upload/spec/9579/u_20120110174805627264.jpg";
          image1 =[ self imageWithURLString:url1];

        });
        dispatch_group_async(group, queue, ^{
            NSString * url2 = @"http://hiphotos.baidu.com/lvpics/pic/item/3a86813d1fa41768bba16746.jpg";
            image2 =[ self imageWithURLString:url2];
            
        });
        dispatch_group_notify(group, dispatch_get_main_queue()  , ^{
            self.image1.image=image1;
            self.image2.image=image2;
            
        });
    });
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self downloadImage2];
    [self downloadiMage];
    NSArray *filterNames=[CIFilter filterNamesInCategory:kCICategoryBuiltIn];
    for (NSString *filterName in filterNames) {
        CIFilter *filter=[CIFilter filterWithName:filterName];
        NSLog(@"\rfilter:%@\rattributes:%@",filterName,[filter attributes]);
    }
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
