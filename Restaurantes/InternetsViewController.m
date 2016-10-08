//
//  InternetsViewController.m
//  Restaurantes
//
//  Created by Jorge Rebollo J on 05/10/16.
//  Copyright © 2016 RGStudio. All rights reserved.
//

#import "InternetsViewController.h"

@interface InternetsViewController ()

@property (nonatomic, weak) IBOutlet UIWebView *webView;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *backWebButton;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *refreshWebButton;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *forwardWebButton;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *stopWebButton;

@end

@implementation InternetsViewController

+ (instancetype)sharedManager
{
    static id sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadRequestFromString:@"http://www.bottlerocketstudios.com"];
}

#pragma mark - Web View

- (void)loadRequestFromString:(NSString *)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:urlRequest];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
