//
//  QDNotificationViewController.m
//  QuanDiem
//
//  Created by Xuan Dung Bui on 4/19/14.
//  Copyright (c) 2014 QuanDiem. All rights reserved.
//

#import "QDNotificationViewController.h"
#import "QDAPIClient.h"

@interface QDNotificationViewController () {
    NSArray *notifications;
}
@end

@implementation QDNotificationViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [[QDAPIClient sharedClient] GET:@"notification" parameters:nil success:^(AFHTTPRequestOperation *operation, id json) {
        notifications = json[@"notifications"];
        [self.tableView reloadData];
    } failure:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return notifications.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSDictionary *notification = notifications[indexPath.row];
    NSInteger type = [notification[@"type"] integerValue];
    if (type == 11) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Agree" forIndexPath:indexPath];
        return cell;
    } else if (type == 10) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Disagree" forIndexPath:indexPath];
        return cell;
    } else if (type == 211) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Upvote" forIndexPath:indexPath];
        return cell;
    } else if (type == 210) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Downvote" forIndexPath:indexPath];
        return cell;
    } else if (type == 22) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Comment" forIndexPath:indexPath];
        return cell;
    } else if (type == 2) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Comment" forIndexPath:indexPath];
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Agree" forIndexPath:indexPath];
        return cell;
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
