//
//  RURShopsMapVC.m
//  FinalBattleHack
//
//  Created by Oriol Capdevila on 16/11/13.
//  Copyright (c) 2013 The Synthesizers. All rights reserved.
//

#import "RURShopsMapVC.h"

#import <MapKit/MapKit.h>

@interface RURShopsMapVC () <MKMapViewDelegate>

@property (nonatomic, weak) IBOutlet MKMapView *mapView;

@end

@implementation RURShopsMapVC

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.title = @"RURShopsMapVC";
}


#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    // Calculate the coordinates
    
    CGPoint nePoint = CGPointMake(self.mapView.bounds.origin.x + self.mapView.bounds.size.width, self.mapView.bounds.origin.y);
    CGPoint swPoint = CGPointMake((self.mapView.bounds.origin.x), (self.mapView.bounds.origin.y + self.mapView.bounds.size.height));
    
    CLLocationCoordinate2D neCoord;
    neCoord = [self.mapView convertPoint:nePoint toCoordinateFromView:self.mapView];
    
    CLLocationCoordinate2D swCoord;
    swCoord = [self.mapView convertPoint:swPoint toCoordinateFromView:self.mapView];
    
    double swlat = swCoord.latitude;
    double swlon = swCoord.longitude;
    double nelat = neCoord.latitude;
    double nelon = neCoord.longitude;
    
    // Make the query
    
    BBQuery *query = [Backbeam queryForEntity:@"shop"];
    [query bounding:@"position" swlat:swlat swlon:swlon nelat:nelat nelon:nelon limit:300 success:^(NSArray *arr, NSInteger total, BOOL cached) {
        
        [self.mapView removeAnnotations:self.mapView.annotations];
        
        for (BBObject *object in arr) {
            BBLocation *location = [object locationForField:@"position"];
            MKPointAnnotation *ann = [[MKPointAnnotation alloc] init];
            ann.title = [object stringForField:@"name"];
            ann.coordinate = CLLocationCoordinate2DMake(location.latitude, location.longitude);
            [self.mapView addAnnotation:ann];
        }
        
    } failure:^(NSError* err) {
        NSLog(@"error %@", err);
    }];
}

@end
