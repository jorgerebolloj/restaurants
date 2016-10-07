//
//  AppDelegate.m
//  Restaurantes
//
//  Created by Jorge Rebollo J on 05/10/16.
//  Copyright © 2016 RGStudio. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Asynchronous Data Model Request
    NSString *url_string = [NSString stringWithFormat:@"http://sandbox.bottlerocketapps.com/BR_iOS_CodingExam_2015_Server/restaurants.json"];
    NSURL *url = [NSURL URLWithString:url_string];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        if (error)
        {
            // Store Error Report
            NSString *errorReport = [NSString stringWithFormat:@"Domain: %@\nError Code: %ld\nDescription: %@\nReason: %@", error.domain, (long)error.code, [error localizedDescription], [error localizedFailureReason]];
            NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsPath, @"errors.txt"];
            [errorReport writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
        }
        else
        {
            // Store Data Model
            NSString *jsonString;
            NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if ([NSJSONSerialization isValidJSONObject:json])
            {
                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:&error];
                if (data != nil && error == nil)
                {
                    jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                }
            }
            NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsPath, @"data.json"];
            [jsonString writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
        }
    }];
    [task resume];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    
}

@end
