//
//  ViewController.m
//  NSOperation
//
//  Created by shareit on 15/8/4.
//  Copyright (c) 2015年 shareit. All rights reserved.
//

#import "ViewController.h"
#define ROW_COUNT 6
#define COLUMN_COUNT 3
#define ROW_HEIGHT 100
#define ROW_WIDTH ROW_HEIGHT
#define CELL_SPACING 10

@interface ViewController ()
{
    NSMutableArray *_imageViews;
    NSMutableArray *_imageNames;
}
@property(atomic) int ticket;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self layoutUI];
    
    
}

#pragma mark 界面布局
-(void)layoutUI{
    //创建多个图片控件用于显示图片
    _imageViews=[NSMutableArray array];
    for (int r=0; r<ROW_COUNT; r++) {
        for (int c=0; c<COLUMN_COUNT; c++) {
            UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(c*ROW_WIDTH+(c*CELL_SPACING), r*ROW_HEIGHT+(r*CELL_SPACING                           ), ROW_WIDTH, ROW_HEIGHT)];
            imageView.contentMode=UIViewContentModeScaleAspectFit;
            //            imageView.backgroundColor=[UIColor redColor];
            [self.view addSubview:imageView];
            [_imageViews addObject:imageView];
            
        }
    }
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame=CGRectMake(50, 500, 220, 25);
    [button setTitle:@"加载图片" forState:UIControlStateNormal];
    //添加方法
    [button addTarget:self action:@selector(loadImageWithMultiThread) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    //创建图片链接
    _imageNames=[NSMutableArray array];
    for (int i=0; i<_imageViews.count; i++) {
        [_imageNames addObject:[NSString stringWithFormat:@"http://images.cnblogs.com/cnblogs_com/kenshincui/613474/o_%i.jpg",i]];
    }
}

#pragma mark 将图片显示到界面
-(void)updateImageWithData:(NSData *)data andIndex:(int )index{
    UIImage *image=[UIImage imageWithData:data];
    UIImageView *imageView= _imageViews[index];
    imageView.image=image;
}

#pragma mark 请求图片数据
-(NSData *)requestData:(int )index{
    //对于多线程操作建议把线程操作放到@autoreleasepool中
    @autoreleasepool {
        NSURL *url=[NSURL URLWithString:_imageNames[index]];
        NSData *data=[NSData dataWithContentsOfURL:url];
        
        return data;
    }
}

#pragma mark 加载图片
-(void)loadImage:(NSNumber *)index{
    int i=[index integerValue];
    
    //请求数据
    NSData *data= [self requestData:i];
    NSLog(@"%@",[NSThread currentThread]);
    //更新UI界面,此处调用了主线程队列的方法（mainQueue是UI主线程）
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self updateImageWithData:data andIndex:i];
    }];
}

#pragma mark 多线程下载图片
-(void)loadImageWithMultiThread
{
    int count=ROW_COUNT*COLUMN_COUNT;
    
//    for (int i=0; i<count; i++) {
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            [self loadImage:[NSNumber numberWithInt:i]];
//        });
//    }
#if 0
    /**
     *  同步加载数据
     */
    dispatch_apply(count, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(size_t index) {
        [self loadImage:@(index)];
    });
#endif
    /**
     *  异步使用apply
     *
     *
     */
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       
        dispatch_apply(count, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(size_t index) {
            NSLog(@" index＝＝ %zu",index);
            [self loadImage:@(index)];
            if (index==6) {
               
            }
        });
        
//        加载完成后要做的事
        NSLog(@"加载完成后要做的事");
    });
    
//    dispatch_source_t source = dispatch_source_create(DISPATCH_SOURCE_TYPE_DATA_ADD, 0, 0, dispatch_get_main_queue());
//    dispatch_source_set_event_handler(source, ^{
//        [progressIndicator incrementBy:dispatch_source_get_data(source)];
//    });
//    dispatch_resume(source);
//    
//    dispatch_apply([array count], globalQueue, ^(size_t index) {
//        // do some work on data at index
//        dispatch_source_merge_data(source, 1);
//    });
//    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_source_t stdinSource = dispatch_source_create(DISPATCH_SOURCE_TYPE_READ,
//                                                           STDIN_FILENO,
//                                                           0,
//                                                           globalQueue);
//    dispatch_source_set_event_handler(stdinSource, ^{
//        char buf[1024];
//        int len = read(STDIN_FILENO, buf, sizeof(buf));
//        if(len > 0)
//            NSLog(@"Got data from stdin: %.*s", len, buf);
//    });
//    dispatch_resume(stdinSource);
    
//    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
//    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC, 3 * NSEC_PER_SEC);
//    dispatch_source_set_event_handler(timer, ^{
//        NSLog(@"what this");
//    });
//    dispatch_resume(timer);

    
}
-(void)loadImageWithMultiThread2{
    int count=ROW_COUNT*COLUMN_COUNT;
    //创建操作队列
    NSOperationQueue *operationQueue=[[NSOperationQueue alloc]init];
    operationQueue.maxConcurrentOperationCount=5;//设置最大并发线程数
    
    NSBlockOperation *lastBlockOperation=[NSBlockOperation blockOperationWithBlock:^{
        [self loadImage:[NSNumber numberWithInt:(count-1)]];
    }];
    //创建多个线程用于填充图片
    for (int i=0; i<count-1; ++i) {
        //方法1：创建操作块添加到队列
        //创建多线程操作
        NSBlockOperation *blockOperation=[NSBlockOperation blockOperationWithBlock:^{
            [self loadImage:[NSNumber numberWithInt:i]];
        }];
        //设置依赖操作为最后一张图片加载操作
        [blockOperation addDependency:lastBlockOperation];
        
        [operationQueue addOperation:blockOperation];
        
    }
    
    //将最后一个图片的加载操作加入线程队列
    [operationQueue addOperation:lastBlockOperation];
}
-(void)loadImageWithMultiThread1{
    int count=ROW_COUNT*COLUMN_COUNT;
    //创建操作队列
    NSOperationQueue *operationQueue=[[NSOperationQueue alloc]init];
    operationQueue.maxConcurrentOperationCount=5;//设置最大并发线程数
    //创建多个线程用于填充图片
    for (int i=0; i<count; ++i) {
        //方法1：创建操作块添加到队列
        //        //创建多线程操作
        //        NSBlockOperation *blockOperation=[NSBlockOperation blockOperationWithBlock:^{
        //            [self loadImage:[NSNumber numberWithInt:i]];
        //        }];
        //        //创建操作队列
        //
        //        [operationQueue addOperation:blockOperation];
        
        //方法2：直接使用操队列添加操作
        [operationQueue addOperationWithBlock:^{
            [self loadImage:[NSNumber numberWithInt:i]];
        }];
        
    }
}
-(void)log
{
    for (int i=0; i<1001; i++) {
        _ticket--;
        NSLog(@"----%d",_ticket);
    }
    NSLog(@"ffdgfdgsdfgsdf%d",_ticket);
}
-(void)dd
{
    _ticket=1000;
    
    //    NSInvocationOperation * operation=[[NSInvocationOperation alloc]initWithTarget:self selector:@selector(print) object:nil];
    //
    //
    //    NSInvocationOperation *operation1=[[NSInvocationOperation alloc]initWithTarget:self selector:@selector(log) object:nil];
    //
    //    NSBlockOperation *block1=[NSBlockOperation blockOperationWithBlock:^{
    //        for (int i=0; i<1001; i++) {
    //            _ticket+=2;
    //            NSLog(@"++22+%d",_ticket);
    //        }
    //
    //    }];
    //    [block1 addExecutionBlock:^{
    //
    //        for (int i=0; i<1001; i++) {
    //            _ticket-=5;
    //            NSLog(@"+-555%d",_ticket);
    //        }
    //
    //    }];
    //    NSOperationQueue *queue=[[NSOperationQueue alloc]init];
    //    [operation addDependency:operation1];
    //    [block1 addDependency:operation];
    //
    //
    //
    //    [queue addOperations:@[operation1,operation,block1] waitUntilFinished:NO];
    NSBlockOperation *block1=[NSBlockOperation blockOperationWithBlock:^{
        
        for (int i=0;i<200 ; i++) {
            NSLog(@"%d",i);
        }
        NSLog(@"block %@",[NSThread currentThread].name);
        /**
         *  此时还在主线程里执行
         */
    }];
    [block1 addExecutionBlock:^{
        for (int i=0;i<200 ; i++) {
            NSLog(@"%d",i);
        }
        NSLog(@"block1 %@",[NSThread currentThread].name);
    }];
    [block1 addExecutionBlock:^{
        for (int i=0;i<200 ; i++) {
            NSLog(@"%d",i);
        }
        NSLog(@"block2 %@",[NSThread currentThread].name);
    }];
    block1.completionBlock=^{
        NSLog(@"ok");
    };
    
    
    NSOperationQueue *queue=[NSOperationQueue mainQueue];
    [queue addOperation:block1];
    NSLog(@"main%@",[NSThread currentThread].name);
    
    

}
-(void)print
{
    for (int i=0; i<100; i++) {
        NSLog(@"%d",i);
    }
    for (int i=0; i<1001; i++) {
        _ticket++;
        NSLog(@"+++%d",_ticket);
    }
    NSLog(@"gfdsgsdfgsdfg%d",_ticket);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
