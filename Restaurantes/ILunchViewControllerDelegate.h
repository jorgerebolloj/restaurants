//
//  ILunchViewControllerDelegate.h
//  Restaurantes
//
//  Created by Jorge Rebollo J on 07/10/16.
//  Copyright © 2016 RGStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ILunchViewControllerDelegate <NSObject>

- (void)requestDataModelWithCompletionBlock:(void (^)(BOOL succeeded))completionBlock;

@end
