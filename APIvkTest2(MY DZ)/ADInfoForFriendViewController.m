//
//  ADInfoForFriendViewController.m
//  APIvkTest2(MY DZ)
//
//  Created by Антышев Дмитрий on 12.02.16.
//  Copyright © 2016 Антышев Дмитрий. All rights reserved.
//

#import "ADInfoForFriendViewController.h"
#import "UIImageView+AFNetworking.h"
#import "ADServerManager.h"
#import "ADGroup.h"
#import "ADSubscriptionsTableViewController.h"
#import "ADFollowersTableViewController.h"
#import "ADWallTableViewController.h"
@interface ADInfoForFriendViewController ()
@end

@implementation ADInfoForFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CGPoint defaultPoint1 = self.subscriptionButton.center;
    CGPoint defaultPoint2 = self.followersButton.center;
    [UIView transitionWithView:self.subscriptionButton duration:2 options:UIViewAnimationOptionCurveEaseInOut|UIViewAnimationOptionAutoreverse animations:^{
        CGPoint point1 = CGPointMake(self.subscriptionButton.center.x-160.f, self.subscriptionButton.center.y);
        CGPoint point2 = CGPointMake(self.followersButton.center.x+160.f, self.followersButton.center.y);
        self.subscriptionButton.center = point1;
        self.followersButton.center = point2;

    } completion:^(BOOL finished) {
        if (finished==YES) {
            self.subscriptionButton.center = defaultPoint1;
            self.followersButton.center = defaultPoint2;
        }
    }];
    
    for (int i=0; i<3; i++) {
        CALayer *buttonLayer;
        if (i==1) {
            buttonLayer = self.subscriptionButton.layer;
        }else {
            buttonLayer = self.followersButton.layer;
        }
        
        [buttonLayer setCornerRadius:11];
        [buttonLayer setMasksToBounds:YES];
        [buttonLayer setBorderColor:[[UIColor cyanColor]CGColor]];
        [buttonLayer setBorderWidth:2];
    }
    
    CALayer *wallButtonLayer = self.wallButton.layer;
    [wallButtonLayer setCornerRadius:20];
    [wallButtonLayer setMasksToBounds:YES];
    [wallButtonLayer setBorderColor:[[UIColor cyanColor]CGColor]];
    [wallButtonLayer setBorderWidth:5];


    self.navigationItem.title = @"User Info";
    self.tableView.backgroundColor = [UIColor whiteColor];

    NSURLRequest *request = [NSURLRequest requestWithURL:self.imageURL];
    self.lableForName.text = [NSString stringWithFormat:@"%@ %@",self.firstName,self.lastName];
    self.labelForID.text = [NSString stringWithFormat:@"User ID:%@",self.userID];
    if ([self.gender isEqual:@(0)]) {
        self.labelForGender.text = nil;
    }else if ([self.gender  isEqual: @(1)]){
        self.labelForGender.text = @"Gender: Wooman";
    }else if ([self.gender isEqual: @(2)]){
        self.labelForGender.text = @"Gender: Man";
    }
    if (self.userBirthDay == nil) {
        self.labelForBirthDay.text = nil;
    }else{
        self.labelForBirthDay.text = [NSString stringWithFormat:@"DateBirthDay: %@",self.userBirthDay];
    }
    if (self.status == nil) {
        self.labelForStatus.text = nil;
    }else{
        self.labelForStatus.text = self.status;
    }

    [self.imagePhotoView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
        [UIView transitionWithView:self.imagePhotoView duration:0.8 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            self.imagePhotoView.image = image;
            
            CALayer* imageLayer = self.imagePhotoView.layer;
            [imageLayer setCornerRadius:100];
            [imageLayer setBorderWidth:7];
            [imageLayer setBorderColor:[[UIColor cyanColor]CGColor]];
            [imageLayer setMasksToBounds:YES];
        } completion:nil];
 
    } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
        
    }];
    CALayer* imageOnlineLayer = self.onlineView.layer;
    [imageOnlineLayer setCornerRadius:12];
    [imageOnlineLayer setMasksToBounds:YES];
    if ([self.online isEqual:@(1)]) {
        self.onlineView.backgroundColor = [UIColor greenColor];
    }else{
        self.onlineView.backgroundColor = [UIColor lightGrayColor];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Actions
- (IBAction)actionFollowers:(UIButton *)sender {
    ADFollowersTableViewController *vc = [[ADFollowersTableViewController alloc]initWithStyle:UITableViewStylePlain];
    vc.userID = self.userID;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)actionSubscriptions:(UIButton *)sender {

    ADSubscriptionsTableViewController *vc = [[ADSubscriptionsTableViewController alloc]initWithStyle:UITableViewStylePlain];
    vc.userID = self.userID;
    [self.navigationController pushViewController:vc animated:YES];

}

- (IBAction)actionWall:(UIButton *)sender {
    self.wallButton.titleLabel.text = @"OK";
    [UIView transitionWithView:self.wallButton duration:0.3 options:UIViewAnimationOptionTransitionFlipFromTop|UIViewAnimationOptionAutoreverse animations:nil completion:^(BOOL finished) {
        ADWallTableViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ADWallTableViewController"];
        vc.ownerID = self.userID;
        [self.navigationController pushViewController:vc animated:YES];
    }];
}
@end
