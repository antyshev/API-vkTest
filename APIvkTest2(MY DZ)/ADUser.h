//
//  ADUser.h
//  APIvkTest
//
//  Created by Антышев Дмитрий on 11.02.16.
//  Copyright © 2016 Антышев Дмитрий. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ADUser : NSObject
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



-(id)initWithServerResponse:(NSDictionary*)responseDictionary;
@end

