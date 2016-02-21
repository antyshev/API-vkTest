//
//  ADFollowersTableViewController.m
//  APIvkTest2(MY DZ)
//
//  Created by Антышев Дмитрий on 14.02.16.
//  Copyright © 2016 Антышев Дмитрий. All rights reserved.
//

#import "ADFollowersTableViewController.h"
#import "ADUser.h"
#import "ADServerManager.h"
#import "UIImageView+AFNetworking.h"
@interface ADFollowersTableViewController ()

@end

@implementation ADFollowersTableViewController
static NSInteger usersInRequest = 11;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Followers";
    self.userArray = [NSMutableArray array];
    [self getFollowers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma merk - API
-(void)getFollowers{
    [[ADServerManager sharedManager]getFollowersWithOffset:[self.userArray count] count:usersInRequest user:self.userID onSuccess:^(NSArray *followers) {
        [self.userArray addObjectsFromArray:followers];
        [self.tableView reloadData];
    } onFailure:^(NSError *error) {
        NSLog(@"%@",[error localizedDescription]);
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.userArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    ADUser *user = [self.userArray objectAtIndex:indexPath.row];
    cell.backgroundColor = [[UIColor greenColor]colorWithAlphaComponent:0.1];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",user.firstName,user.lastName];
    NSURLRequest *request = [NSURLRequest requestWithURL:user.imageURL];
    __weak UITableViewCell *weakCell = cell;
    cell.imageView.image = nil;
    [cell.imageView setImageWithURLRequest:request
                          placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
                              weakCell.imageView.image = image;
                              [weakCell layoutSubviews];
                              
                              [UIView transitionWithView:weakCell.imageView duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
                                  weakCell.imageView.image = image;
                                  
                                  CALayer* imageLayer = weakCell.imageView.layer;
                                  [imageLayer setCornerRadius:22];
                                  [imageLayer setBorderWidth:3];
                                  [imageLayer setBorderColor:[[UIColor cyanColor]CGColor]];
                                  [imageLayer setMasksToBounds:YES];
                              } completion:nil];
                              
                          } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
                              
                          }];
    
    
    
    return cell;
}



#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==[self.userArray count]-usersInRequest) {
        [self getFollowers];
    }

}
@end
