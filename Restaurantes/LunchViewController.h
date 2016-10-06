//
//  LunchViewController.h
//  Restaurantes
//
//  Created by Jorge Rebollo J on 05/10/16.
//  Copyright © 2016 RGStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ILunchBusinessControllerDelegate.h"

@protocol ILunchViewControllerDelegate;

@interface LunchViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ILunchBusinessControllerDelegate>

@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) id <ILunchViewControllerDelegate> lunchViewControllerDelegate;

+ (instancetype)sharedManager;

@end
