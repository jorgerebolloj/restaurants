//
//  LunchBusinessController.h
//  Restaurantes
//
//  Created by Jorge Rebollo J on 06/10/16.
//  Copyright © 2016 RGStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ILunchViewControllerDelegate.h"

@interface LunchBusinessController : NSObject <ILunchViewControllerDelegate>

+ (instancetype)sharedManager;

@end
