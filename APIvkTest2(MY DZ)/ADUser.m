//
//  ADUser.m
//  APIvkTest
//
//  Created by Антышев Дмитрий on 11.02.16.
//  Copyright © 2016 Антышев Дмитрий. All rights reserved.
//

#import "ADUser.h"

@implementation ADUser
-(id)initWithServerResponse:(NSDictionary*)responseDictionary{

    self = [super init];
    if (self) {
        self.firstName = [responseDictionary objectForKey:@"first_name"];
        self.lastName = [responseDictionary objectForKey:@"last_name"];
        self.gender = [responseDictionary objectForKey:@"sex"];
        self.userBirthDay = [responseDictionary objectForKey:@"bdate"];
        self.city = [responseDictionary objectForKey:@"city.title"];
        self.country = [responseDictionary objectForKey:@"country.title"];
        self.online = [responseDictionary objectForKey:@"online"];
        self.userID = [responseDictionary objectForKey:@"id"];
        self.status = [responseDictionary objectForKey:@"status"];
        NSString *urlString100 = [responseDictionary objectForKey:@"photo_100"];
        NSString *urlString200 = [responseDictionary objectForKey:@"photo_200"];
        
        if (urlString100) {
            self.imageURL = [NSURL URLWithString:urlString100];
        }else if (urlString200){
            self.imageURL = [NSURL URLWithString:urlString200];
        }
    }
    return self;
}
@end
