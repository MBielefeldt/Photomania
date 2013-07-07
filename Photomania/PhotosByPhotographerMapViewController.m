//
//  PhotosByPhotographerMapViewController.m
//  Photomania
//
//  Created by Mads Bielefeldt on 02/07/13.
//  Copyright (c) 2013 GN ReSound A/S. All rights reserved.
//

#import "PhotosByPhotographerMapViewController.h"
#import "Photo+MKAnnotation.h"
#import "PhotoViewController.h"

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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"setPhoto:"]) {
        if ([sender isKindOfClass:[MKAnnotationView class]]) {
            MKAnnotationView *annotationView = sender;
            if ([annotationView.annotation isKindOfClass:[Photo class]]) {
                Photo *photo = annotationView.annotation;
                
                if ([segue.destinationViewController respondsToSelector:@selector(setPhoto:)]) {
                    [segue.destinationViewController performSelector:@selector(setPhoto:) withObject:photo];
                }
            }
        }
    }
    
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    [self performSegueWithIdentifier:@"setPhoto:" sender:view];
}

@end
