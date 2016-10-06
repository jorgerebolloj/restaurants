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

@interface LunchViewController ()

@property (nonatomic, strong) NSMutableArray *viewModel;
@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;

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
    }
    return self;
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    LunchBusinessController *lunchBusiness = [LunchBusinessController sharedManager];
    self.viewModel = [lunchBusiness buildDataModel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
