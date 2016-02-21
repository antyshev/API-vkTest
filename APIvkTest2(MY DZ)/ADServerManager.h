//
//  ADServerManager.h
//  APIvkTest2(MY DZ)
//
//  Created by Антышев Дмитрий on 11.02.16.
//  Copyright © 2016 Антышев Дмитрий. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ADUser;
@interface ADServerManager : NSObject

+(ADServerManager*)sharedManager;
- (void) getFriendsWithOffset:(NSInteger) offset
                        count:(NSInteger) count
                    onSuccess:(void(^)(NSArray* user)) success
                    onFailure:(void(^)(NSError* error)) failure;
-(void)getMoreInfoForFriend:(NSNumber*)user_ids
                            onSuccess:(void(^)(ADUser* friends)) success
                            onFailure:(void(^)(NSError* error)) failure;
- (void) getSubscriptionsWithOffset:(NSInteger) offset
                              count:(NSInteger) count
                               user:(NSNumber*)user_ids
                          onSuccess:(void(^)(NSArray* subscriptions)) success
                          onFailure:(void(^)(NSError* error)) failure;
- (void) getFollowersWithOffset:(NSInteger) offset
                              count:(NSInteger) count
                               user:(NSNumber*)user_ids
                          onSuccess:(void(^)(NSArray* followers)) success
                      onFailure:(void(^)(NSError* error)) failure;
- (void) getWallWithOffset:(NSInteger) offset
                          count:(NSInteger) count
                           owner:(NSNumber*)owner_id
                      onSuccess:(void(^)(NSArray* posts)) success
                      onFailure:(void(^)(NSError* error)) failure;
@end
