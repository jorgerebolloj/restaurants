//
//  CustomCollectionViewLayout.m
//  Restaurantes
//
//  Created by Jorge Rebollo J on 06/10/16.
//  Copyright © 2016 RGStudio. All rights reserved.
//

#import "CustomCollectionViewLayout.h"

@implementation CustomCollectionViewLayout

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.itemSize = CGSizeMake(480, 180);
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.minimumLineSpacing = 0;
        self.minimumInteritemSpacing = 0;
    }
    return self;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *attribs = [super layoutAttributesForElementsInRect:rect];
    return attribs;
}

@end
