//
//  MapViewController.m
//  Restaurantes
//
//  Created by Jorge Rebollo J on 07/10/16.
//  Copyright © 2016 RGStudio. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, weak) IBOutlet MKMapView *generalMapView;

@end

@implementation MapViewController

+ (instancetype)sharedManager
{
    static id sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _mapsViewModel = [[NSMutableArray alloc] init];
        _singleMapViewModel = [[NSMutableDictionary alloc] init];
    }
    return self;
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.generalMapView.delegate = self;
    self.generalMapView.mapType = MKMapTypeStandard;
    self.generalMapView.showsUserLocation = YES;
    
    [self setAnnotationsGroup];
    [self setAnnotation];
}

- (void)setAnnotationsGroup
{
    if (self.mapsViewModel)
    {
        NSMutableArray *annotationsGroup = [NSMutableArray array];
        for (NSMutableDictionary* currentRestaurant in self.mapsViewModel)
        {
            CLLocationCoordinate2D annotationCoord;
            annotationCoord.latitude = [[currentRestaurant[@"location"][@"lat"] description] intValue];
            annotationCoord.longitude = [[currentRestaurant[@"location"][@"lng"] description] intValue];
            MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
            annotationPoint.coordinate = annotationCoord;
            annotationPoint.title = [currentRestaurant[@"name"] description];
            annotationPoint.subtitle = [currentRestaurant[@"category"] description];
            [annotationsGroup addObject:annotationPoint];
        }
        for (MKPointAnnotation *pointAnnotation in annotationsGroup)
        {
            [self.generalMapView addAnnotation:pointAnnotation];
        }
        [self setAdditinalLocationsToTest];
    }
}

- (void)setAdditinalLocationsToTest
{
    CLLocationCoordinate2D annotationCoord;
    annotationCoord.latitude = 40.785091;
    annotationCoord.longitude = -73.968285;
    MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
    annotationPoint.coordinate = annotationCoord;
    annotationPoint.title = @"Central Park";
    annotationPoint.subtitle = @"New York, NY, USA";
    [self.generalMapView addAnnotation:annotationPoint];
}

- (void)setAnnotation
{
    if (self.singleMapViewModel)
    {
        CLLocationCoordinate2D annotationCoord;
        annotationCoord.latitude = [[self.singleMapViewModel[@"location"][@"lat"] description] intValue];
        annotationCoord.longitude = [[self.singleMapViewModel[@"location"][@"lng"] description] intValue];
        MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
        annotationPoint.coordinate = annotationCoord;
        annotationPoint.title = [self.singleMapViewModel[@"name"] description];
        annotationPoint.subtitle = [self.singleMapViewModel[@"category"] description];
        [self.generalMapView addAnnotation:annotationPoint];
    }
}


- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    [self.generalMapView setCenterCoordinate:userLocation.coordinate animated:YES];
}

- (IBAction)closeMap
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
