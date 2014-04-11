//
//  QDCollectionOpinionController.m
//  QuanDiem
//
//  Created by Xuan Dung Bui on 2013/11/08.
//  Copyright (c) 2013年 QuanDiem. All rights reserved.
//

#import "QDCollectionOpinionController.h"
#import "QDAPIClient.h"
#import "QDCollectionOpinionCell.h"
#import "Underscore.h"

@interface QDCollectionOpinionController ()

@end

@implementation QDCollectionOpinionController {
    NSArray *opinions;
    NSArray *categories;
    NSString *categoryId;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self loadData:NO];
}

- (void)loadData:(BOOL)next {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (categoryId) {
        [params setObject:categoryId forKey:@"category"];
    }
    [[QDAPIClient sharedClient] GET:@"opinion" parameters:params success:^(AFHTTPRequestOperation *operation, id json) {
        opinions = json[@"opinions"];
        [self.collectionView reloadData];
    } failure:nil];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return opinions.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    QDCollectionOpinionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"OpinionCell" forIndexPath:indexPath];
    cell.opinion = opinions[indexPath.item];
    return cell;
}

- (IBAction)openCategory:(id)sender {
    [[QDAPIClient sharedClient] GET:@"category" parameters:nil success:^(AFHTTPRequestOperation *operation, NSArray *json) {
        categories = json;
        UIActionSheet *categorySheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"Browse by category", @"")
                                                                   delegate:self
                                                          cancelButtonTitle:nil
                                                     destructiveButtonTitle:nil
                                                          otherButtonTitles:nil];
        
        [categorySheet addButtonWithTitle:@"All"];
        
        for (NSDictionary* category in categories) {
            [categorySheet addButtonWithTitle:category[@"title"]];
        }
        
        [categorySheet showFromTabBar:self.tabBarController.tabBar];
        
    } failure:nil];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        categoryId = nil;
    } else {
        categoryId = categories[buttonIndex-1][@"_id"];
    }
    [self loadData:NO];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (!decelerate) {
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"OpinionShowStats"
         object:self];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"OpinionHideStats"
     object:self];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"OpinionShowStats"
     object:self];
}
@end
