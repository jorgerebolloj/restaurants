//
//  LunchDetailViewController.m
//  Restaurantes
//
//  Created by Jorge Rebollo J on 07/10/16.
//  Copyright © 2016 RGStudio. All rights reserved.
//

#define METERS_MILE 1609.344
#define METERS_FEET 3.28084

#import "LunchDetailViewController.h"

@interface LunchDetailViewController ()

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@property (nonatomic, weak) IBOutlet UILabel *detailRestaurantName;
@property (nonatomic, weak) IBOutlet UILabel *detailCategoryType;
@property (nonatomic, weak) IBOutlet UILabel *detailFormattedAddress;
@property (nonatomic, weak) IBOutlet UILabel *detailFormattedPhone;
@property (nonatomic, weak) IBOutlet UILabel *detailTwitter;

@end

@implementation LunchDetailViewController

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
        _detailViewModel = [[NSMutableDictionary alloc] init];
    }
    return self;
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont fontWithName:@"AvenirNext-DemiBold" size:17.0]}];
    self.navigationController.navigationBar.translucent = NO;
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_map.png"]]];
    self.navigationItem.rightBarButtonItem = item;

    self.mapView.delegate = self;
    self.mapView.mapType = MKMapTypeStandard;
    self.mapView.showsUserLocation = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.detailRestaurantName setText:[self.detailViewModel[@"name"] description]];
    [self.detailCategoryType setText:[self.detailViewModel[@"category"] description]];
    NSMutableArray *address = self.detailViewModel[@"location"][@"formattedAddress"];
    [self.detailFormattedAddress setText:[NSString stringWithFormat:@"%@\n%@\n%@", address[0], address[1], address[2]]];
    [self.detailFormattedPhone setText:[self.detailViewModel[@"contact"][@"formattedPhone"] description]];
    [self.detailTwitter setText:[self.detailViewModel[@"contact"][@"twitter"] description]];
    
    CLLocationCoordinate2D annotationCoord;
    annotationCoord.latitude = [[self.detailViewModel[@"location"][@"lat"] description] intValue];
    annotationCoord.longitude = [[self.detailViewModel[@"location"][@"lng"] description] intValue];
    MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
    annotationPoint.coordinate = annotationCoord;
    annotationPoint.title = [self.detailViewModel[@"name"] description];
    annotationPoint.subtitle = [self.detailViewModel[@"category"] description];
    [self.mapView addAnnotation:annotationPoint];
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    [self.mapView setCenterCoordinate:userLocation.coordinate animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
