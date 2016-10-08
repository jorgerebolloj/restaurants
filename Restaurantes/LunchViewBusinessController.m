//
//  LunchViewBusinessController.m
//  Restaurantes
//
//  Created by Jorge Rebollo J on 07/10/16.
//  Copyright © 2016 RGStudio. All rights reserved.
//

#import "LunchViewBusinessController.h"

@implementation LunchViewBusinessController

- (void)requestDataModelWithCompletionBlock:(void (^)(BOOL succeeded))completionBlock
{
    // Asynchronous datamodel request
    NSString *url_string = [NSString stringWithFormat:@"http://sandbox.bottlerocketapps.com/BR_iOS_CodingExam_2015_Server/restaurants.json"];
    NSURL *url = [NSURL URLWithString:url_string];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                              {
                                  // Asynchronous response
                                  NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                                  
                                  // Validate success
                                  if (error)
                                  {
                                      // Store Error Report
                                      NSString *errorReport = [NSString stringWithFormat:@"Domain: %@\nError Code: %ld\nDescription: %@\nReason: %@", error.domain, (long)error.code, [error localizedDescription], [error localizedFailureReason]];
                                      NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsPath, @"errors.txt"];
                                      [errorReport writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
                                      if (![errorReport writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil])
                                      {
                                          NSLog(@"Failed to cache the image.");
                                      }
                                      else
                                      {
                                          NSLog(@"The image has been stored in cache. Path: %@",filePath);
                                      }
                                      completionBlock(NO);
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
                                      if (![jsonString writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil])
                                      {
                                          NSLog(@"Failed to cache the image.");
                                      }
                                      else
                                      {
                                          NSLog(@"The image has been stored in cache. Path: %@",filePath);
                                      }
                                      completionBlock(YES);
                                  }
                              }];
    [task resume];
}

@end
