//
//  LunchViewController.m
//  Restaurantes
//
//  Created by Jorge Rebollo J on 05/10/16.
//  Copyright © 2016 RGStudio. All rights reserved.
//

#import "LunchViewController.h"

@interface LunchViewController ()

@end

@implementation LunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIColor *grayTabColor = [UIColor colorWithRed:37/255.0 green:37/255.0 blue:37/255.0 alpha:1];
    self.navigationController.navigationBar.tintColor = grayTabColor;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
