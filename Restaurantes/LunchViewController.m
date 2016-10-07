//
//  LunchViewController.m
//  Restaurantes
//
//  Created by Jorge Rebollo J on 05/10/16.
//  Copyright © 2016 RGStudio. All rights reserved.
//

#import "LunchViewController.h"
#import "IModelBasedCell.h"

@interface LunchViewController ()

@property (nonatomic, strong) NSMutableArray *viewModel;

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
        _viewModel = [NSMutableArray array];
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
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsPath, @"data.json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
    NSMutableDictionary *jsonInfo = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    self.viewModel = jsonInfo[@"restaurants"];
}

#pragma mark : Collection View Datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.viewModel count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{    
    NSUInteger row = (NSUInteger) indexPath.row;
    UICollectionViewCell <IModelBasedCell> *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"customCollectionViewCell" forIndexPath:indexPath];
    
    SEL selector = @selector(setCellWithModel:);
    if ([cell respondsToSelector:selector])
    {
        NSMutableDictionary *cellViewModel = self.viewModel[row];
        [cell setCellWithModel:cellViewModel];
    }
    UICollectionViewCell *cellView = cell;
    cellView.backgroundColor = [UIColor clearColor];
    cellView.backgroundView = [[UIImageView alloc] init];
    cellView.selectedBackgroundView = [[UIImageView alloc] init];
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

#pragma mark CollectionDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
