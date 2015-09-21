//
//  ViewController.m
//  NSRuntimeStudy
//
//  Created by shareit on 15/9/14.
//  Copyright (c) 2015年 shareit. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#include <objc/message.h>
#import "MYObject.h"



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    [self getClass];
    //    [self getInstanceSize];
    //        [self getmemberInstance];
    //    [self getMethod];
    
    
    //    获取函数指针
    //    IMP method=class_getMethodImplementation([self class], @selector(getProtocalList));
    //将指针转成函数并调用
    //    ((id(*)(id,SEL))method)(self,@selector(getProtocalList));
    
    //    [self performMethod];
    
 
    [self replaceMethod];

    
    //    NSLog(@"%d", a);
    
    //    [self getProtocalList];
    
    
    //    [self getAndModifyIvar];
//    [self getAndAddAndReplaceProperty];
    
    // Do any additional setup after loading the view, typically from a nib.
    
}
#pragma mark 获取、添加、替换属性
-(void)getAndAddAndReplaceProperty
{
    //    class_getProperty(<#Class cls#>, <#const char *name#>)
    //    class_copyPropertyList(<#Class cls#>, <#unsigned int *outCount#>)
    //    class_addProperty(<#Class cls#>, <#const char *name#>, <#const objc_property_attribute_t *attributes#>, <#unsigned int attributeCount#>)
    //    class_replaceProperty(<#Class cls#>, <#const char *name#>, <#const objc_property_attribute_t *attributes#>, <#unsigned int attributeCount#>)
    
    Class myclass=[MYObject class];
    const char *propertyName ="myName";
    objc_property_attribute_t attributes[]={{"T","\"NSString\""},{"C",""},{"N",""},{"V","_myName"}};
    class_replaceProperty(myclass, propertyName, attributes, 4);
    class_addProperty(myclass, propertyName, attributes, 4);//为类添加一个成员属性 但没有生成setter&&getter方法
    
    //    生成setter和getter方法
    //    1.先获取实例变量的偏移量
    ptrdiff_t offset_str= ivar_getOffset(class_getInstanceVariable(myclass, propertyName));
    //    2.获取getter新的函数指针IMP
    IMP getter_imp    =  imp_implementationWithBlock( ^(id SELF ){
        
        NSString ** pstr=(NSString **)((void*)SELF+offset_str);
        return pstr[0];
        
    });
//    2.获取s etter新的函数指针IMP
    IMP setter_imp=  imp_implementationWithBlock(^(id SELF,NSString *str){
        
        NSString **pstr=(NSString **)((void*)SELF+offset_str);
        pstr[0]=[str copy];
    });
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"//忽略方法未定义警告
    
class_addMethod(myclass, sel_registerName("setMyName:"), setter_imp, "v@:@");
class_addMethod(myclass,sel_registerName("myName"), getter_imp, "@@:");
 

    //    一个属性已经完全添加到我们的类里面了
    
    
    [self getMethod:myclass];
    MYObject * obj=  [[MYObject alloc]init];
    
    objc_msgSend(obj, sel_registerName("setMyName:"),@"yuanpinghua");
    objc_msgSend(obj, sel_registerName("myName"));//
    //   NSString * myname=
    //    NSLog(@"%@",myname);
#pragma clang diagnostic pop

}
-(void)getAndModifyIvar:(const char*)varName
{
    //    获取对象类型的成员变量
    MYObject *my    =   [[MYObject alloc]init];
    //    获取变量
    Ivar var        =   class_getInstanceVariable([MYObject class], varName);
    //    获取变量的值
    NSString * myvar        =   object_getIvar(my, var);
    
    printf("%s",myvar.UTF8String);
    //    对变量设置新值
    object_setIvar(my, var, @"man");
    //    重新获取变量的新值
    myvar        =   object_getIvar(my, var);
    printf("%s",myvar.UTF8String);
    
    
    //    获取基本数据类型的成员变量，需要进行类型转换，使用NSNumber或NSValue进行包装得到的效果是不一样的
    var         = class_getInstanceVariable([my class], "weight");
    int weight= ((int(*)(id,Ivar))object_getIvar)(my, var);
    printf("weight old==%d\n",weight);
    object_setIvar(my, var,[NSNumber numberWithInt:190]);//没有正确设置值
    //     object_setIvar(my, var,id(190));//将基本数据类型强转成ID类型，在ARC环境下是不允许的，可以采用将当前类转成MRC环境下来完成当前操作
    //    ARC--->MRC 可以在Build Phases中的Compile Sources中加入编译标记-fno-objc-arc标记，
    //    MRC--->ARC 可以在Build Phases中的Compile Sources中加入编译标记-fobjc-arc标记
    weight= ((int(*)(id,Ivar))object_getIvar)(my, var);
    printf("weight new =%d\n",weight);
    
    // 获取结构体类型的成员变量，同样需要进行类型转换，但需要知道该结构体是什么；要怎么转？？？
    // 在结构体处于公开的情况下，我们可以直接用创建一个结构体对象去接收，在未公开情况下，我们可以使用ivar_getTypeEncoding获取到结构体内部有成员，并根据相关的数据，自己创建一个相同的数据结构来使用
    var =class_getInstanceVariable([my class], "sss");
    const char* type = ivar_getTypeEncoding(var);
    
    struct ttttt
    {
        int age;
        int weight;
    };
    struct ttttt aaa = ((struct ttttt(*)(id,Ivar))object_getIvar)(my, var);
    //    id structs = object_getIvar(my, var);
    
    
}

//+(void)load
//{
//    Method method=class_getInstanceMethod([self class], @selector(orignMethod));
//    //    IMP imp =class_getMethodImplementation([self class], @selector(orignMethod));
//    IMP imp= method_getImplementation(method);
//    IMP newImp= imp_implementationWithBlock(^(id target,SEL action){
////        ((id(*)(id,SEL))imp)(target,@selector(orignMethod));
//        printf("new implementionWithBlock");
//    });
//
//    imp =  method_setImplementation(method, newImp);
//}
-(void)performMethod
{
    
    // 1.通过指针调用，
    IMP imp=class_getMethodImplementation([self class], @selector(getClass));
    ((id(*)(id,SEL))imp)(self,@selector(getClass));
    //    2.使用objc_msgSend发送消息
    id result =  objc_msgSend(self,@selector(getProtocalList));
    //    3.使用performSelector执行方法
    [self performSelector:@selector(getClass)];
    //    Method m = class_getInstanceMethod([self class], @selector(getClass));
    //    method_invoke((void*)self,m);
}

-(void)replaceMethod
{
    
    Method method=class_getInstanceMethod([self class], @selector(helloword));
    //    IMP imp =class_getMethodImplementation([self class], @selector(orignMethod));
    IMP imp= method_getImplementation(method);
    //    设置新的函数体指针
    IMP newImp= imp_implementationWithBlock(^(id SELF){
        
        printf("new implementionWithBlock\n");
        ((int(*)(id,SEL))imp)(SELF ,method_getName(method));
//        objc_msgSend(SELF, sel_registerName("helloword:"));
        
        return 2000;
        //        将函数体指针指回原来的地址
        //        method_setImplementation(method, imp);
        //        //        调用原来的方法
        //        objc_msgSend(self, @selector(orignMethod));
    } );
    
     objc_msgSend(self, sel_registerName("helloword"));
//     method_setImplementation(method, newImp);
    
    Method method1 =class_getInstanceMethod([self class], sel_registerName("hi"));
    method_setImplementation(method, method_getImplementation(method1));
//    method_exchangeImplementations(method, method1);
     objc_msgSend(self, sel_registerName("helloword"));
    //    method_setImplementation(class_getInstanceMethod([self class], @selector(orignMethod)), newImp);
    //    objc_msgSend(self, @selector(orignMethod));
    
}
-(int)helloword
{
    
    printf("hello %s \n",__FUNCTION__);
    return 1;
}
-( void)hi
{
    printf("hellofdsf %s\n",__FUNCTION__);

    
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

-(void)getmemberInstance:(Class)class
{
    unsigned  int  count;
    
    //    获取变量列表
    Ivar * vars =   class_copyIvarList(class, &count);
    
    for (int i=0;i<count; i++) {
        Ivar var    =   vars[i];
        const char * name   = ivar_getName(var);
        const char * type   = ivar_getTypeEncoding(var);
        ptrdiff_t offset    = ivar_getOffset(var);
        printf("name = %s \t \n",name);
        printf("name = %s \t type = %s \t offset = %td\n\n",name,type,offset);
    }
    
    //    通过具体的名字来获取实例变量和类变量
    Ivar instancevar  =  class_getInstanceVariable(class, "sex");
    const char *name=ivar_getName(instancevar);
    //    目前只了解到能获取isa变量
    Ivar classVar     =  class_getClassVariable(class, "isa");
    name=ivar_getName(classVar);
    
    //    MYObject *myobject=[MYObject new];
    //    void * outValue;
    //    Ivar objvar = object_getInstanceVariable (myobject, "sex",&outValue );
    
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
        
        //        property_copyAttributeValue(<#objc_property_t property#>, <#const char *attributeName#>)
        unsigned int propertyAttributeCount;
        objc_property_attribute_t * propertyAttributeArray  =    property_copyAttributeList(property, &propertyAttributeCount);
        //        objc_property_attribute_t是一个结构体，具体成员变量如下定义
        //        typedef struct {
        //            const char *name;           /**< The name of the attribute */
        //            const char *value;          /**< The value of the attribute (usually empty) */
        //        } objc_property_attribute_t;
        
        for (int i=0; i<propertyAttributeCount; i++) {
            
            objc_property_attribute_t  attribute    =   propertyAttributeArray[i];
            const char *  attributeName             =   attribute.name;
            const  char * attributeValue            =   attribute.value;
            printf("Name:%s \t Value:%s\n",attributeName,attributeValue);
            
        }
        printf("\n");
        
    }
    free(propertyArray);
#if 0
    //    在知道属性名字的情况下可以通过如下方法获取属性
    objc_property_t property         = class_getProperty(class, "leftCapWidth");
    //        1.属性名字
    const char * propertyName        = property_getName(property);
    //        2.属性的属性
    const char * propertyAttributes  = property_getAttributes(property);
    printf("Propertyname:%s \t propertyAttributes:%s\n",propertyName,propertyAttributes);
#endif
    
}
#pragma mark 获取方法列表
-(void)getMethod:(Class)class
{
    
    
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
    //   获取、设置版本号
    int version=   class_getVersion(class);
    if (!version) {
        class_setVersion(class, 2);
    }
    version=   class_getVersion(class);
    
}


-(void)getProtocalList
{
    Class class=[NSObject class];
    unsigned int protocolCount;
    //    获取协议列表
    Protocol * __unsafe_unretained *protocolArray = class_copyProtocolList(class, &protocolCount);
    //    不知为何这个方法获取不到协议列表
    //    Protocol * __unsafe_unretained *protocolArray  = protocol_copyProtocolList(objc_getProtocol("\"NSObject\""), &protocolCount);
    
    for (int i=0; i<protocolCount; i++) {
        //        获取具体协议
        Protocol *protocol = protocolArray[i];
        //        获取协议的名字
        const char * name =        protocol_getName(protocol);
        printf("protocolName=%s\n",name);
        
        //        获取协议的方法
        unsigned  outcount;
        struct objc_method_description  *description = protocol_copyMethodDescriptionList(protocol, YES, YES, &outcount);
        for (int j=0; j<outcount; j++) {
            struct objc_method_description des=description[j];
            printf("name=%s \t type=%s\n",NSStringFromSelector(des.name).UTF8String,des.types);
        }
        //    获取协议属性列表
        objc_property_t * protocolproperty=   protocol_copyPropertyList(protocol, &outcount);
        for (int i=0; i<outcount; i++) {
            objc_property_t property=protocolproperty[i];
            const char * name=property_getName(property);
            const char * attributes=property_getAttributes(property);
        }
    }
    
    free(protocolArray);
    
    
    
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
