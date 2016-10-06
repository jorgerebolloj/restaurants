//
//  CustomGridCollectionViewCell.m
//  Restaurantes
//
//  Created by Jorge Rebollo J on 06/10/16.
//  Copyright © 2016 RGStudio. All rights reserved.
//

#import "CustomGridCollectionViewCell.h"

@interface CustomGridCollectionViewCell ()

@property (nonatomic, weak) IBOutlet UILabel *restaurantName;
@property (nonatomic, weak) IBOutlet UILabel *categoryType;
@property (nonatomic, weak) IBOutlet UIImageView *restaurantImage;
@property (nonatomic, strong) NSMutableDictionary *customGridModel;

@end

@implementation CustomGridCollectionViewCell

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _customGridModel = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)setCellWithModel:(NSMutableDictionary *)cellModel
{
    self.customGridModel = cellModel;
    [self reloadData];
}

- (void)reloadData
{
    [self.restaurantName setText: [[self.customGridModel valueForKeyPath:@"name"] description]];
    [self.categoryType setText: [[self.customGridModel valueForKeyPath:@"category"] description]];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
}

@end
