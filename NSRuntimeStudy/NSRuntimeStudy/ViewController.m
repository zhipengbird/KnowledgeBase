//
//  ViewController.m
//  NSRuntimeStudy
//
//  Created by shareit on 15/9/14.
//  Copyright (c) 2015年 shareit. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    [self getClass];
//    [self getInstanceSize];
    [self getmemberInstance];
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)getClass
{
    //    1.根据类名来创建类对象
    Class class=NSClassFromString(@"NSObject");
    //    2.根据方法名创建方法method选择器
    SEL sel =NSSelectorFromString(@"lastOject");
    //    3.根据协议名创建一个协议
    Protocol *protocol=NSProtocolFromString(@"NSObject");
    
    
    /**
     获取类的名字 class_getName 返回的是以const修饰的字符串
     */
    const  char  *classname=class_getName([NSObject class]);
    printf("%s",classname);
    
    //    获取参数类的父类，
    Class class1= class_getSuperclass([UIView class]);
    //    使用循环调用，可以找到类的根类,NSObject的根类为空
    while (class1) {
        NSLog(@"%@",class1);
        class1= class_getSuperclass(class1);
    }
    
}

-(void)getmemberInstance
{
    unsigned  int  count;
    
//    获取变量列表
    Ivar * vars=class_copyIvarList([UIView class], &count);
    
    for (int i=0;i<count-1; i++) {
        Ivar var=vars[i];
        const char * name = ivar_getName(var);
        const char * type = ivar_getTypeEncoding(var);
        ptrdiff_t offset= ivar_getOffset(var);
        printf("name = %s \t \n",name);

//        printf("name = %s \t type = %s \t offset = %td",name,type,offset);
    }
    
    
}
-(void)getInstanceSize
{
    
    //    The size in bytes of instances of the class
    size_t size =  class_getInstanceSize([UIView class]);
    NSLog(@"%zu",size);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
