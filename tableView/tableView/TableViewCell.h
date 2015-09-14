//
//  TableViewCell.h
//  tableView
//
//  Created by shareit on 15/8/4.
//  Copyright (c) 2015年 shareit. All rights reserved.
//

#import <UIKit/UIKit.h>


#import <Foundation/Foundation.h>



@interface TableViewCell : UITableViewCell


//用户名
@property(nonatomic,retain) UILabel *name;
//用户介绍
@property(nonatomic,retain) UILabel *introduction;
//用户头像
@property(nonatomic,retain) UIImageView *userImage;

//给用户介绍赋值并且实现自动换行
-(void)setIntroductionText:(NSString*)text;
//初始化cell类
-(id)initWithReuseIdentifier:(NSString*)reuseIdentifier;

@end
