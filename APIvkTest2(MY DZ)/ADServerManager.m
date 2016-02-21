//
//  ADServerManager.m
//  APIvkTest2(MY DZ)
//
//  Created by Антышев Дмитрий on 11.02.16.
//  Copyright © 2016 Антышев Дмитрий. All rights reserved.
//

#import "ADServerManager.h"
#import "AFNetworking.h"
#import "ADUser.h"
#import "ADGroup.h"
#import "ADWall.h"
@interface ADServerManager ()
@property(strong,nonatomic)AFHTTPSessionManager *requestSessionManager;
@end

@implementation ADServerManager

+(ADServerManager*)sharedManager{
    static ADServerManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ADServerManager alloc]init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSURL *url = [NSURL URLWithString:@"https://api.vk.com/method/"];
        self.requestSessionManager = [[AFHTTPSessionManager alloc]initWithBaseURL:url];
    }
    return self;
}
#pragma merk - For All Friends
- (void) getFriendsWithOffset:(NSInteger) offset
                        count:(NSInteger) count
                    onSuccess:(void(^)(NSArray* friends)) success
                    onFailure:(void(^)(NSError* error)) failure{
    
    NSDictionary *parms = [NSDictionary dictionaryWithObjectsAndKeys:@"224091312",@"user_id",
                                                                    @"name",@"order",
                                                                    @(count),@"count",
                                                                    @(offset),@"offset",
                                                                    @"photo_100",@"fields",
                                                                    @"nom",@"name_case", nil];
    
    [self.requestSessionManager GET:@"friends.get?v=5.45" parameters:parms progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSArray *dictsArray = [[responseObject objectForKey:@"response"]objectForKey:@"items"];
        NSMutableArray *objectsArray = [NSMutableArray array];
        for (NSDictionary *dict in dictsArray) {
            ADUser *user = [[ADUser alloc]initWithServerResponse:dict];
            [objectsArray addObject:user];
            
        }
        if (success) {
            success(objectsArray);
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        if (failure) {
            failure(error);
        }
    }];

}

#pragma mark - Info For ONE Freind

-(void)getMoreInfoForFriend:(NSNumber*)user_ids
                  onSuccess:(void(^)(ADUser* user)) success
                  onFailure:(void(^)(NSError* error)) failure{
    NSDictionary *parms = [NSDictionary dictionaryWithObjectsAndKeys:user_ids,@"user_ids",
                                                            @"sex, bdate,status, city, country,photo_200,online",@"fields",
                                                                            @"nom",@"name_case", nil];
    
    [self.requestSessionManager GET:@"users.get?v=5.45" parameters:parms progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSArray *dictsArray= [responseObject objectForKey:@"response"];
        ADUser *user = [[ADUser alloc]init];
        for (NSDictionary *dict in dictsArray) {
        user = [[ADUser alloc]initWithServerResponse:dict];
        }
            
        
        if (success) {
            success(user);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
        if (failure) {
            failure(error);
        }

    }];
}


#pragma mark  - Subscriptions
- (void) getSubscriptionsWithOffset:(NSInteger) offset
                              count:(NSInteger) count
                               user:(NSNumber*)user_ids
                          onSuccess:(void(^)(NSArray* subscriptions)) success
                          onFailure:(void(^)(NSError* error)) failure{
    NSDictionary *parms = [NSDictionary dictionaryWithObjectsAndKeys:user_ids,@"user_id",
                           @"1",@"extended",
                           @"name,photo_100",@"fields",
                           @(count),@"count",
                           @(offset),@"offset",nil];

            [self.requestSessionManager GET:@"users.getSubscriptions?v=5.45" parameters:parms progress:nil success:^(NSURLSessionTask *task, id responseObject) {
                NSLog(@"JSON: %@", responseObject);
                NSArray *dictsArray = [[responseObject objectForKey:@"response"]objectForKey:@"items"] ;
                NSMutableArray *objectsArray = [NSMutableArray array];
                for (NSDictionary *dict in dictsArray) {
                    ADGroup *group = [[ADGroup alloc]initWithServerResponse:dict];
                    [objectsArray addObject:group];
                    
                }
                if (success) {
                    success(objectsArray);
                }
            } failure:^(NSURLSessionTask *operation, NSError *error) {
                NSLog(@"Error: %@", error);
                if (failure) {
                    failure(error);
                }
            }];

}

#pragma mark - Followers
- (void) getFollowersWithOffset:(NSInteger) offset
                          count:(NSInteger) count
                           user:(NSNumber*)user_ids
                      onSuccess:(void(^)(NSArray* followers)) success
                      onFailure:(void(^)(NSError* error)) failure{
    NSDictionary *parms = [NSDictionary dictionaryWithObjectsAndKeys:user_ids,@"user_id",
                                                                        @(count),@"count",
                                                                        @(offset),@"offset",
                                                                        @"photo_100",@"fields",
                                                                        @"nom",@"name_case",nil];
    
    [self.requestSessionManager GET:@"users.getFollowers?v=5.45" parameters:parms progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSArray *dictsArray = [[responseObject objectForKey:@"response"]objectForKey:@"items"] ;
        NSMutableArray *objectsArray = [NSMutableArray array];
        for (NSDictionary *dict in dictsArray) {
            ADUser *user = [[ADUser alloc]initWithServerResponse:dict];
            [objectsArray addObject:user];
            
        }
        if (success) {
            success(objectsArray);
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        if (failure) {
            failure(error);
        }
    }];
    
}

#pragma mark - Wall
- (void) getWallWithOffset:(NSInteger) offset
                     count:(NSInteger) count
                     owner:(NSNumber*)owner_id
                 onSuccess:(void(^)(NSArray* posts)) success
                 onFailure:(void(^)(NSError* error)) failure{
    NSDictionary *parms = [NSDictionary dictionaryWithObjectsAndKeys:owner_id,@"owner_id",
                           @(count),@"count",
                           @(offset),@"offset",nil];
    
    [self.requestSessionManager GET:@"wall.get?v=5.45" parameters:parms progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSArray *dictsArray = [[responseObject objectForKey:@"response"]objectForKey:@"items"];
        NSMutableArray *objectsArray = [NSMutableArray array];

        for (NSDictionary *dict in dictsArray) {
            ADWall *wall = [[ADWall alloc]initWithServerResponse:dict];
            [objectsArray addObject:wall];
            
        }
        if (success) {
            success(objectsArray);
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        if (failure) {
            failure(error);
        }
    }];
}


@end
