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
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) NSMutableDictionary *customListModel;
@property (nonatomic, strong) NSString *urlImageString;

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
    [self setImage];
    [self reloadData];
}

- (void)setImage
{
    [_activityIndicator startAnimating];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        _urlImageString = [self.customListModel[@"backgroundImageURL"] description];
        UIImage *image = [self searchCacheImage:_urlImageString];
        if (image == NULL)
        {
            NSURL *imageURL = [NSURL URLWithString:_urlImageString];
            NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
            dispatch_sync(dispatch_get_main_queue(), ^{
                [_activityIndicator stopAnimating];
                [_activityIndicator setHidden:YES];
                self.restaurantImage.image = [UIImage imageWithData:imageData];
                [self storeImage:[UIImage imageWithData:imageData]];
            });
        }
        else
        {
            dispatch_sync(dispatch_get_main_queue(), ^{
                [_activityIndicator stopAnimating];
                [_activityIndicator setHidden:YES];
                self.restaurantImage.image = image;
            });
        }
    });
}

- (void)reloadData
{
    [self.restaurantName setText:[self.customListModel[@"name"] description]];
    [self.categoryType setText:[self.customListModel [@"category"] description]];
}

-(void)storeImage:(UIImage *)image
{
    NSString *imageName = [self extractImageName];
    if ([imageName length] > 0)
    {
        NSData *imgData = UIImagePNGRepresentation(image);
        NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *imagePath = [NSString stringWithFormat:@"%@/%@%@", documentsPath, imageName, @".png"];
        if (![imgData writeToFile:imagePath atomically:NO])
        {
            NSLog(@"Fallo al cachear la imagen");
        }
        else
        {
            NSLog(@"La imagen ha sido cacheada. Path: %@",imagePath);
        }
    }
}

- (NSString *)extractImageName
{
    NSString *imageName = @"";
    NSArray *lines = [_urlImageString componentsSeparatedByString: @"/"];
    if ([lines count] == 3)
    {
        imageName = lines[2];
        if ([imageName rangeOfString:@"png"].location != NSNotFound ||
            [imageName rangeOfString:@"jpg"].location != NSNotFound ||
            [imageName rangeOfString:@"jpeg"].location != NSNotFound)
        {
            NSRange range = [imageName rangeOfString:@".png"];
            if (range.location == NSNotFound)
            {
                range = [imageName rangeOfString:@".jpg"];
                if (range.location == NSNotFound)
                {
                    range = [imageName rangeOfString:@".jpeg"];
                }
            }
            NSRange searchRange = NSMakeRange(0 , range.location);
            imageName = [imageName substringWithRange:searchRange];
        }
    }
    return imageName;
}

- (UIImage *)searchCacheImage:(NSString *)path
{
    UIImage *customImage = NULL;
    NSString *imageName = [self extractImageName];
    if ([imageName length] > 0)
    {
        NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *imagePath = [NSString stringWithFormat:@"%@/%@%@", documentsPath, imageName, @".png"];
        customImage = [UIImage imageWithContentsOfFile: imagePath];
    }
    return customImage;
}

@end
