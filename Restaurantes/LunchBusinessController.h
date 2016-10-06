//
//  LunchBusinessController.h
//  Restaurantes
//
//  Created by Jorge Rebollo J on 06/10/16.
//  Copyright © 2016 RGStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ILunchViewControllerDelegate.h"

@protocol ILunchBusinessControllerDelegate;

@interface LunchBusinessController : NSObject <ILunchViewControllerDelegate>

@property (nonatomic, strong) id <ILunchBusinessControllerDelegate> lunchBusinessControllerDelegate;

+ (instancetype)sharedManager;

@end
