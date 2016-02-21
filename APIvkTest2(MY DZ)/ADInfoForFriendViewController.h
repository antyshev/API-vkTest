//
//  ADInfoForFriendViewController.h
//  APIvkTest2(MY DZ)
//
//  Created by Антышев Дмитрий on 12.02.16.
//  Copyright © 2016 Антышев Дмитрий. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+AFNetworking.h"
#import "ADUser.h"
@interface ADInfoForFriendViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UILabel *lableForName;
@property (weak, nonatomic) IBOutlet UIView *onlineView;
@property (weak, nonatomic) IBOutlet UIImageView *imagePhotoView;
@property (weak, nonatomic) IBOutlet UILabel *labelForID;
@property (weak, nonatomic) IBOutlet UILabel *labelForGender;
@property (weak, nonatomic) IBOutlet UILabel *labelForBirthDay;
@property (weak, nonatomic) IBOutlet UILabel *labelForStatus;
@property (weak, nonatomic) IBOutlet UIButton *subscriptionButton;
@property (weak, nonatomic) IBOutlet UIButton *followersButton;
@property (weak, nonatomic) IBOutlet UIButton *wallButton;
- (IBAction)actionFollowers:(UIButton *)sender;
- (IBAction)actionSubscriptions:(UIButton *)sender;
- (IBAction)actionWall:(UIButton *)sender;

@property(strong,nonatomic)NSNumber *userID;
@property(strong,nonatomic)NSString *firstName;
@property(strong,nonatomic)NSString *lastName;
@property(strong,nonatomic)NSURL *imageURL;
@property(assign,nonatomic)NSNumber *gender;
@property(strong,nonatomic)NSDate *userBirthDay;
@property(strong,nonatomic)NSString *city;
@property(strong,nonatomic)NSString *country;
@property(strong,nonatomic)NSNumber *online;
@property(strong,nonatomic)NSString *status;
@end
