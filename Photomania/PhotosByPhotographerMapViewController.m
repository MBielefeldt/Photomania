//
//  PhotosByPhotographerMapViewController.m
//  Photomania
//
//  Created by Mads Bielefeldt on 02/07/13.
//  Copyright (c) 2013 GN ReSound A/S. All rights reserved.
//

#import "PhotosByPhotographerMapViewController.h"
#import "Photo+MKAnnotation.h"

@interface PhotosByPhotographerMapViewController ()

@end

@implementation PhotosByPhotographerMapViewController

- (void)setPhotographer:(Photographer *)photographer
{
    _photographer = photographer;
    
    self.title = photographer.name;
    if (self.view.window) {
        [self reload];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self reload];
}

- (void)reload
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Photo"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"phTitle"
                                                              ascending:YES
                                                               selector:@selector(localizedCaseInsensitiveCompare:)]];
    request.predicate = [NSPredicate predicateWithFormat:@"whoTook = %@", self.photographer];
    NSArray *photos = [self.photographer.managedObjectContext executeFetchRequest:request error:NULL];
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.mapView addAnnotations:photos];
    
    Photo *photo = [photos lastObject];
    if (photo) {
        self.mapView.centerCoordinate = photo.coordinate;
    }
}

@end
