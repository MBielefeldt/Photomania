//
//  DemoPhotographerMapViewController.m
//  Photomania
//
//  Created by Mads Bielefeldt on 02/07/13.
//  Copyright (c) 2013 GN ReSound A/S. All rights reserved.
//

#import "DemoPhotographerMapViewController.h"
#import "FlickrFetcher.h"
#import "Photo+Flickr.h"

@interface DemoPhotographerMapViewController ()

@end

@implementation DemoPhotographerMapViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!self.managedObjectContext) [self useDemoDocument];
}

- (void)useDemoDocument
{
    NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    url = [url URLByAppendingPathComponent:@"Demo Document iPad"];
    
    UIManagedDocument *document = [[UIManagedDocument alloc] initWithFileURL:url];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:[url path]]) {
        // create it
        [document saveToURL:url
           forSaveOperation:UIDocumentSaveForCreating
          completionHandler:^(BOOL success) {
              if (success) {
                  self.managedObjectContext = document.managedObjectContext;
                  [self refresh];
              }
          }];
    }
    else if (document.documentState == UIDocumentStateClosed) {
        // open it
        [document openWithCompletionHandler:^(BOOL success) {
            if (success) {
                self.managedObjectContext = document.managedObjectContext;
                [self refresh];
            }
        }];
    }
    else {
        // try to use it
        self.managedObjectContext = document.managedObjectContext;
    }
}

- (void)refresh
{
    dispatch_queue_t fetchQ = dispatch_queue_create("Flickr Fetch Queue", NULL);
    dispatch_async(fetchQ, ^{
        NSArray *photos = [FlickrFetcher latestGeoreferencedPhotos];
        // put photos in core data database
        [self.managedObjectContext performBlock:^{
            for (NSDictionary *photo in photos) {
                [Photo photoWithFlickrInfo:photo inManagedObjectContext:self.managedObjectContext];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self reload];
            });
        }];
    });
}

@end
