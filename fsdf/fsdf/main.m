//
//  main.m
//  Localized
//
//  Created by shareit on 15/8/14.
//  Copyright (c) 2015年 shareit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSFileObject.h"

#define qucongFilePath  @"/Users/shareit/Documents/KnowledgeBase/fsdf/newlanuage"

#define filepath @"/Users/shareit/App/anyshare/anyshare/Localizable"
#define NEWFILEPATH @"/Users/shareit/Documents/KnowledgeBase/fsdf/lanuage"
#define NEWFILEPATH1 @"/Users/shareit/Documents/KnowledgeBase/fsdf/temp"
#define searchcontentPath  @"/Users/shareit/App/anyshare/anyshare/Localizable/Base.lproj/SHAREit.storyboard"

#define localStringFile1  @"/Users/shareit/Documents/KnowledgeBase/fsdf/fsdf/LocalFilePlist.plist"
#define localStringFile  @"/Users/shareit/Documents/KnowledgeBase/fsdf/fsdf/tempPlist.plist"
#define  localString @"/Users/shareit/Documents/KnowledgeBase/fsdf/fsdf/localString.strings"
#define importKey  @"/Users/shareit/Documents/KnowledgeBase/fsdf/fsdf/importKey.plist"
#define  regularFile @"/Users/shareit/Documents/KnowledgeBase/fsdf/fsdf/regular.plist"
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
    __block  NSMutableArray *shareitArray=[NSMutableArray array];
    
    if ([filePath isEqual:NEWFILEPATH1]) {
        [array enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL *stop) {
            NSFileObject *fileObject=[[NSFileObject alloc]init];
            if ([obj hasSuffix:subfix]) {
                fileObject.FilePathnew=obj;
                fileObject.lanuage=[[obj componentsSeparatedByString:@"_"]firstObject];
                [shareitArray addObject:fileObject];
            }
            
            
        }];
        
        return shareitArray;
    }
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
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
        NSString *fileContent=[NSString stringWithContentsOfFile:[filePath stringByAppendingPathComponent:obj.filePath?obj.filePath:obj.FilePathnew] encoding:NSUTF8StringEncoding error:&error];
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
        obj.LabelKeySet=resultSet;
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
        
        [allSet unionSet:fileobj.LabelKeySet];
    }
    
    NSMutableArray *diffArray=[NSMutableArray array];
    for (int i=0; i<count; i++) {
        NSMutableSet *tempSet=[NSMutableSet setWithSet:allSet];
        NSFileObject *object=fileRegular[i];
        NSSet *set1=object.LabelKeySet;
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
        expression=[[NSRegularExpression alloc]initWithPattern: regulardic[@"lable1"] options:0 error:nil];
        result = [expression matchesInString:fileSearchcontent options:0 range:NSMakeRange(0, fileSearchcontent.length)];
        
    }
    for (NSTextCheckingResult *rest in result) {
        NSLog(@"%@",[fileSearchcontent substringWithRange:[rest rangeAtIndex:1]]);
        (*content).LabelTitle=[fileSearchcontent substringWithRange:[rest rangeAtIndex:1]];
        [*containerArray addObject:*content];
        
    }
}


void StroyBoardWriteToFile(NSMutableArray *ViewController, NSMutableArray *buttonArray, NSMutableArray *textFiledArray, NSMutableArray *lableArray) {
    NSMutableString * mutableString=[NSMutableString string];
    
    [mutableString appendString:@"<array>\n"];
    //    [mutableString appendString:@"<dict>\n"];
    NSArray *lab=@[lableArray,textFiledArray,buttonArray,ViewController];
    for (NSArray *array in lab) {
        [mutableString appendString:@"<dict>\n"];
        for (NSFileContent * labelcontent in array) {
            [mutableString appendString:@"\t<key>"];
            //                NSString *lablekey=[NSString stringWithFormat:@"%@.%@",labelcontent.LabelID,labelcontent.titleType];
            NSString *lablekey=[NSString stringWithFormat:@"%@",labelcontent.labelKey];
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
            [localStrings appendString:[NSString stringWithFormat:@"\"%@\" = ",key]];
            NSString *stringConten=dict[key];
            
            stringConten=  [ stringConten stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            NSMutableString *content=[NSMutableString stringWithString:stringConten];
            if ([content containsString:@"\n"]) {
                NSLog(@"%@",content);
                NSRange range= [content rangeOfString:@"\n"];
                [content replaceCharactersInRange:range withString:@"\\n"];
                NSLog(@"%@",content);
            }
            [ localStrings appendFormat:@"\"%@\";\n\n",content ];
        }
        [localStrings appendString:@"\n\n"];
    }
    [localStrings writeToFile:localString atomically:YES encoding:NSUTF8StringEncoding error:nil];
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
    StroyBoardWriteToFile(ViewController, buttonArray, textFiledArray, lableArray);
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
        NSSet *set1=object.LabelKeySet;
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
#if 1
        if ([filepath isEqualTo:filePath]) {
            
            NSString * string =[[NSString  alloc]initWithFormat:@"%@.lproj/Localizable.strings",object.lanuage];
            newfilePath=[filePath stringByAppendingPathComponent:string];
            
        }
#endif
        NSFileManager * manager=  [NSFileManager defaultManager ];
        //        if ([manager fileExistsAtPath:newfilePath]) {
        //            [manager removeItemAtPath:newfilePath error:nil];
        //        }
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
        
        if([filepath isEqualTo:filePath])
        {
            NSString *string=[NSString stringWithContentsOfFile:newfilePath encoding:NSUTF8StringEncoding error:nil];
            [filecontent appendString:string];
        }
        [filecontent appendString:@"\n\n"];
        for (NSFileContent *content in contentArray) {
            [filecontent appendString:[NSString stringWithFormat:@"\"%@\" = ",isNewFile? content.LabelID :(isorign?content.labelKey:globeDic[content.LabelID])] ];
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
        BOOL res = [filecontent writeToFile:newfilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
        NSLog(@"%@",res?@"Success":@"failed");
#endif
        //        3.拼接文件
        //        4.写入文件
    }
    
}
NSArray *regularKeyAndValueSet(NSArray *array ,NSString *pattern)
{
    
    NSMutableArray * regularFileArray=[NSMutableArray array];
    [array enumerateObjectsUsingBlock:^(NSFileObject *  obj, NSUInteger idx, BOOL *stop) {
        
        NSError *error=nil;
        
        NSRegularExpression * regular=[[NSRegularExpression alloc]initWithPattern:pattern options:0 error:&error];
        NSArray *res =[regular matchesInString:obj.fileContent options:NSMatchingReportCompletion range:NSMakeRange(0, obj.fileContent.length)];
        NSMutableSet * labelKeySet=[NSMutableSet set];
        NSMutableSet * labelValueSet=[NSMutableSet set];
        NSMutableArray *contentArray=[NSMutableArray array];
        for (NSTextCheckingResult *result in res) {
            
            NSRange keyrange= [result rangeAtIndex:1];
            NSString *idcontent=[obj.fileContent substringWithRange:keyrange];
            
            NSRange valuerange=[result rangeAtIndex:2];
            NSString *idTitle=[obj.fileContent substringWithRange:valuerange];
            NSFileContent *content=[[NSFileContent alloc]init];
            //id
            content.LabelID=idcontent;
            
            content.labelKey=idcontent;
            
            //title
            content.LabelTitle=idTitle;
            //            只查找故事板中有的ID
            [contentArray addObject:content];
            [labelKeySet addObject:idcontent];
            [labelValueSet addObject:idTitle];
        }
        
        obj.LabelKeySet=labelKeySet;
        obj.LabelValueSet=labelValueSet;
        obj.fileContentID=contentArray;
        obj.theValuleAndKeyLessCount=(int )(labelKeySet.count-labelValueSet.count);
        [regularFileArray addObject:obj];
    }];
    
    
    return regularFileArray;
}

void completeLessKeyValue(NSArray *array,NSArray *keyArray,NSArray * ValuesArray)
{
    
}

static NSArray* checkLanguage(NSDictionary* kvs, NSSet* toCheck) {
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    for (NSString* labelId in toCheck) {
        NSString* value = kvs[labelId];
        
        NSMutableSet* set = dic[value];
        if (set == nil) {
            set = [NSMutableSet set];
            [dic setValue:set forKey:value];
        }
        [set addObject:labelId];
    }
    
    NSMutableArray* result = [NSMutableArray array];
    for (NSSet* set in dic.allValues) {
        if (set.count > 1) {
            [result addObject:set];
        }
    }
    
    return result;
}

void replaceLabelIDINStoryBoard(void) {
    NSArray *filePathArray=getFilePathWithSubFix(@"localString.strings", @"/Users/shareit/Documents/KnowledgeBase/fsdf/fsdf/");
    NSArray *FileContentArray=getFileContent(filePathArray,@"/Users/shareit/Documents/KnowledgeBase/fsdf/fsdf/");
    NSArray *regularArray=  RegFileContent(FileContentArray,regulardic[@"origalFileRegular"]);
    NSMutableString *mutableString=[[NSMutableString alloc]initWithContentsOfFile:searchcontentPath encoding:NSUTF8StringEncoding error:nil];
    NSArray *existLabelArray=findExistLabel(mutableString, [regularArray[0] fileContentID]);
    for (int i=0;i<existLabelArray.count;i++) {
        
        
        NSFileContent *object = existLabelArray[i];
        
        //            1.找到ＩＤ所在位置
        NSString *pattern=[NSString stringWithFormat:regulardic[@"regular1"],object.LabelID];
        NSRegularExpression *expression1=[[NSRegularExpression alloc]initWithPattern:pattern options:0 error:nil];
        NSArray *result= [expression1 matchesInString:mutableString options:NSMatchingReportCompletion range:NSMakeRange(0, mutableString.length)];
        NSRange contentRange;
        NSString *suojing=nil;
        for( NSTextCheckingResult *result1 in result)
        {
            contentRange= result1.range;
            suojing=[mutableString substringWithRange:[result1 rangeAtIndex:1]];
        }
        //         2.打到属性所在位置
        NSString *patter=regulardic[@"InsertValue"];
        NSRegularExpression * expression=[[NSRegularExpression alloc]initWithPattern:patter options:0 error:nil];
        NSArray *res =  [expression matchesInString:mutableString options:NSMatchingReportCompletion range:contentRange];
        NSMutableString *insertString=[NSMutableString string];
        //            3.有属性，则插入单个属性
        if (res.count &&![object.titleType isEqualTo:@"title"]) {
            
            //                    5.判断是不是按钮的正常状态 是textN 不是textL
            //            6.已有属性，找到属性位置，插入
            for (NSTextCheckingResult *result in res) {
                
                NSRange subRange=[result rangeAtIndex:2];
                suojing= [mutableString substringWithRange:[result rangeAtIndex:1]];
                //                    NSMutableString * string=[NSMutableString stringWithString:[mutableString substringWithRange:subRange]];
                ////                    [string insertString:insertString atIndex:0];
                if ([object.titleType isEqualTo:@"normalTitle"]) {
                    
                    [insertString appendFormat:@"\n%@    <userDefinedRuntimeAttribute type=\"string\" keyPath=\"%@\" value=\"%@\"/>\n",suojing,@"textN",globeDic[object.LabelID]];
                }
                else
                {
                    [insertString appendFormat:@"\n%@    <userDefinedRuntimeAttribute type=\"string\" keyPath=\"%@\" value=\"%@\"/>\n",suojing,@"textL",globeDic[object.LabelID]];
                }
                
                [insertString appendString:[mutableString substringWithRange:subRange]];
                [mutableString replaceCharactersInRange:subRange withString:insertString];
                
            }
            
        }
        else
        {
            
            //               7. 没有属性，找到每一个>后面插入
            
            for( NSTextCheckingResult *result1 in result)
            {
                contentRange= result1.range;
                NSRange range=[result1 rangeAtIndex:4];
                //                    NSMutableString * string=[NSMutableString stringWithString:[mutableString substringWithRange:range]];
                //                    [string insertString:insertString atIndex:0];
                //                4.没有，则插入键
                if([object.titleType isEqualTo:@"normalTitle"])
                {
                    [ insertString appendFormat:@"\n%@    <userDefinedRuntimeAttributes>\n%@        <userDefinedRuntimeAttribute type=\"string\" keyPath=\"%@\" value=\"%@\"/>\n%@    </userDefinedRuntimeAttributes>\n",suojing,suojing,@"textN",globeDic[object.LabelID],suojing ];
                }
                else
                {
                    [ insertString appendFormat:@"\n%@    <userDefinedRuntimeAttributes>\n%@        <userDefinedRuntimeAttribute type=\"string\" keyPath=\"%@\" value=\"%@\"/>\n%@    </userDefinedRuntimeAttributes>\n",suojing,suojing,@"textL",globeDic[object.LabelID],suojing ];
                }
                
                [insertString appendString:[mutableString substringWithRange:range]];
                [mutableString replaceCharactersInRange:range withString:insertString];
            }
            
        }
        
    }
    
    //        8.写入文件
    BOOL res =  [mutableString writeToFile:searchcontentPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NSDictionary *dic=[NSDictionary dictionaryWithContentsOfFile:localStringFile];
        allSet=[NSMutableSet set];
        [allSet addObjectsFromArray:[dic allKeys]];
        regulardic=[NSDictionary dictionaryWithContentsOfFile:regularFile];
        globeDic=[NSDictionary dictionaryWithContentsOfFile:importKey];
#if 0
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
        //                writeAllFileContentToFile(regularArray1,YES,qucongFilePath,NO);
        //        已写入原来工程路径
        writeAllFileContentToFile(regularArray1,YES,filepath,NO);
        
#endif
#if 0
        findLableInStoryBoard(regularArray);
#endif
        

        NSArray *localizable_Filepath_Array=getFilePathWithSubFix(@"Localizable.strings", filepath);
        
        NSArray * localizabel_FileContent_Array=getFileContent(localizable_Filepath_Array, filepath);
        NSArray *localizabel_FileRegular_Array=regularKeyAndValueSet(localizabel_FileContent_Array, regulardic[@"origalFileRegular"]);
        
        //        补全文件缺少的建值
        
        NSSet* allKeys = [localizabel_FileRegular_Array[0] LabelKeySet]; //所有key
        NSMutableArray* result = [NSMutableArray array];
        
        [result addObject:allKeys];
        
        for (int i = 0; i < result.count; i++) {
            for (NSFileObject* lan in localizabel_FileRegular_Array) {
                NSArray* arr = checkLanguage(lan.kvs, result[i]);
                if (arr.count > 0) {
                    [result removeObjectAtIndex:i];
                    int index = i;
                    for (NSSet* set in arr) {
                        [result insertObject:set atIndex:index++];
                    }
                } else {
                    [result removeObjectAtIndex:i--];
                    break;
                }
            }
        }
        NSLog(@"1111");
        
#if 0
        
        NSArray *localizable_Filepath_Array=getFilePathWithSubFix(@".strings", NEWFILEPATH1);
        
        NSArray * localizabel_FileContent_Array=getFileContent(localizable_Filepath_Array, NEWFILEPATH1);
        NSArray *localizabel_FileRegular_Array=regularKeyAndValueSet(localizabel_FileContent_Array, regulardic[@"origalFileRegular"]);
        //        1.查重
        NSSet* allKeys = [localizabel_FileRegular_Array[0] LabelKeySet]; //所有key
        NSMutableArray* result = [NSMutableArray array];
        
        [result addObject:allKeys];
        
        for (int i = 0; i < result.count; i++) {
            for (NSFileObject* lan in localizabel_FileRegular_Array) {
                NSArray* arr = checkLanguage(lan.kvs, result[i]);
                if (arr.count > 0) {
                    [result removeObjectAtIndex:i];
                    int index = i;
                    for (NSSet* set in arr) {
                        [result insertObject:set atIndex:index++];
                    }
                } else {
                    [result removeObjectAtIndex:i--];
                    break;
                }
            }
        }
        
        
        //        2.去重
        NSMutableArray *removeArray=[NSMutableArray array];
        for (NSSet *set in result) {
            [set enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
                NSLog(@"%@",obj);
            }];
            //
        }
        for (NSFileObject *object in localizabel_FileRegular_Array) {
            
            NSMutableArray *contentArray=[NSMutableArray arrayWithArray:object.fileContentID];
            
            for (NSFileContent *content in contentArray) {
                
            }
            
        }
#endif
        
        /**
         *  替换故事板里的ID
         */
        replaceLabelIDINStoryBoard();

    }
    return 0;
}




