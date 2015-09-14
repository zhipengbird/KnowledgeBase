//
//  main.m
//  Localized
//
//  Created by shareit on 15/8/14.
//  Copyright (c) 2015年 shareit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSFileObject.h"

#define qucongFilePath  @"/Users/shareit/Documents/KnowledgeBase/Localized/newlanuage"
#define filepath @"/Users/shareit/App/anyshare/anyshare/Localizable"
#define NEWFILEPATH @"/Users/shareit/Documents/KnowledgeBase/Localized/lanuage"
#define NEWFILEPATH1 @"/Users/shareit/Documents/KnowledgeBase/Localized/temp"
#define searchcontentPath  @"/Users/shareit/App/anyshare/anyshare/Localizable/Base.lproj/SHAREit.storyboard"

#define localStringFile1  @"/Users/shareit/Documents/KnowledgeBase/Localized/LocalFilePlist.plist"
#define localStringFile  @"/Users/shareit/Documents/KnowledgeBase/Localized/tempPlist.plist"
#define  localString @"/Users/shareit/Documents/KnowledgeBase/Localized/localString.strings"


static NSDictionary *regulardic;
static NSDictionary *globeDic;
static NSMutableSet *allSet;
/**
 *  获取文件路径
 *
 *  @param subfix   文件名后缀
 *  @param filePath 文件路径
 *
 *  @return 文件数组
 */
NSArray *getFilePathWithSubFix(NSString *subfix ,NSString *filePath)
{
    NSFileManager  *fileManager=[NSFileManager defaultManager];
    NSError *error=nil;
    NSArray * array= [fileManager subpathsOfDirectoryAtPath:filePath error:&error];
    NSMutableArray *shareitArray=[NSMutableArray array];
    
    if ([filePath isEqual:NEWFILEPATH]) {
        [array enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL *stop) {
            NSFileObject *fileObject=[[NSFileObject alloc]init];
            if ([obj hasSuffix:subfix]) {
                fileObject.filePath=obj;
                fileObject.lanuage=[[obj componentsSeparatedByString:@"_"]firstObject];
                [shareitArray addObject:fileObject];
            }
           
            
        }];
        
        return shareitArray;
    }
    [array enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        NSFileObject *fileObject=[[NSFileObject alloc]init];
        if ([obj hasSuffix:subfix]) {
            fileObject.filePath=obj;
            fileObject.lanuage=[[obj componentsSeparatedByString:@"."]firstObject];
            [shareitArray addObject:fileObject];
        }
    }];
    return shareitArray;
}
/**
 *  通过文件路径数组获取文件内容
 *
 *  @param filepathArray 文件路径数组
 *
 *  @return 文件内容数组
 */
NSArray *getFileContent(NSArray *filepathArray,NSString *filePath)
{
    NSMutableArray *contentArray=[NSMutableArray array];
    [filepathArray enumerateObjectsUsingBlock:^(NSFileObject* obj, NSUInteger idx, BOOL *stop) {
        NSError *error=nil;
        NSString *fileContent=[NSString stringWithContentsOfFile:[filePath stringByAppendingPathComponent:obj.filePath] encoding:NSUTF8StringEncoding error:&error];
        if (fileContent) {
            obj.fileContent=fileContent;
            [contentArray addObject:obj];
        }
        
    }];
    return contentArray;
}


/**
 *  从文件内容中取出所需要的字段，ID ,type ,title
 *
 *  @param fileContentArray 文件内容数组
 *
 *  @return 结果集
 */
NSArray  *RegFileContent(NSArray *fileContentArray,NSString *pattern)
{
    
    //    @"\\\"(.*[^\\\\])\\\"\\s?=\\s?\\\"(.*[^\\\\])\\\"\\s?;"
    NSMutableArray *regFileArray=[NSMutableArray array];
    [fileContentArray enumerateObjectsUsingBlock:^(NSFileObject* obj, NSUInteger idx, BOOL *stop) {
        
        NSError* err = nil;
        NSRegularExpression * regular=[[NSRegularExpression alloc]initWithPattern: pattern options:0 error:&err];
        NSArray *res = [regular matchesInString:obj.fileContent options:NSMatchingReportCompletion range:NSMakeRange(0, obj.fileContent.length)];
        
        NSMutableSet * resultSet=[NSMutableSet set];
        NSMutableArray *contentArray=[NSMutableArray array];
        NSMutableSet *titleKind=[NSMutableSet set];
        NSMutableSet * newAllSet=[NSMutableSet setWithArray:[globeDic allValues]];
        NSMutableSet * containerSet=[NSMutableSet set];
        if ([pattern isEqualToString:regulardic[@"newFileRegular"]]) {
            for (NSTextCheckingResult *result in res) {
                
                NSRange keyrange= [result rangeAtIndex:1];
                NSString *idcontent=[obj.fileContent substringWithRange:keyrange];
                
                NSRange valuerange=[result rangeAtIndex:2];
                NSString *idTitle=[obj.fileContent substringWithRange:valuerange];
                NSFileContent *content=[[NSFileContent alloc]init];
                //id
                content.LabelID=idcontent;
                content.labelKey=idcontent;
                content.LabelTitle=idTitle;
                // 只查找故事板中有的ID
                if ([newAllSet containsObject:content.LabelID]) {
                    
//                     去重
                    if (! [containerSet containsObject:idcontent]) {
                        [containerSet addObject:idcontent];
                        [contentArray addObject:content];
                        [resultSet addObject:idcontent];
                    }
                   
                }
                
            }
        }
        else
        {
            for (NSTextCheckingResult *result in res) {
                
                NSRange keyrange= [result rangeAtIndex:1];
                NSString *idcontent=[obj.fileContent substringWithRange:keyrange];
                
                NSRange valuerange=[result rangeAtIndex:2];
                NSString *idTitle=[obj.fileContent substringWithRange:valuerange];
                NSFileContent *content=[[NSFileContent alloc]init];
                //id
                content.LabelID=[[idcontent componentsSeparatedByString:@"."]firstObject];
                content.labelKey=idcontent;
                [titleKind addObject:[[idcontent componentsSeparatedByString:@"."]lastObject]];
                //type
                NSString *titleType=[[idcontent componentsSeparatedByString:@"."]lastObject];
                content.titleType=titleType;
                //title
                
                content.LabelTitle=idTitle;
                //            只查找故事板中有的ID
                if ([allSet containsObject:content.LabelID]) {
                    
                    [contentArray addObject:content];
                    [resultSet addObject:idcontent];
                }
                
            }
        }
        //        NSLog(@"resultSet.count%ld",resultSet.count);
        obj.allSet=resultSet;
        obj.fileContentID=contentArray;
        [regFileArray addObject:obj];
        
        NSLog(@"%@",titleKind);
    }];
    
    
    
    //([ \t]+)\<(\w+)?\s+(.+)\sid=\"aHU-Hf-7IX\".*>[\s\S]*?\n\1</\2>
    //    ([ \t]+)\<(\w+)?(.*\sid=\"Uu9-6G-3Cx\".*)>[\s\S]*?\n\1</\2>
    return regFileArray;
}
/**
 * 找出文件与其他文件缺少的字段
 *
 *  @param fileRegular 正则匹配后的结果集
 *
 *  @return 结果集
 */
NSArray * differentInFile(NSArray * fileRegular)
{
    
    long count =fileRegular.count;
    NSMutableSet *allSet=[NSMutableSet set];
    for (NSFileObject *fileobj in fileRegular) {
        
        [allSet unionSet:fileobj.allSet];
    }
    
    NSMutableArray *diffArray=[NSMutableArray array];
    for (int i=0; i<count; i++) {
        NSMutableSet *tempSet=[NSMutableSet setWithSet:allSet];
        NSFileObject *object=fileRegular[i];
        NSSet *set1=object.allSet;
        [tempSet minusSet:set1];
        object.lessSet=tempSet;
        [diffArray addObject:object];
    }
    
    return diffArray;
}

/**
 *  查找到故事板中真正存在的字段
 *
 *  @param searchcontent 查找的内容
 *  @param lableIDArray  标签数组
 *
 *  @return 结果集
 */
NSMutableArray * findExistLabel(NSString *searchcontent, NSArray *lableIDArray) {
    NSMutableArray *existcontent=[NSMutableArray array];
    for ( NSFileContent * filecontent in lableIDArray) {
        NSLog(@"%@",[NSString stringWithFormat:@"id=\"%@\"",filecontent.LabelID]);
        NSRange range=   [searchcontent rangeOfString:[NSString stringWithFormat:@"id=\"%@\"",filecontent.LabelID] options:0 range:NSMakeRange(0,searchcontent.length)];
        if(range.location!=NSNotFound && range.length>0)
        {
            NSRange range1=   [searchcontent rangeOfString:[NSString stringWithFormat:@"id=\"%@\"",filecontent.LabelID] options:0 range:NSMakeRange(range.location+range.length,searchcontent.length-range.location-range.length)];
            
            if (range1.location!=NSNotFound && range1.length>0) {
                NSLog(@"two");
            }
            filecontent.localrange=range;
            [existcontent addObject:filecontent];
        }
    }
    return existcontent;
}
/**
 *  查找对应标签所在故事中的位置
 *
 *  @param searchcontent   故事板内容
 *  @param kindslabel_p    集合
 *  @param regularArraya_p 存储的数组
 *  @param existcontent    <#existcontent description#>
 */
void findFiledContent(NSString *searchcontent, NSMutableSet **kindslabel_p, NSMutableArray **regularArraya_p, NSMutableArray *existcontent) {
    NSDictionary *dic=[NSDictionary dictionaryWithContentsOfFile:@"/Users/shareit/Documents/KnowledgeBase/Localized/regular.plist"];
    *regularArraya_p=[NSMutableArray array];
    *kindslabel_p=[NSMutableSet set];
    NSMutableSet * set=[NSMutableSet set];
    for (__strong NSFileContent  * content in existcontent) {
        NSString *pattherString=[NSString stringWithFormat:dic[@"regular"],content.LabelID];
        NSRegularExpression *expression=[[NSRegularExpression alloc]initWithPattern:pattherString options:0 error:nil];;
        NSArray  *resultArray=  [expression matchesInString:searchcontent options:0 range:NSMakeRange(0, searchcontent.length)];
        
        for (NSTextCheckingResult *result in resultArray) {
            
            [*regularArraya_p addObject:[searchcontent substringWithRange:[result rangeAtIndex:2]]];
            [*kindslabel_p addObject:[searchcontent substringWithRange:[result rangeAtIndex:2]]];
            //            NSLog(@"%@ : %@",[searchcontent substringWithRange:[result rangeAtIndex:2]],content.LabelID);
            NSString *labletype=[searchcontent substringWithRange:[result rangeAtIndex:2]];
            content.labelType=labletype;
            NSLog(@"%@:%@",content.labelType,content.titleType);
            [set addObject:[NSString stringWithFormat:@"%@:%@",content.labelType,content.titleType]];
            content.localrange=result.range;
            //            NSLog(@"%@",[searchcontent substringWithRange:[result rangeAtIndex:3]]);
        }
    }
    NSLog(@"%@",set);
}
/**
 *  在storyboard里查找对应ＩＤ的标签段落，并找出标签的值
 *
 *  @param content        对应标签对象
 *  @param containerArray 保存标签的数组
 *  @param patternString  正则表达式
 *  @param searchContent  要找的内容文件
 */
void findLabelText(NSFileContent **content,NSMutableArray **containerArray,NSString * patternString ,NSString *searchContent)
{
    
    NSRegularExpression * expression=[[NSRegularExpression alloc]initWithPattern:patternString options:0 error:nil];
    NSString * fileSearchcontent= [searchContent substringWithRange:(*content).localrange];
    NSArray *result = [expression matchesInString:fileSearchcontent options:0 range:NSMakeRange(0, fileSearchcontent.length)];
    if(!result.count)
        
    {
        
        NSDictionary *dic=[NSDictionary dictionaryWithContentsOfFile:@"/Users/shareit/Documents/KnowledgeBase/Localized/regular.plist"];
        
        expression=[[NSRegularExpression alloc]initWithPattern: dic[@"lable1"] options:0 error:nil];
        result = [expression matchesInString:fileSearchcontent options:0 range:NSMakeRange(0, fileSearchcontent.length)];
        
    }
    for (NSTextCheckingResult *rest in result) {
        NSLog(@"%@",[fileSearchcontent substringWithRange:[rest rangeAtIndex:1]]);
        (*content).LabelTitle=[fileSearchcontent substringWithRange:[rest rangeAtIndex:1]];
        [*containerArray addObject:*content];
        
    }
}


void findLableInStoryBoard(NSArray *regularArray) {
    NSArray * lableIDArray=[regularArray[0] fileContentID];
    NSString *searchcontent=[NSString stringWithContentsOfFile:searchcontentPath encoding:NSUTF8StringEncoding error:nil];
    NSMutableArray *existcontent;
    existcontent = findExistLabel(searchcontent, lableIDArray);
    
    //        NSLog(@"%@",existcontent);
    
    
    NSMutableArray *regularArraya;
    NSMutableSet *kindslabel;
    findFiledContent(searchcontent, &kindslabel, &regularArraya, existcontent);
    //        NSLog(@"count=%ld",regularArraya.count);
    //        NSLog(@"kind lable=%@", kindslabel);
 
    
    NSMutableArray *lableArray      = [NSMutableArray array];
    NSMutableArray * textFiledArray = [NSMutableArray array];
    NSMutableArray *buttonArray     = [NSMutableArray array];
    NSMutableArray * ViewController = [NSMutableArray array];
    for ( __strong NSFileContent *content in existcontent) {
        
        if ([content.labelType isEqualToString:@"label"]) {
            
            NSString *regular=regulardic[@"label"];
            findLabelText(&content, &lableArray, regular, searchcontent);
        }
        
        
        else if ([content.labelType isEqualToString:@"textField"])
        {
            NSString *regular=regulardic[@"textfiled"];
            
            findLabelText(&content, &textFiledArray, regular, searchcontent);
        }
        
        else  if ([content.labelType isEqualToString:@"button"])
        {
            NSString *regular=regulardic[@"button"];
            findLabelText(&content, &buttonArray, regular, searchcontent);
        }
        else if([content.labelType isEqualToString:@"viewController"])
        {
            NSString *regular=regulardic[@"viewController"];
            findLabelText(&content, &ViewController, regular, searchcontent);
        }
    }
    NSLog(@"%@,%@,%@,%@",lableArray,textFiledArray,buttonArray,ViewController);
    NSMutableString * mutableString=[NSMutableString string];
    
            [mutableString appendString:@"<array>\n"];
//    [mutableString appendString:@"<dict>\n"];
    NSArray *lab=@[lableArray,textFiledArray,buttonArray,ViewController];
    for (NSArray *array in lab) {
                    [mutableString appendString:@"<dict>\n"];
        for (NSFileContent * labelcontent in array) {
            [mutableString appendString:@"\t<key>"];
            //                NSString *lablekey=[NSString stringWithFormat:@"%@.%@",labelcontent.LabelID,labelcontent.titleType];
            NSString *lablekey=[NSString stringWithFormat:@"%@",labelcontent.LabelID];
            [mutableString appendString:lablekey];
            [mutableString appendString:@"</key>\n"];
            [mutableString appendString:@"<string>"];
            NSString * labelTitle=[NSString stringWithFormat:@"%@",labelcontent.LabelTitle];
            [mutableString appendString:labelTitle];
            [mutableString appendString:@"</string>\n"];
            
        }
                    [mutableString appendString:@"</dict>\n"];
        
    }
            [mutableString appendString:@"</array>\n"];
//    [mutableString appendString:@"</dict>\n"];
    [mutableString writeToFile:localStringFile1 atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    
    NSArray *contentArray=[[NSArray alloc]initWithContentsOfFile:localStringFile1];
    NSMutableString * localStrings=[NSMutableString string];
    for (NSDictionary *dict in contentArray) {
        [localStrings appendString:@"\n\n"];
        for (NSString *key in [dict allKeys]) {
            [localStrings appendString:[NSString stringWithFormat:@"\"%@\"=",key]];
            NSString *stringConten=dict[key];
           
          stringConten=  [ stringConten stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
             NSMutableString *content=[NSMutableString stringWithString:stringConten];
            if ([content containsString:@"\n"]) {
                NSLog(@"%@",content);
                NSRange range= [content rangeOfString:@"\n"];
                [content replaceCharactersInRange:range withString:@"\\n"];
                NSLog(@"%@",content);
            }
            [ localStrings appendFormat:@"\"%@\";\n",content ];
        }
        [localStrings appendString:@"\n\n"];
    }
    [localStrings writeToFile:localString atomically:YES encoding:NSUTF8StringEncoding error:nil];
}


/**
 * 找出文件中多余的字段
 *
 *  @param fileRegular 正则匹配后的结果集
 *
 *  @return 结果集
 */
NSArray * differentMoreFile1(NSArray * fileRegular )
{
    
    long count =fileRegular.count;
    
    
    NSMutableArray *diffArray=[NSMutableArray array];
    for (int i=0; i<count; i++) {
        
        NSFileObject *object=fileRegular[i];
        NSSet *set1=object.allSet;
        NSMutableSet *tempSet=[NSMutableSet setWithSet:set1];
        [tempSet minusSet:allSet];
        object.lessSet=tempSet;
        [diffArray addObject:object];
    }
    
    return diffArray;
}

void writeAllFileContentToFile(NSArray * array,BOOL isNewFile,NSString *filePath, BOOL isorign)
{
    for (NSFileObject *object in array) {
        //        1.创建一个文件路径
        NSString *newfilePath=[filePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_%@",object.lanuage,@"localString.strings"]];
        NSFileManager * manager=  [NSFileManager defaultManager ];
        if ([manager fileExistsAtPath:newfilePath]) {
            [manager removeItemAtPath:newfilePath error:nil];
        }
#if 1
        if (!  [manager fileExistsAtPath:newfilePath]) {
            [manager createFileAtPath:newfilePath contents:nil attributes:nil];
        }
        //        2.对所有ＩＤ  进行排序
        NSMutableArray *contentArray=[NSMutableArray arrayWithArray:object.fileContentID];
        int  count=(int)contentArray.count;
        for (int i= count-1; i>=0; i--) {
            for (int j=1; j<i; j++) {
                NSFileContent *content1=contentArray[j];
                NSFileContent *content2=contentArray[j-1];
                if ([content1.LabelID compare:content2.LabelID]==NSOrderedDescending) {
                    [contentArray exchangeObjectAtIndex:j-1 withObjectAtIndex:j];
                }
            }
        }
        
        //        2.查找所有内容
        NSMutableString * filecontent=[NSMutableString string];
        [filecontent appendString:@"\n\n"];
        for (NSFileContent *content in contentArray) {
            [filecontent appendString:[NSString stringWithFormat:@"\"%@\"=",isNewFile? content.LabelID :(isorign?content.labelKey:globeDic[content.LabelID])] ];
            NSMutableString *contents=[NSMutableString stringWithString:content.LabelTitle ];
            if ([contents containsString:@"\n"]) {
                NSLog(@"%@",contents);
                NSRange range= [contents rangeOfString:@"\n"];
                [contents replaceCharactersInRange:range withString:@"\\n"];
                NSLog(@"%@",contents);
            }
            [ filecontent appendFormat:@"\"%@\";\n",contents ];
        }
        [filecontent appendString:@"\n\n"];
        [filecontent writeToFile:newfilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
#endif
        //        3.拼接文件
        //        4.写入文件
    }
    
}
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NSDictionary *dic=[NSDictionary dictionaryWithContentsOfFile:localStringFile];
        allSet=[NSMutableSet set];
        [allSet addObjectsFromArray:[dic allKeys]];
        regulardic=[NSDictionary dictionaryWithContentsOfFile:@"/Users/shareit/Documents/KnowledgeBase/Localized/regular.plist"];
        globeDic=[NSDictionary dictionaryWithContentsOfFile:@"/Users/shareit/Documents/KnowledgeBase/Localized/importKey.plist"];
        
        /*** 对初始文件进行读取，重写***/
        NSArray *filePathArray=getFilePathWithSubFix(@"SHAREit.strings", filepath);
        NSArray *FileContentArray=getFileContent(filePathArray,filepath);
        NSArray *regularArray=  RegFileContent(FileContentArray,regulardic[@"origalFileRegular"]);
        

        writeAllFileContentToFile(regularArray,NO,NEWFILEPATH,YES);
        writeAllFileContentToFile(regularArray,NO,NEWFILEPATH1,NO);
        //        NSArray *difArray= differentInFile(regularArray);
        //       将所有内容写入对应的文件
        
        NSArray *filePathArray1=getFilePathWithSubFix(@".strings", NEWFILEPATH1);
        NSArray *FileContentArray1=getFileContent(filePathArray1,NEWFILEPATH1);
        NSArray *regularArray1=  RegFileContent(FileContentArray1,regulardic[@"newFileRegular"]);
        writeAllFileContentToFile(regularArray1,YES,qucongFilePath,NO);

#if 0
        findLableInStoryBoard(regularArray);
#endif
    }
    return 0;
}



