//
//  MapViewController.m
//  Photomania
//
//  Created by Mads Bielefeldt on 02/07/13.
//  Copyright (c) 2013 GN ReSound A/S. All rights reserved.
//

#import "MapViewController.h"
#import "Photo+MKAnnotation.h"

@interface MapViewController ()

@property (nonatomic) BOOL needUpdateRegion;

@end

@implementation MapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.mapView.delegate = self;
    
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(55.59, 13.42);
    MKCoordinateSpan span = MKCoordinateSpanMake(30.0, 30.0);
    MKCoordinateRegion region = MKCoordinateRegionMake(center, span);
    [self.mapView setRegion:region];
    
    self.needUpdateRegion = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.needUpdateRegion) {
        [self updateRegion];
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    NSString *reuseId = @"MapViewController";
    
    MKAnnotationView *view = [mapView dequeueReusableAnnotationViewWithIdentifier:reuseId];
    if (!view) {
        view = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseId];
        
        view.canShowCallout = YES;
        if ([mapView.delegate respondsToSelector:@selector(mapView:annotationView:calloutAccessoryControlTapped:)]) {
            view.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        }
        view.leftCalloutAccessoryView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    }

    if ([view.leftCalloutAccessoryView isKindOfClass:[UIImageView class]]) {
        UIImageView *imageView = (UIImageView *)view.leftCalloutAccessoryView;
        imageView.image = nil;
    }
    
    return view;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    if ([view.leftCalloutAccessoryView isKindOfClass:[UIImageView class]]) {
        if ([view.annotation respondsToSelector:@selector(thumbnail)]) {
            UIImageView *imageView = (UIImageView *)view.leftCalloutAccessoryView;
            imageView.image = [view.annotation performSelector:@selector(thumbnail)]; // this should be done as GCD to avoid blocking the thread
        }
    }
}

- (void)updateRegion
{
    self.needUpdateRegion = NO;
    
    CGRect boundingRect;
    BOOL started = NO;
    
    for (id <MKAnnotation> annotation in self.mapView.annotations) {
        CGRect annotationRect = CGRectMake(annotation.coordinate.latitude, annotation.coordinate.longitude, 0, 0);
        if (!started) {
            started = YES;
            boundingRect = annotationRect;
        }
        else {
            boundingRect = CGRectUnion(boundingRect, annotationRect);
        }
    }
    
    if (started) {
        boundingRect = CGRectInset(boundingRect, -0.2, -0.2);
        
        if (boundingRect.size.width < 20 && boundingRect.size.height < 20) {
            MKCoordinateRegion region;
            region.center.latitude = boundingRect.origin.x + boundingRect.size.width / 2;
            region.center.longitude = boundingRect.origin.y + boundingRect.size.height / 2;
            region.span.latitudeDelta = boundingRect.size.width;
            region.span.longitudeDelta = boundingRect.size.height;
            [self.mapView setRegion:region animated:YES];
        }
    }
}

@end
