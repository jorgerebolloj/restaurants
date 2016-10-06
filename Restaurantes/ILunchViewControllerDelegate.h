//
//  ILunchViewControllerDelegate.h
//  Restaurantes
//
//  Created by Jorge Rebollo J on 06/10/16.
//  Copyright © 2016 RGStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ILunchViewControllerDelegate <NSObject>

- (void)requestBuildDataModel;

- (NSString *)validateIdentifierToSetCollectionView;

@end
