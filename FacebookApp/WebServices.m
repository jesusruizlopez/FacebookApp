//
//  WebServices.m
//  FacebookApp
//
//  Created by Jesús Ruiz on 13/09/14.
//  Copyright (c) 2014 Jesus. All rights reserved.
//

#import "WebServices.h"
#define BASE_URL @"http://api-experimentos.rhcloud.com"

@implementation WebServices

+ (NSDictionary *)getPublications {
    NSError *error;
    NSURLResponse *response;
    
    // quite jsonData
    // modifique a getPublications
    
    NSString *url = [NSString stringWithFormat:@"%@/getPublications", BASE_URL];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];

    // cambie a GET
    // quite body
    // quite header Content-Type
    
    [request setHTTPMethod:@"GET"];
    [request setTimeoutInterval:20];
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if (error)
        return @{@"success": @"0", @"message": @"Ocurrió un error en el servidor"};
    else
        return [NSJSONSerialization JSONObjectWithData:returnData options:NSJSONReadingMutableContainers error:&error];
}

+ (NSDictionary *)sendPublication:(NSDictionary *)publication {
    NSError *error;
    NSURLResponse *response;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:publication options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *url = [NSString stringWithFormat:@"%@/sendPublication", BASE_URL];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:jsonData];
    [request setTimeoutInterval:10];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if (error)
        return @{@"success": @"0", @"message": @"Ocurrió un error en el servidor"};
    else
        return [NSJSONSerialization JSONObjectWithData:returnData options:NSJSONReadingMutableContainers error:&error];
}

+ (NSDictionary *)editPublication:(NSDictionary *)publication {
    NSError *error;
    NSURLResponse *response;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:publication options:NSJSONWritingPrettyPrinted error:&error];
    
    // cambia a editPublication/{id}
    NSString *url = [NSString stringWithFormat:@"%@/editPublication/%@", BASE_URL, [publication objectForKey:@"_id"]];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    
    // en vez de POST, PUT = actualizar
    // HTTP Methods
    // GET = obtener
    // POST = crear
    // PUT = modificar
    // DELETE = eliminar
    
    [request setHTTPMethod:@"PUT"];
    [request setHTTPBody:jsonData];
    [request setTimeoutInterval:10];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if (error)
        return @{@"success": @"0", @"message": @"Ocurrió un error en el servidor"};
    else
        return [NSJSONSerialization JSONObjectWithData:returnData options:NSJSONReadingMutableContainers error:&error];
}

























@end
