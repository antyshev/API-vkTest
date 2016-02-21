//
//  ViewController.m
//  APIvkTest2(MY DZ)
//
//  Created by Антышев Дмитрий on 11.02.16.
//  Copyright © 2016 Антышев Дмитрий. All rights reserved.
//

#import "ViewController.h"
#import "ADInfoForFriendViewController.h"
#import "UIImageView+AFNetworking.h"
@interface ViewController ()
@property(strong,nonatomic)NSMutableArray *friendsArray;
@end

@implementation ViewController
static NSInteger friendsInRequest = 11;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.friendsArray = [NSMutableArray array];
    [self getFriendsFromServer];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor greenColor];
   


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma merk - API
-(void)getFriendsFromServer{
    [[ADServerManager sharedManager]getFriendsWithOffset:[self.friendsArray count] count:friendsInRequest
                                               onSuccess:^(NSArray *friendsArray) {
                                                   [self.friendsArray addObjectsFromArray:friendsArray];
                                                   //[self.tableView reloadData];
                                                   //////vmesto reload data legche - reload data
                                                   
                                                   NSMutableArray *newPaths = [NSMutableArray array];
                                                   for (int i = (int)[self.friendsArray count]-(int)[friendsArray count]; i < [self.friendsArray count];i++) {
                                                       [newPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
                                                   }
                                                   [self.tableView beginUpdates];
                                                   [self.tableView insertRowsAtIndexPaths:newPaths withRowAnimation:UITableViewRowAnimationTop];
                                                   [self.tableView endUpdates];
                                                   
                                                   ////////////////legche reload data//////////
                                               } onFailure:^(NSError *error) {
                                                   NSLog(@"error = %@",error);
                                               }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.friendsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }

        ADUser *friend = [self.friendsArray objectAtIndex:indexPath.row];
        cell.backgroundColor = [[UIColor greenColor]colorWithAlphaComponent:0.1];
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",friend.firstName,friend.lastName];
        NSURLRequest *request = [NSURLRequest requestWithURL:friend.imageURL];
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
    if (indexPath.row==[self.friendsArray count]-friendsInRequest) {
                [self getFriendsFromServer];
           }

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        ADUser *user = [self.friendsArray objectAtIndex:indexPath.row];
    [[ADServerManager sharedManager]getMoreInfoForFriend:user.userID onSuccess:^(ADUser *user) {
        ADInfoForFriendViewController *vc = [self.storyboard
                                             instantiateViewControllerWithIdentifier:@"ADInfoForFriendViewController"];
        vc.userID = user.userID;
        vc.firstName = user.firstName;
        vc.lastName = user.lastName;
        vc.imageURL = user.imageURL;
        vc.gender = user.gender;
        vc.userBirthDay = user.userBirthDay;
        vc.city = user.city;
        vc.country = user.country;
        vc.online = user.online;
        vc.status = user.status;
        [self.navigationController pushViewController:vc animated:YES];

        
    } onFailure:^(NSError *error) {
        NSLog(@"ERROR: %@",[error localizedDescription]);
    }];
    
}
@end
