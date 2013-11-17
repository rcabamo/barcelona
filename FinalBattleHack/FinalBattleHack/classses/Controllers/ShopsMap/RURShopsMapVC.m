//
//  RURShopsMapVC.m
//  FinalBattleHack
//
//  Created by Oriol Capdevila on 16/11/13.
//  Copyright (c) 2013 The Synthesizers. All rights reserved.
//

#import "RURShopsMapVC.h"
#import "RURCustomAnnotation.h"
#import "RURDetailShopVC.h"

#import <MapKit/MapKit.h>

@interface RURShopsMapVC () <MKMapViewDelegate>

@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@property (nonatomic, getter = isCentered) BOOL centered;

@end

@implementation RURShopsMapVC

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.title = @"RURShopsMapVC";
    
    UIImageView *rightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"RightRevealIcon.png"]];
    UIImageView *leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LeftRevealIcon.png"]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftView];
    self.navigationItem.leftItemsSupplementBackButton = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

#pragma mark - Private Methods

- (void)centerMapInUserLocation
{
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = 0.05;
    span.longitudeDelta = 0.05;
    CLLocationCoordinate2D location;
    location.latitude = self.mapView.userLocation.coordinate.latitude;
    location.longitude = self.mapView.userLocation.coordinate.longitude;
    region.span = span;
    region.center = location;
    [self.mapView setRegion:region animated:YES];
}


#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)aMapView didUpdateUserLocation:(MKUserLocation *)aUserLocation
{
    if (!self.isCentered)
    {
        self.centered = YES;
        [self centerMapInUserLocation];
    }
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    // Calculate the coordinates
    
    CGPoint nePoint = CGPointMake(self.mapView.bounds.origin.x + self.mapView.bounds.size.width, self.mapView.bounds.origin.y);
    CGPoint swPoint = CGPointMake((self.mapView.bounds.origin.x), (self.mapView.bounds.origin.y + self.mapView.bounds.size.height));
    
    // Then transform those point into lat,lng values
    CLLocationCoordinate2D neCoord = [self.mapView convertPoint:nePoint toCoordinateFromView:self.mapView];
    CLLocationCoordinate2D swCoord = [self.mapView convertPoint:swPoint toCoordinateFromView:self.mapView];
    
    double swlat = swCoord.latitude;
    double swlon = swCoord.longitude;
    double nelat = neCoord.latitude;
    double nelon = neCoord.longitude;
    
    PFGeoPoint *geoPoointSouth = [PFGeoPoint geoPointWithLatitude:swlat longitude:swlon];
    PFGeoPoint *geoPoointNorth = [PFGeoPoint geoPointWithLatitude:nelat longitude:nelon];
    
    PFGeoPoint *geoPoint = [PFGeoPoint geoPointWithLocation:self.mapView.userLocation.location];
    PFQuery *query = [PFQuery queryWithClassName:@"Shop"];
    __block NSArray *shops;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        shops = objects;
        NSLog(@"shops: %@", shops);
        
        NSMutableArray *annotationsToAdd = [NSMutableArray new];
        for (PFObject *object in shops) {
            PFGeoPoint *location = [object objectForKey:@"position"];
            NSLog(@"GeoLocation: (lat = %d, lon = %d)", location.latitude, location.longitude);
            RURCustomAnnotation *ann = [[RURCustomAnnotation alloc] init];
            ann.title = [object objectForKey:@"name"];
            ann.coordinate = CLLocationCoordinate2DMake(location.latitude, location.longitude);
            ann.object = object;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.mapView addAnnotation:ann];
            });
            
        }
        
    }];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id < MKAnnotation >)annotation
{
    NSLog(@"annotation: %@", annotation);
    
    MKPinAnnotationView *mapPin = nil;
    if(annotation != self.mapView.userLocation)
    {
        static NSString *defaultPinID = @"defaultPin";
        mapPin = (MKPinAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
            
        mapPin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                                  reuseIdentifier:defaultPinID];
        mapPin.canShowCallout = YES;
        UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        mapPin.rightCalloutAccessoryView = infoButton;
        
    }
    return mapPin;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    if([view.annotation isKindOfClass:[RURCustomAnnotation class]]) {
        RURCustomAnnotation *annotation = view.annotation;
        RURDetailShopVC *controller = [[RURDetailShopVC alloc] initWithShop:annotation.object];
        [self.navigationController pushViewController:controller animated:YES];
    }
}


@end
