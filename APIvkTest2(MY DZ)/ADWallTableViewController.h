//
//  ADWallTableViewController.h
//  APIvkTest2(MY DZ)
//
//  Created by Антышев Дмитрий on 14.02.16.
//  Copyright © 2016 Антышев Дмитрий. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADWallTableViewController : UITableViewController
@property(strong,nonatomic)NSNumber *ownerID;
@property(strong,nonatomic)NSMutableArray *postsArray;
@end
