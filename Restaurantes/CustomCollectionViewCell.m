//
//  CustomCollectionViewCell.m
//  Restaurantes
//
//  Created by Jorge Rebollo J on 06/10/16.
//  Copyright © 2016 RGStudio. All rights reserved.
//

#import "CustomCollectionViewCell.h"

@interface CustomCollectionViewCell ()

@property (nonatomic, weak) IBOutlet UILabel *restaurantName;
@property (nonatomic, weak) IBOutlet UILabel *categoryType;
@property (nonatomic, weak) IBOutlet UIImageView *restaurantImage;
@property (nonatomic, strong) NSMutableDictionary *customListModel;

@end

@implementation CustomCollectionViewCell

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _customListModel = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)setCellWithModel:(NSMutableDictionary *)cellModel
{
    self.customListModel = cellModel;
    [self reloadData];
}

- (void)reloadData
{
    [self.restaurantName setText: [[self.customListModel valueForKeyPath:@"name"] description]];
    [self.categoryType setText: [[self.customListModel valueForKeyPath:@"category"] description]];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
}

@end
