//
//  QDOpinionViewController.m
//  QuanDiem
//
//  Created by Xuan Dung Bui on 4/17/14.
//  Copyright (c) 2014 QuanDiem. All rights reserved.
//

#import "QDOpinionViewController.h"
#import "QDTableCommentCell.h"
#import "QDAPIClient.h"
#import "UIButton+AFNetworking.h"

@interface QDOpinionViewController ()

@end

@implementation QDOpinionViewController {
    NSMutableArray *comments;
}

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
    _opinionLabel.text = _opinion[@"title"];
    _categoryLabel.text = _opinion[@"category"][@"title"];
    _userLabel.text = _opinion[@"user"][@"displayName"];
    _dateLabel.text = [QDUtils friendlyDate:_opinion[@"created"]];
    
    [_opinionButton setBackgroundImageForState:UIControlStateNormal withURL:[QDUtils urlForImage:_opinion ofSize:100]];
    
    NSDictionary *params = @{@"opinion": _opinion[@"_id"],
                             @"flatten": @"true",
                             @"html": @"true"};
    
    [[QDAPIClient sharedClient] GET:@"comment" parameters:params success:^(AFHTTPRequestOperation *operation, id json) {
        comments = json[@"comments"];
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
    return comments.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QDTableCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Comment" forIndexPath:indexPath];
    // Configure the cell...
    cell.comment = comments[indexPath.row];
    
    // Make sure the constraints have been set up for this cell, since it may have just been created from scratch.
    // Use the following lines, assuming you are setting up constraints from within the cell's updateConstraints method:
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    // If you are using multi-line UILabels, don't forget that the preferredMaxLayoutWidth needs to be set correctly.
    // Do it at this point if you are NOT doing it within the UITableViewCell subclass -[layoutSubviews] method.
    // For example:
    // cell.multiLineLabel.preferredMaxLayoutWidth = CGRectGetWidth(tableView.bounds);
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    QDTableCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Comment"];
    cell.comment = comments[indexPath.row];
    
    // Make sure the constraints have been set up for this cell, since it may have just been created from scratch.
    // Use the following lines, assuming you are setting up constraints from within the cell's updateConstraints method:
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    // Set the width of the cell to match the width of the table view. This is important so that we'll get the
    // correct cell height for different table view widths if the cell's height depends on its width (due to
    // multi-line UILabels word wrapping, etc). We don't need to do this above in -[tableView:cellForRowAtIndexPath]
    // because it happens automatically when the cell is used in the table view.
    // Also note, the final width of the cell may not be the width of the table view in some cases, for example when a
    // section index is displayed along the right side of the table view. You must account for the reduced cell width.
    cell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), CGRectGetHeight(cell.bounds));
    
    // Do the layout pass on the cell, which will calculate the frames for all the views based on the constraints.
    // (Note that you must set the preferredMaxLayoutWidth on multi-line UILabels inside the -[layoutSubviews] method
    // of the UITableViewCell subclass, or do it manually at this point before the below 2 lines!)
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    
    // Get the actual height required for the cell's contentView
    CGFloat height = [cell.commentText suggestedFrameSizeToFitEntireStringConstraintedToWidth:cell.commentText.bounds.size.width].height + 80;
    //[cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    // Add an extra point to the height to account for the cell separator, which is added between the bottom
    // of the cell's contentView and the bottom of the table view cell.
    // height += 1.0f;
    
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 300;
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
