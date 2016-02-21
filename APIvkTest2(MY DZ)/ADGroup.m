//
//  ADGroup.m
//  APIvkTest2(MY DZ)
//
//  Created by Антышев Дмитрий on 14.02.16.
//  Copyright © 2016 Антышев Дмитрий. All rights reserved.
//

#import "ADGroup.h"

@implementation ADGroup
-(id)initWithServerResponse:(NSDictionary*)responseDictionary{
    
    self = [super init];
    if (self) {
        self.groupName = [responseDictionary objectForKey:@"name"];
        NSString *urlString100 = [responseDictionary objectForKey:@"photo_100"];
        
        if (urlString100) {
            self.imageURL = [NSURL URLWithString:urlString100];
        }

    }
    return self;
}

@end
