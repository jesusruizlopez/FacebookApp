//
//  WebServices.h
//  FacebookApp
//
//  Created by Jesús Ruiz on 13/09/14.
//  Copyright (c) 2014 Jesus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebServices : NSObject

+ (NSDictionary *)sendPublication:(NSDictionary *)publication;
+ (NSDictionary *)editPublication:(NSDictionary *)publication;
+ (NSDictionary *)getPublications;

@end
