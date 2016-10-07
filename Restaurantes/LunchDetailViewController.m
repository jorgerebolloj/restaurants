//
//  LunchDetailViewController.m
//  Restaurantes
//
//  Created by Jorge Rebollo J on 07/10/16.
//  Copyright © 2016 RGStudio. All rights reserved.
//

#import "LunchDetailViewController.h"

@interface LunchDetailViewController ()

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

    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.detailRestaurantName setText:[self.detailViewModel[@"name"] description]];
    [self.detailCategoryType setText:[self.detailViewModel[@"category"] description]];
    NSMutableArray *address = self.detailViewModel[@"location"][@"formattedAddress"] ;
    [self.detailFormattedAddress setText:[NSString stringWithFormat:@"%@\n%@\n%@", address[0], address[1], address[2]]];
    [self.detailFormattedPhone setText:[self.detailViewModel[@"contact"][@"formattedPhone"] description]];
    [self.detailTwitter setText:[self.detailViewModel[@"contact"][@"twitter"] description]];
}

- (IBAction)zoomIn:(id)sender
{
    MKUserLocation *userLocation = _mapView.userLocation;
    MKCoordinateRegion region =
    MKCoordinateRegionMakeWithDistance (userLocation.location.coordinate, 20000, 20000);
    [_mapView setRegion:region animated:NO];
}

- (IBAction)changeMapType:(id)sender
{
    if (_mapView.mapType == MKMapTypeStandard)
    {
        _mapView.mapType = MKMapTypeSatellite;
    }
    else
    {
        _mapView.mapType = MKMapTypeStandard;
    }
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    _mapView.centerCoordinate =
    userLocation.location.coordinate;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
