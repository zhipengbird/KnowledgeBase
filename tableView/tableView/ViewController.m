//
//  ViewController.m
//  tableView
//
//  Created by shareit on 15/8/4.
//  Copyright (c) 2015年 shareit. All rights reserved.
//

#import "ViewController.h"


#import "TableViewCell.h"
@interface UserModel : NSObject

//用户名
@property (nonatomic,copy) NSString *username;
//介绍
@property (nonatomic,copy) NSString *introduction;
//头像图片路径
@property (nonatomic,copy) NSString *imagePath;

@end


@implementation UserModel



@end

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray *tabledata;
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation ViewController


-(void)createUserData{
    UserModel *user = [[UserModel alloc] init];
    [user setUsername:@"胖虎"];
    [user setIntroduction:@"我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!"];
    [user setImagePath:@"panghu.jpg"];
    UserModel *user5 = [[UserModel alloc] init];
    [user setUsername:@"胖虎"];
    [user setIntroduction:@"我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!"];
    [user5 setImagePath:@"panghu.jpg"];
    UserModel *user6 = [[UserModel alloc] init];
    [user6 setUsername:@"胖虎"];
    [user6 setIntroduction:@"我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!"];
    [user setImagePath:@"panghu.jpg"];
    UserModel *user7 = [[UserModel alloc] init]; [user7 setUsername:@"胖虎"];
    [user7 setIntroduction:@"我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!"];
    [user7 setImagePath:@"panghu.jpg"];
    UserModel *user8 = [[UserModel alloc] init]; [user8 setUsername:@"胖虎"];
    [user8 setIntroduction:@"我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!"];
    [user8 setImagePath:@"panghu.jpg"];
    UserModel *user2 = [[UserModel alloc] init];
    [user2 setUsername:@"多啦A梦"];
    [user2 setIntroduction:@"我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦"];
    [user2 setImagePath:@"duolaameng.jpg"];
    UserModel *user3 = [[UserModel alloc] init];
    [user3 setUsername:@"大雄"];
    [user3 setIntroduction:@"我是大雄我谁都怕，我是大雄我谁都怕，我是大雄我谁都怕，我是大雄我谁都怕，我是大雄我谁都怕，我是大雄我谁都怕，"];
    [user3 setImagePath:@"daxiong.jpg"];
    
    
    [_tabledata addObject:user];
    [_tabledata addObject:user2];
    [_tabledata addObject:user3];
    [_tabledata addObject:user5];
    [_tabledata addObject:user6];
    [_tabledata addObject:user7];
    [_tabledata addObject:user8];
     [_tabledata addObject:user];
    [_tabledata addObject:user2];
    [_tabledata addObject:user3];
    [_tabledata addObject:user];
    [_tabledata addObject:user2];
    [_tabledata addObject:user3];
    [_tabledata addObject:user5];
    [_tabledata addObject:user6];
    [_tabledata addObject:user7];
    [_tabledata addObject:user8];
    [_tabledata addObject:user];
    [_tabledata addObject:user2];
    [_tabledata addObject:user3];
    [_tabledata addObject:user];
    [_tabledata addObject:user2];
    [_tabledata addObject:user3];
    [_tabledata addObject:user5];
    [_tabledata addObject:user6];
    [_tabledata addObject:user7];
    [_tabledata addObject:user8];
    [_tabledata addObject:user];
    [_tabledata addObject:user2];
    [_tabledata addObject:user3];

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_tabledata count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //指定cellIdentifier为自定义的cell
    static NSString *CellIdentifier = @"Cell";
    //自定义cell类
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[TableViewCell alloc] initWithReuseIdentifier:CellIdentifier];
    }
    UserModel *user = [_tabledata objectAtIndex:indexPath.row];
    cell.name.text = user.username;
    [cell.userImage setImage:[UIImage imageNamed:user.imagePath]];
    [cell setIntroductionText:user.introduction];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableViewCell *cell =(TableViewCell *) [self tableView:_tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}
//初始化tableView;
-(void)initTableView{
    CGRect frame = self.view.frame;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height)];
    //代理类
    _tableView.delegate = self;
    //数据源
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _tabledata=[NSMutableArray array];
    [self initTableView];
    [self createUserData];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
