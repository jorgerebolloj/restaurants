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

@interface LunchViewController ()

@property (nonatomic, strong) NSMutableArray *viewModel;
@property (nonatomic, strong) NSMutableDictionary *cellViewModel;

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
    }
    return self;
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Look and feel navigation bar
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont fontWithName:@"AvenirNext-DemiBold" size:17.0]}];
    self.navigationController.navigationBar.translucent = NO;
    
    // Set datamodel
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsPath, @"data.json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
    NSMutableDictionary *jsonInfo = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    self.viewModel = jsonInfo[@"restaurants"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Look and feel navigation bar: so that the window title is not displayed on the back button
    self.navigationItem.title = @"Lunchy Time";
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
    CGFloat cellWidth;
    CGFloat cellHeight;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        cellWidth = [[UIScreen mainScreen] bounds].size.width / 2;
        cellHeight = cellWidth;
    }
    else
    {
        cellWidth = [[UIScreen mainScreen] bounds].size.width;
        cellHeight = 180;
    }
    return CGSizeMake(cellWidth, cellHeight);
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
    if([segue.identifier isEqualToString:@"detailLunch"])
    {
        LunchDetailViewController *controller = (LunchDetailViewController *)segue.destinationViewController;
        controller.detailViewModel = self.cellViewModel;
    }
}

- (IBAction)showMap
{
    NSLog(@"Awsome!!!");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
