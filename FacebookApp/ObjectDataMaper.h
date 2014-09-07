//
//  ObjectDataMaper.h
//  FacebookApp
//
//  Created by Jesús Ruiz on 06/09/14.
//  Copyright (c) 2014 Jesus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"

@interface ObjectDataMaper : NSObject

@property (strong, nonatomic) AppDelegate *appDelegate;
@property (strong, nonatomic) NSManagedObjectContext *context;
@property (strong, nonatomic) NSEntityDescription *entity;
@property (strong, nonatomic) NSFetchRequest *request;

- (BOOL)guardarPublicacion:(NSDictionary *)publicacion;
- (NSMutableArray *)obtenerPublicaciones;
- (BOOL)eliminarPublicacion:(NSManagedObjectID *)objectID;
- (BOOL)editarPublicacion:(NSDictionary *)publicacion;

@end
