//
//  NSFileObject.h
//  Localized
//
//  Created by shareit on 15/8/14.
//  Copyright (c) 2015年 shareit. All rights reserved.
//

#import <Foundation/Foundation.h>


//typedef NS_OPTIONS(NSUInteger, LABELTYPE) {
//    label = 1 << 0,
//    textField = 1 << 1,
//    button = 1 << 2,
//    viewController=1 <<3
//};
//typedef NS_OPTIONS(NSUInteger, TITLETYPE) {
//    title = 1 << 0,
//    normalTitle = 1 << 1,
//    placeholder = 1 << 2,
//    text=1<<3
//};
@interface NSFileContent : NSObject
@property(nonatomic,copy)NSString *LabelID;
@property(nonatomic,copy)NSString *labelKey;
@property(nonatomic,copy)NSString *LabelTitle;
@property(nonatomic)NSRange localrange;
@property(nonatomic,copy)NSString * labelType;
@property(nonatomic,copy)NSString *  titleType;
@property(nonatomic,copy)NSString *searchContent;

@end

@interface NSFileObject : NSObject
@property(nonatomic,copy)NSString *filePath;
@property(nonatomic,copy)NSString *FilePathnew;
@property(nonatomic,copy)NSString *fileContent;
@property(nonatomic,strong)NSSet * LabelKeySet;
@property(nonatomic,strong)NSSet * LabelValueSet;
@property(nonatomic,strong)NSSet * lessSet;
@property(nonatomic,strong)NSArray * fileContentID;
@property(nonatomic,copy)NSString *lanuage;
@property(nonatomic)int theValuleAndKeyLessCount;
@property(nonatomic,readonly) NSDictionary* kvs;
@end
