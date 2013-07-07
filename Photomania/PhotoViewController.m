//
//  PhotoViewController.m
//  Photomania
//
//  Created by Mads Bielefeldt on 07/07/13.
//  Copyright (c) 2013 GN ReSound A/S. All rights reserved.
//

#import "PhotoViewController.h"
#import "MapViewController.h"
#import "Photo+MKAnnotation.h"

@interface PhotoViewController ()

@property (nonatomic, strong) MapViewController *mapVC;

@end

@implementation PhotoViewController

- (void)setPhoto:(Photo *)photo
{
    _photo = photo;
    
    self.title = self.photo.phTitle;
    self.imageURL = [NSURL URLWithString:self.photo.imageURLString];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.mapVC.mapView addAnnotation:self.photo];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"EmbeddedMapForPhoto"]) {
        if ([segue.destinationViewController isKindOfClass:[MapViewController class]]) {
            self.mapVC = segue.destinationViewController;
        }
    }
}

@end
