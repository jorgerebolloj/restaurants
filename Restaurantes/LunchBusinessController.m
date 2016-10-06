//
//  LunchBusinessController.m
//  Restaurantes
//
//  Created by Jorge Rebollo J on 06/10/16.
//  Copyright © 2016 RGStudio. All rights reserved.
//

#import "LunchBusinessController.h"

@interface LunchBusinessController ()

@property (nonatomic, strong) NSMutableArray *json;

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
        
    }
    return self;
}

- (NSMutableArray *)buildDataModel
{
    self.json = [[NSMutableArray alloc] init];
    NSString *url_string = [NSString stringWithFormat:@"http://sandbox.bottlerocketapps.com/BR_iOS_CodingExam_2015_Server/restaurants.json"];
    NSURL *url = [NSURL URLWithString:url_string];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error)
        {
            NSData *jsonDataFromURL = [NSData dataWithData:data];
            self.json = [NSJSONSerialization JSONObjectWithData:jsonDataFromURL options:kNilOptions error:&error];
        }
    }];
    [task resume];
    return self.json;
}

@end
