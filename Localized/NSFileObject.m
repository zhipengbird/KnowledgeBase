//
//  NSFileObject.m
//  Localized
//
//  Created by shareit on 15/8/14.
//  Copyright (c) 2015年 shareit. All rights reserved.
//

#import "NSFileObject.h"

@implementation NSFileObject
-(NSString *)description
{
    return [NSString stringWithFormat:@"filePath=%@\nlessSet=%@\n filedid=%@",self.filePath,self.lessSet,self.fileContentID];
}


@end

@implementation NSFileContent

-(NSString *)description
{
//    return [NSString stringWithFormat:@"%@,%@",self.LabelID,NSStringFromRange(self.localrange)];
    return [NSString stringWithFormat:@"id=%@, labeltype=%@,,titletype=%@,title=%@",self.LabelID,self.labelType,self.titleType ,self.LabelTitle];
}

@end