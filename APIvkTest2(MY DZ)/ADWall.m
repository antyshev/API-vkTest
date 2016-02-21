//
//  ADWall.m
//  APIvkTest2(MY DZ)
//
//  Created by Антышев Дмитрий on 14.02.16.
//  Copyright © 2016 Антышев Дмитрий. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ADWall.h"

@implementation ADWall
-(id)initWithServerResponse:(NSDictionary*)responseDictionary{
    self = [super init];
    if (self) {
       // NSDictionary *testDict = [responseDictionary objectForKey:@"items"];

        self.ownerID = [responseDictionary objectForKey:@"owner_id"];
        self.text = [responseDictionary objectForKey:@"text"];
        NSNumber *timeInterval = [responseDictionary objectForKey:@"date"];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeInterval floatValue]];
        self.date = date;
        self.likes = [[responseDictionary objectForKey:@"likes"]objectForKey:@"count"];
        //NSNumber *width = [[responseDictionary objectForKey:@"attachments"]objectForKey:@"width"];
       // NSNumber *height = [[responseDictionary objectForKey:@"attachments"]objectForKey:@"height"];
        //self.size = CGSizeMake([width floatValue], [height floatValue]);
        NSArray *testDict2 = [responseDictionary objectForKey:@"attachments"];
        NSDictionary *test3 = [[testDict2 objectAtIndex:0]objectForKey:@"photo"];
 
        
            self.imageURL = [NSURL URLWithString:[test3 objectForKey:@"photo_604"]];
        
        }
    return self;
}
@end

