//
//  ADSubscriptionsTableViewController.m
//  APIvkTest2(MY DZ)
//
//  Created by Антышев Дмитрий on 14.02.16.
//  Copyright © 2016 Антышев Дмитрий. All rights reserved.
//

#import "ADSubscriptionsTableViewController.h"
#import "ADGroup.h"
#import "UIImageView+AFNetworking.h"
@interface ADSubscriptionsTableViewController ()

@end

@implementation ADSubscriptionsTableViewController
static NSInteger groupInRequest = 11;
- (void)viewDidLoad {
    self.navigationItem.title = @"Subscriptions";
    self.groupArray = [NSMutableArray array];
    [super viewDidLoad];
    [self getGroup];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getGroup{
    [[ADServerManager sharedManager]getSubscriptionsWithOffset:[self.groupArray count] count:groupInRequest user:self.userID onSuccess:^(NSArray *subscriptions) {
        [self.groupArray addObjectsFromArray:subscriptions];
        [self.tableView reloadData];
    } onFailure:^(NSError *error) {
        NSLog(@"%@",[error localizedDescription]);
    }];
}
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.groupArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    ADGroup *group = [self.groupArray objectAtIndex:indexPath.row];
    cell.backgroundColor = [[UIColor greenColor]colorWithAlphaComponent:0.1];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",group.groupName];
    NSURLRequest *request = [NSURLRequest requestWithURL:group.imageURL];
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
    if (indexPath.row==[self.groupArray count]-groupInRequest) {
        [self getGroup];
    }
    
}

@end
