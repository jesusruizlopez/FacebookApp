//
//  ObjectDataMaper.m
//  FacebookApp
//
//  Created by Jesús Ruiz on 06/09/14.
//  Copyright (c) 2014 Jesus. All rights reserved.
//

#import "ObjectDataMaper.h"
#import "Publicacion.h"

@implementation ObjectDataMaper

/*

 Operaciones CRUD (Create, Read, Update, Delete)
 
 Se mantiene nuestro modelo original:
 
 mensaje = String
 autor = String
 latitud = String (cambiamos de double a String, pero si no tienes error con double, no pasa nada)
 longitud = String (cambiamos de double a String, pero si no tienes error con double, no pasa nada)
 
 Hacer los cambios correspondientes en la clase Publicacion y en la entidad Publicaciones para que queden definidos estos atributos
 
 Los métodos guardar, obtener, editar y eliminar se quedan como los creamos la primera vez, como se muestran a continuación
 
*/

-(BOOL)guardarPublicacion:(NSDictionary *)publicacion {
    NSError *error;
    
    self.appDelegate = [[UIApplication sharedApplication] delegate];
    self.context = [self.appDelegate managedObjectContext];
    
    Publicacion *pub;
    pub = [NSEntityDescription insertNewObjectForEntityForName:@"Publicaciones" inManagedObjectContext:self.context];
    
    pub.mensaje = [publicacion objectForKey:@"mensaje"];
    pub.autor = [publicacion objectForKey:@"autor"];
    pub.latitud = [publicacion objectForKey:@"latitud"];
    pub.longitud = [publicacion objectForKey:@"longitud"];
    
    [self.context save:&error];
    
    if (error != nil)
        return NO;
    return YES;
}

- (NSMutableArray *)obtenerPublicaciones {
    NSError *error;
    self.request = [[NSFetchRequest alloc] init];
    self.appDelegate = [[UIApplication sharedApplication] delegate];
    self.context = [self.appDelegate managedObjectContext];
    
    [self.request setEntity:[NSEntityDescription entityForName:@"Publicaciones" inManagedObjectContext:self.context]];
    NSMutableArray *result = [[NSMutableArray alloc] init];
    NSArray *pubs = [self.context executeFetchRequest:self.request error:&error];
    
    if (error != nil)
        return result;
    
    NSDictionary *obj;
    for (Publicacion *pub in pubs) {
        obj = @{
                @"id": [pub objectID],
                @"mensaje": pub.mensaje,
                @"autor": pub.autor,
                @"latitud": pub.latitud,
                @"longitud": pub.longitud
               };
        
        [result addObject:obj];
    }
    
    return result;
}

- (BOOL)eliminarPublicacion:(NSManagedObjectID *)objectID {
    
    NSError *error;
    self.request = [[NSFetchRequest alloc] init];
    self.appDelegate = [[UIApplication sharedApplication] delegate];
    self.context = [self.appDelegate managedObjectContext];
    
    [self.request setEntity:[NSEntityDescription entityForName:@"Publicaciones" inManagedObjectContext:self.context]];
    
    // NSPredicate para hacer consultas en CoreData
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF == %@", objectID];
    [self.request setPredicate:predicate];
    
    [self.context deleteObject:[[self.context executeFetchRequest:self.request error:&error] lastObject]];
    // firstObject: obtiene el primer elemento de un array [1,2,3,4] = 1
    // lastObject: obtiene el último elemento de un array [1,2,3,4] = 4
    // en este caso, executeFetchRequest, devuelve algo así [obj]
    // si aplicamos firstObject o lastObject, obtenemos = obj
    
    [self.context save:&error];
    
    if (error != nil)
        return NO;
    return YES;
}

- (BOOL)editarPublicacion:(NSDictionary *)publicacion {
    NSError *error;
    
    self.request = [[NSFetchRequest alloc] init];
    self.appDelegate = [[UIApplication sharedApplication] delegate];
    self.context = [self.appDelegate managedObjectContext];
    
    [self.request setEntity:[NSEntityDescription entityForName:@"Publicaciones" inManagedObjectContext:self.context]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF == %@", [publicacion objectForKey:@"id"]];
    [self.request setPredicate:predicate];
    Publicacion *pub = [[self.context executeFetchRequest:self.request error:&error] firstObject];
    
    pub.autor = [publicacion objectForKey:@"autor"];
    pub.mensaje = [publicacion objectForKey:@"mensaje"];
    pub.latitud = [publicacion objectForKey:@"latitud"];
    pub.longitud = [publicacion objectForKey:@"longitud"];
    
    [self.context save:&error];
    if (error != nil)
        return NO;
    return YES;
}

@end
