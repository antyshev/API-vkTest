//
//  ADWall.h
//  APIvkTest2(MY DZ)
//
//  Created by Антышев Дмитрий on 14.02.16.
//  Copyright © 2016 Антышев Дмитрий. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADWall : NSObject

@property(strong,nonatomic)NSNumber *ownerID;
@property(strong,nonatomic)NSString *text;
@property(strong,nonatomic)NSDate *date;
@property(strong,nonatomic)NSURL *imageURL;
@property(assign,nonatomic)NSNumber *likes;
@property(assign,nonatomic)CGSize size;


-(id)initWithServerResponse:(NSDictionary*)responseDictionary;
@end
