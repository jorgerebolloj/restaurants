//
//  LunchDetailViewController.h
//  Restaurantes
//
//  Created by Jorge Rebollo J on 07/10/16.
//  Copyright © 2016 RGStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface LunchDetailViewController : UIViewController <MKMapViewDelegate>

@property (nonatomic, strong) NSMutableDictionary *detailViewModel;

- (IBAction)zoomIn:(id)sender;

- (IBAction)changeMapType:(id)sender;

+ (instancetype)sharedManager;

@end
