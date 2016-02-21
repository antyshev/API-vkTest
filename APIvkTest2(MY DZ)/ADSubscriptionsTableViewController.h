//
//  ADSubscriptionsTableViewController.h
//  APIvkTest2(MY DZ)
//
//  Created by Антышев Дмитрий on 14.02.16.
//  Copyright © 2016 Антышев Дмитрий. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADServerManager.h"
#import "ADUser.h"
#import "UIImageView+AFNetworking.h"
@interface ADSubscriptionsTableViewController : UITableViewController
@property(strong,nonatomic)NSMutableArray *groupArray;
@property(strong,nonatomic)NSNumber *userID;
@end
