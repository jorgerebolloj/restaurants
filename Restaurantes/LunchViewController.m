//
//  LunchViewController.m
//  Restaurantes
//
//  Created by Jorge Rebollo J on 05/10/16.
//  Copyright © 2016 RGStudio. All rights reserved.
//

#import "LunchViewController.h"
#import "ILunchViewControllerDelegate.h"
#import "LunchBusinessController.h"
#import "CustomCollectionViewLayout.h"
#import "CustomGridCollectionViewLayout.h"
#import "IModelBasedCell.h"
#import "CustomGridCollectionViewCell.h"
#import "CustomCollectionViewCell.h"


@interface LunchViewController ()

@property (nonatomic, strong) NSMutableArray *viewModel;
@property (nonatomic, strong) CustomGridCollectionViewLayout *customGridCollectionViewLayout;
@property (nonatomic, strong) CustomCollectionViewLayout *customCollectionViewLayout;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) NSString *nameOfCellXib;

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
        _customGridCollectionViewLayout = [[CustomGridCollectionViewLayout alloc] init];
        _customCollectionViewLayout = [[CustomCollectionViewLayout alloc] init];
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _nameOfCellXib = @"";
    }
    return self;
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UINib *customGridCollectionViewCell = [UINib nibWithNibName:@"CustomGridCollectionViewCell" bundle:nil];
    UINib *customCollectionViewCell = [UINib nibWithNibName:@"CustomCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:customGridCollectionViewCell forCellWithReuseIdentifier:@"customGridCollectionViewCell"];
    [self.collectionView registerNib:customCollectionViewCell forCellWithReuseIdentifier:@"customCollectionViewCell"];
    [self.collectionView setDelegate:self];
    [self.collectionView setDataSource:self];
    LunchBusinessController *lunchBusinessController = [LunchBusinessController sharedManager];
    [lunchBusinessController requestBuildDataModel];
}

- (void)viewDidAppear:(BOOL)animated
{
    
}

- (void)setViewModelWithDataModel:(NSMutableArray *)dataModel
{
    if (dataModel)
    {
        self.viewModel = dataModel;
        [self reloadLayout];
    }
}

- (void)reloadLayout
{
    LunchBusinessController *lunchBusinessController = [LunchBusinessController sharedManager];
    NSString *identifier = [lunchBusinessController validateIdentifierToSetCollectionView];
    if (identifier)
    {
        BOOL list = [identifier isEqualToString:@"customCollectionViewCell"];
        self.layout = list ? self.customCollectionViewLayout : self.customGridCollectionViewLayout;
        [self setLayout:self.layout andRegisterCell:identifier];
    }
}

- (void)setLayout:(UICollectionViewFlowLayout *)layout andRegisterCell:(NSString *)identifier
{
    [self.collectionView setCollectionViewLayout:layout];
    [self setNameOfCellXib:identifier];
    [self.collectionView reloadData];
}

#pragma mark : Collection View Datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.viewModel count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = (NSUInteger) indexPath.row;
    UICollectionViewCell <IModelBasedCell> *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.nameOfCellXib forIndexPath:indexPath];
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
    return cellView;
}

/*- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(150, 150);
}*/

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
