//
//  LunchBusinessController.m
//  Restaurantes
//
//  Created by Jorge Rebollo J on 06/10/16.
//  Copyright © 2016 RGStudio. All rights reserved.
//

#import "LunchBusinessController.h"
#import "ILunchBusinessControllerDelegate.h"
#import "LunchViewController.h"

@interface LunchBusinessController ()

@property (nonatomic, strong) NSMutableDictionary *json;
@property (nonatomic, strong) NSString *collectionViewIdentifier;

@end

@implementation LunchBusinessController

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
        _json = [[NSMutableDictionary alloc] init];
        _collectionViewIdentifier = [[NSString alloc] init];
    }
    return self;
}

- (void)requestBuildDataModel
{
    NSString *url_string = [NSString stringWithFormat:@"http://sandbox.bottlerocketapps.com/BR_iOS_CodingExam_2015_Server/restaurants.json"];
    NSURL *url = [NSURL URLWithString:url_string];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error)
        {
            NSData *jsonDataFromURL = [NSData dataWithData:data];
            self.json = [NSJSONSerialization JSONObjectWithData:jsonDataFromURL options:kNilOptions error:&error];
            LunchViewController *lunchViewController = [LunchViewController sharedManager];
            [lunchViewController setViewModelWithDataModel:self.json[@"restaurants"]];
        }
    }];
    [task resume];
    
    /*NSError *error;
    NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:url_string]];
    self.json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    LunchViewController *lunchViewController = [LunchViewController sharedManager];
    [lunchViewController setViewModelWithDataModel:self.json[@"restaurants"]];*/
    
}

- (NSString *)validateIdentifierToSetCollectionView
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        self.collectionViewIdentifier = @"customGridCollectionViewCell";
    }
    else
    {
        self.collectionViewIdentifier = @"customCollectionViewCell";
    }
    return self.collectionViewIdentifier;
}

@end
