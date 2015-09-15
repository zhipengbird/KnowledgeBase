//
//  ViewController.m
//  NSRuntimeStudy
//
//  Created by shareit on 15/9/14.
//  Copyright (c) 2015年 shareit. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "MYObject.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    [self getClass];
    //    [self getInstanceSize];
    //    [self getmemberInstance];
    [self getMethod];
    
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
    
    Class class=[MYObject class];
    //    获取变量列表
    Ivar * vars=class_copyIvarList(class, &count);
    
    for (int i=0;i<count; i++) {
        Ivar var=vars[i];
        const char * name = ivar_getName(var);
        const char * type = ivar_getTypeEncoding(var);
        ptrdiff_t offset= ivar_getOffset(var);
        printf("name = %s \t \n",name);
        printf("name = %s \t type = %s \t offset = %td\n\n",name,type,offset);
    }
    
    //    通过具体的名字来获取实例变量和类变量
    Ivar instancevar  =  class_getInstanceVariable(class, "sex");
    const char *name=ivar_getName(instancevar);
    Ivar classVar     =  class_getClassVariable(class, "hello");
    name=ivar_getName(classVar);
    
    //获取属性列表
    unsigned int propertyCount=0;
    objc_property_t * propertyArray = class_copyPropertyList(class, &propertyCount);
    
    for (int i=0; i<propertyCount; i++) {
        
        
        objc_property_t  property=propertyArray[i];
        //        1.属性名字
        const char * propertyName        = property_getName(property);
        //        2.属性的属性
        const char * propertyAttributes  = property_getAttributes(property);
        
        
        printf("Propertyname:%s \t propertyAttributes:%s\n",propertyName,propertyAttributes);
        unsigned int propertyAttributeCount;
        objc_property_attribute_t * propertyAttributeArray=    property_copyAttributeList(property, &propertyAttributeCount);
        //        objc_property_attribute_t是一个结构体，具体成员变量如下定义
        //        typedef struct {
        //            const char *name;           /**< The name of the attribute */
        //            const char *value;          /**< The value of the attribute (usually empty) */
        //        } objc_property_attribute_t;
        
        for (int i=0; i<propertyAttributeCount; i++) {
            
            objc_property_attribute_t  attribute=propertyAttributeArray[i];
            const char *  attributeName=attribute.name;
            const  char * attributeValue=attribute.value;
            printf("Name:%s \t Value:%s\n",attributeName,attributeValue);
            
        }
        printf("\n");
        
    }
    free(propertyArray);
#if 0
    //    在知道属性名字的情况下可以通过如下方法获取属性
    objc_property_t property = class_getProperty(class, "leftCapWidth");
    //        1.属性名字
    const char * propertyName        = property_getName(property);
    //        2.属性的属性
    const char * propertyAttributes  = property_getAttributes(property);
    printf("Propertyname:%s \t propertyAttributes:%s\n",propertyName,propertyAttributes);
#endif
    
    
    
}
-(void)getMethod
{
    
    Class class=[MYObject class];
    unsigned int methodcount;
    //    获取实例方法列表
    Method * methodArray=   class_copyMethodList(class, &methodcount);
    //    获取类方法列表
    //    methodArray =class_copyMethodList(object_getClass(class), &methodcount);
    for (int i=0; i<methodcount; i++) {
        Method method=methodArray[i];
        //        获取方法的描述
        struct objc_method_description description =  *method_getDescription(method);
        //        struct objc_method_description {
        //            SEL name;               /**< The name of the method */
        //            char *types;            /**< The types of the method arguments */
        //        };
        SEL    name   = description.name;
        char * types  = description.types;
        //        printf("SELName:%s \t types:%s\n",NSStringFromSelector(name).UTF8String,types);
        
        //        获取方法返回值类型
        char * returnType   = method_copyReturnType(method);
        
        //        获取方法返回值类型
        char returnType1[10];
        method_getReturnType(method, returnType1, sizeof(returnType1));
        printf("returnType:%s\n",returnType1);
        
        //        获取方法地址指针
        IMP    imp          = method_getImplementation(method);
        //        获取方法选择器
        SEL     sel         = method_getName(method);
        //        获取参数的个数
        unsigned int argumentcount = method_getNumberOfArguments(method);
        
        //        获取类型编码
        const char * typeEcoding  =  method_getTypeEncoding(method);
        
        printf("MehtodName:%s\nReturnType:%s\ntypeEcoding:%s\nargumentcount:%d\n",NSStringFromSelector(sel).UTF8String,returnType,typeEcoding,argumentcount);
        free(returnType);
        //        获取参数列表中每个参数的类型
        for (int i=0; i<argumentcount; i++) {
            char argumentType[10];
            method_getArgumentType(method, i, argumentType, sizeof(argumentType));
            printf("argument[%d] type ==%s\t",i,argumentType);
        }
        printf("\n\n\n");
        
    }
    free(methodArray);
 int version=   class_getVersion(class);
    if (!version) {
        class_setVersion(class, 2);
    }
    version=   class_getVersion(class);
    
    
    
    
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
