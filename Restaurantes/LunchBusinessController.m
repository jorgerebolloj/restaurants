//
//  LunchBusinessController.m
//  Restaurantes
//
//  Created by Jorge Rebollo J on 06/10/16.
//  Copyright © 2016 RGStudio. All rights reserved.
//

#import "LunchBusinessController.h"

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
        
    }
    return self;
}

- (NSMutableArray *)buildDataModel
{
    NSError *error;
    NSString *url_string = [NSString stringWithFormat:@"http://sandbox.bottlerocketapps.com/BR_iOS_CodingExam_2015_Server/restaurants.json"];
    NSData *jsonDataFromURL = [NSData dataWithContentsOfURL:[NSURL URLWithString:url_string]];
    NSMutableArray *json = [NSJSONSerialization JSONObjectWithData:jsonDataFromURL options:kNilOptions error:&error];
    return json;
}

@end
