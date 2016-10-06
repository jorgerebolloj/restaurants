//
//  LunchViewController.h
//  Restaurantes
//
//  Created by Jorge Rebollo J on 05/10/16.
//  Copyright © 2016 RGStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ILunchViewControllerDelegate;

@interface LunchViewController : UIViewController

@property (nonatomic, strong) id <ILunchViewControllerDelegate> lunchViewControllerDelegate;

+ (instancetype)sharedManager;

@end
