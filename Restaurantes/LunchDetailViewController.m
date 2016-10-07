//
//  LunchDetailViewController.m
//  Restaurantes
//
//  Created by Jorge Rebollo J on 07/10/16.
//  Copyright © 2016 RGStudio. All rights reserved.
//

#import "LunchDetailViewController.h"
#import "MapViewController.h"

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
    [self setLookAndFeelNavigationBar];
    
    self.mapView.delegate = self;
    self.mapView.mapType = MKMapTypeStandard;
    self.mapView.showsUserLocation = YES;
}

- (void)setLookAndFeelNavigationBar
{
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor],
                                                                      NSFontAttributeName:[UIFont fontWithName:@"AvenirNext-DemiBold" size:17.0]
                                                                      }];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self setProperties];
    [self setAnnotation];
}

- (void)setProperties
{
    if (self.detailViewModel)
    {
        [self.detailRestaurantName setText:[self.detailViewModel[@"name"] description]];
        [self.detailCategoryType setText:[self.detailViewModel[@"category"] description]];
        NSMutableArray *address = self.detailViewModel[@"location"][@"formattedAddress"];
        [self.detailFormattedAddress setText:[NSString stringWithFormat:@"%@\n%@\n%@", address[0], address[1], address[2]]];
        [self.detailFormattedPhone setText:[self.detailViewModel[@"contact"][@"formattedPhone"] description]];
        [self.detailTwitter setText:[self.detailViewModel[@"contact"][@"twitter"] description]];
    }
}

- (void)setAnnotation
{
    if (self.detailViewModel)
    {
        CLLocationCoordinate2D annotationCoord;
        annotationCoord.latitude = [[self.detailViewModel[@"location"][@"lat"] description] intValue];
        annotationCoord.longitude = [[self.detailViewModel[@"location"][@"lng"] description] intValue];
        MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
        annotationPoint.coordinate = annotationCoord;
        annotationPoint.title = [self.detailViewModel[@"name"] description];
        annotationPoint.subtitle = [self.detailViewModel[@"category"] description];
        [self.mapView addAnnotation:annotationPoint];
    }
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    [self.mapView setCenterCoordinate:userLocation.coordinate animated:YES];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showMapFromDetail"])
    {
        MapViewController *controller = (MapViewController *)segue.destinationViewController;
        controller.singleMapViewModel = self.detailViewModel;
    }
}

- (IBAction)showMap
{
    [self performSegueWithIdentifier:@"showMapFromDetail" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
