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
        _mapViewModel = [[NSMutableDictionary alloc] init];
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
    
    // Set Annotation
    CLLocationCoordinate2D annotationCoord;
    annotationCoord.latitude = [[self.mapViewModel[@"location"][@"lat"] description] intValue];
    annotationCoord.longitude = [[self.mapViewModel[@"location"][@"lng"] description] intValue];
    MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
    annotationPoint.coordinate = annotationCoord;
    annotationPoint.title = [self.mapViewModel[@"name"] description];
    annotationPoint.subtitle = [self.mapViewModel[@"category"] description];
    [self.generalMapView addAnnotation:annotationPoint];
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
