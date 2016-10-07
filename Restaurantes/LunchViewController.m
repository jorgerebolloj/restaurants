//
//  LunchViewController.m
//  Restaurantes
//
//  Created by Jorge Rebollo J on 05/10/16.
//  Copyright © 2016 RGStudio. All rights reserved.
//

#import "LunchViewController.h"
#import "IModelBasedCell.h"
#import "LunchDetailViewController.h"
#import "MapViewController.h"

@interface LunchViewController ()

@property (nonatomic, strong) NSMutableArray *viewModel;
@property (nonatomic, strong) NSMutableDictionary *cellViewModel;
@property (nonatomic, assign) CGFloat cellWidth;
@property (nonatomic, assign) CGFloat currentWidthByOrientation;
@property (nonatomic, assign) CGFloat cellHeight;

@end

@implementation LunchViewController

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
        _viewModel = [[NSMutableArray alloc] init];
        _cellViewModel = [[NSMutableDictionary alloc] init];
        _cellWidth = 0;
        _currentWidthByOrientation = 0;
        _cellHeight = 0;
    }
    return self;
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setLookAndFeelNavigationBar];
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification object:[UIDevice currentDevice]];
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
    [super viewWillAppear:animated];
    [self setDataModel];
    
    // Look and feel navigation bar: so that the window title is not displayed on the back button
    self.navigationItem.title = @"Lunchy Time";
}

- (void)setDataModel
{
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsPath, @"data.json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
    NSMutableDictionary *jsonInfo = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    if (jsonInfo)
    {
        self.viewModel = jsonInfo[@"restaurants"];
    }
    else
    {
        self.viewModel = [NSMutableArray array];
    }
    [self.collectionView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Look and feel navigation bar: so that the window title is not displayed on the back button
    self.navigationItem.title = @"";
}

#pragma mark - Collection View Datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.viewModel count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = (NSUInteger) indexPath.row;
    
    // Set custom cell
    UICollectionViewCell <IModelBasedCell> *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"customCollectionViewCell" forIndexPath:indexPath];
    SEL selector = @selector(setCellWithModel:);
    if ([cell respondsToSelector:selector])
    {
        NSMutableDictionary *cellViewModel = self.viewModel[row];
        [cell setCellWithModel:cellViewModel];
    }
    UICollectionViewCell *cellView = cell;
    
    // Optimize cell
    cellView.layer.shouldRasterize = YES;
    cellView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    return cellView;;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        self.cellWidth = self.currentWidthByOrientation;
        self.cellHeight = self.cellWidth / 2;
    }
    else
    {
        self.cellWidth = [[UIScreen mainScreen] bounds].size.width;
        self.cellHeight = 180;
    }
    return CGSizeMake(self.cellWidth, self.cellHeight);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0,0,0,0);
}

#pragma mark - Collection View Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.cellViewModel = self.viewModel[indexPath.row];
    [self performSegueWithIdentifier:@"detailLunch" sender:self];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"detailLunch"])
    {
        LunchDetailViewController *controller = (LunchDetailViewController *)segue.destinationViewController;
        controller.detailViewModel = self.cellViewModel;
    }
    else if([segue.identifier isEqualToString:@"showMapFromList"])
    {
        MapViewController *controller = (MapViewController *)segue.destinationViewController;
        controller.mapsViewModel = self.viewModel;
    }
}

- (IBAction)showMap
{
    [self performSegueWithIdentifier:@"showMapFromList" sender:self];
}

- (void)orientationChanged:(NSNotification *)note
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        UIDevice * device = note.object;
        switch(device.orientation)
        {
            case UIDeviceOrientationPortrait:
            {
                NSLog(@"// Device oriented vertically, home button on the bottom");
                self.currentWidthByOrientation = [[UIScreen mainScreen] bounds].size.height / 2;
                [self.collectionView reloadData];
                break;
            }
            case UIDeviceOrientationPortraitUpsideDown:
            {
                NSLog(@"// Device oriented vertically, home button on the top");
                self.currentWidthByOrientation = [[UIScreen mainScreen] bounds].size.height / 2;
                [self.collectionView reloadData];
                break;
            }
            case UIDeviceOrientationLandscapeLeft:
            {
                NSLog(@"// Device oriented horizontally, home button on the right");
                self.currentWidthByOrientation = [[UIScreen mainScreen] bounds].size.height / 2;
                [self.collectionView reloadData];
                break;
            }
            case UIDeviceOrientationLandscapeRight:
            {
                NSLog(@"// Device oriented horizontally, home button on the left");
                self.currentWidthByOrientation = [[UIScreen mainScreen] bounds].size.height / 2;
                [self.collectionView reloadData];
                break;
            }
            case UIDeviceOrientationFaceUp:
            {
                NSLog(@"// Device oriented flat, face up");
                self.currentWidthByOrientation = [[UIScreen mainScreen] bounds].size.width / 2;
                [self.collectionView reloadData];
                break;
            }
            case UIDeviceOrientationFaceDown:
            {
                NSLog(@"// Device oriented flat, face down");
                self.currentWidthByOrientation = [[UIScreen mainScreen] bounds].size.width / 2;
                [self.collectionView reloadData];
                break;
            }
            default:
                break;
        };
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
