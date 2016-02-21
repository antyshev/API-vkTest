//
//  ADWallTableViewController.m
//  APIvkTest2(MY DZ)
//
//  Created by Антышев Дмитрий on 14.02.16.
//  Copyright © 2016 Антышев Дмитрий. All rights reserved.
//

#import "ADWallTableViewController.h"
#import "ADServerManager.h"
#import "ADWall.h"
#import "UIImageView+AFNetworking.h"
#import "ADWallTableViewCell.h"
@interface ADWallTableViewController ()

@end

@implementation ADWallTableViewController
static NSInteger postsInRequest = 5;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.postsArray = [NSMutableArray array];
    [self getWall];
    self.navigationItem.title = @"Wall";
    NSLog(@"%@",self.postsArray);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - API 
-(void)getWall{
    [[ADServerManager sharedManager]getWallWithOffset:[self.postsArray count] count:postsInRequest owner:self.ownerID onSuccess:^(NSArray *posts) {
        [self.postsArray addObjectsFromArray:posts];
        [self.tableView reloadData];
    } onFailure:^(NSError *error) {
        NSLog(@"%@",[error localizedDescription]);
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.postsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"CellWell";
    ADWallTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[ADWallTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    ADWall *post = [self.postsArray objectAtIndex:indexPath.row];
    cell.backgroundColor = [[UIColor greenColor]colorWithAlphaComponent:0.1];
    cell.infoLabel.text = [NSString stringWithFormat:@"Likes:%@",post.likes];
    NSURLRequest *request = [NSURLRequest requestWithURL:post.imageURL];
    __weak ADWallTableViewCell *weakCell = cell;
    cell.imagePhoto.image = nil;
    [cell.imagePhoto setImageWithURLRequest:request
                          placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
                              weakCell.imagePhoto.image = image;
                              
                              
                          } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
                              
                          }];
    
    
    
    return cell;
}


#pragma mark - UITableViewDelegate

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 300;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==[self.postsArray count]-postsInRequest) {
        [self getWall];
    }
    
}
@end
