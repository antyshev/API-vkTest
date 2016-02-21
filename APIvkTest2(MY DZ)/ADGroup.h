//
//  ADGroup.h
//  APIvkTest2(MY DZ)
//
//  Created by Антышев Дмитрий on 14.02.16.
//  Copyright © 2016 Антышев Дмитрий. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADGroup : NSObject

@property(strong,nonatomic)NSURL *imageURL;
@property(strong,nonatomic)NSString *groupName;


-(id)initWithServerResponse:(NSDictionary*)responseDictionary;
@end
