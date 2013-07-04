//
//  PhotographerMapViewController.m
//  Photomania
//
//  Created by Mads Bielefeldt on 02/07/13.
//  Copyright (c) 2013 GN ReSound A/S. All rights reserved.
//

#import "PhotographerMapViewController.h"
#import "Photographer.h"

@interface PhotographerMapViewController ()

@end

@implementation PhotographerMapViewController

- (void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    _managedObjectContext = managedObjectContext;
    
    if (self.view.window) {
        [self reload]; // only update if view is loaded
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.managedObjectContext) {
        [self reload];        
    }
}

- (void)reload
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Photographer"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)]];
    request.predicate = [NSPredicate predicateWithFormat:@"photos.@count > 2"];

    NSError *error = nil;
    NSArray *photographers = [self.managedObjectContext executeFetchRequest:request error:&error];
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.mapView addAnnotations:photographers];
}

@end
