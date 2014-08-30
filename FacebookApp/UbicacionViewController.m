//
//  UbicacionViewController.m
//  FacebookApp
//
//  Created by Jesús Ruiz on 30/08/14.
//  Copyright (c) 2014 Jesus. All rights reserved.
//

#import "UbicacionViewController.h"

@interface UbicacionViewController ()

@end

@implementation UbicacionViewController {
    GMSMapView *map;
    GMSMarker *marker;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:24.804414 longitude:-107.382391 zoom:12];
    map = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    map.delegate = self;
    map.myLocationEnabled = YES;
    self.view = map;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cambiarVista:(id)sender {
    if ([map mapType] == kGMSTypeHybrid) {
        self.navigationItem.rightBarButtonItem.title = @"Vista satélite";
        map.mapType = kGMSTypeNormal;
    }
    else {
        self.navigationItem.rightBarButtonItem.title = @"Vista normal";
        map.mapType = kGMSTypeHybrid;
    }
}

- (void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate {
    marker = [[GMSMarker alloc] init];
    marker.position = coordinate;
    marker.title = @"YO";
    marker.snippet = @"Esta es mi ubicación";
    [map clear];
    marker.map = map;
    
    NSLog(@"%lf, %lf", marker.position.latitude, marker.position.longitude);
}

@end
