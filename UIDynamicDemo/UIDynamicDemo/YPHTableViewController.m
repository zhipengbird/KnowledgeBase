//
//  YPHTableViewController.m
//  UIDynamicDemo
//
//  Created by shareit on 15/9/11.
//  Copyright (c) 2015年 shareit. All rights reserved.
//

#import "YPHTableViewController.h"
#import "ViewController.h"
#import "YPHNavigatioinControllerDelegate.h"
#import "YPHSnapPushAnimator.h"

//typedef NS_ENUM(NSUInteger, YPH_TRANSITION_TYPE)
//{
//    YPH_TRANSITION_TYPE_SNAP
//};
@interface YPHTableViewController ()
@property(nonatomic,strong)NSArray * animatorNames;

@property (nonatomic,assign)NSInteger transitionType;
@end

@implementation YPHTableViewController


-(void)awakeFromNib
{
    [super awakeFromNib];
    self.animatorNames=@[@"snap"];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.animatorNames.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSObject *obj=_animatorNames[indexPath.row];
    cell.textLabel.text=[obj description];
    return cell;
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
//    ViewController *controller=[self.storyboard instantiateViewControllerWithIdentifier:@"controller"];
//   
//    NSString *object=self.animatorNames[indexPath.row];
//    [controller setDetailItem:object];
//    
   
    self.transitionType=YPH_TRANSITION_TYPE_SNAP;////
    
//    [self.navigationController pushViewController:controller animated:YES];
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.


    if ([[segue identifier]isEqualToString:@"snap"]) {
        NSIndexPath *indexpath=[self.tableView indexPathForSelectedRow];
        NSString *object=self.animatorNames[indexpath.row];
        [[segue destinationViewController]setDetailItem:object];

//        ((YPHNavigatioinControllerDelegate*)self.navigationController.delegate).transitionType=indexpath.row;

    }
}
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    
    
    if (operation==UINavigationControllerOperationPush) {
        
            return [[YPHSnapPushAnimator alloc]init];
      
    }
    else
        return nil;
}

@end
