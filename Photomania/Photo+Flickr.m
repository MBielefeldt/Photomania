//
//  Photo+Flickr.m
//  Photomania
//
//  Created by Mads Bielefeldt on 29/06/13.
//  Copyright (c) 2013 GN ReSound A/S. All rights reserved.
//

#import "Photo+Flickr.h"
#import "Photographer+Create.h"

#import "FlickrFetcher.h"

@implementation Photo (Flickr)

+ (Photo *)photoWithFlickrInfo:(NSDictionary *)photoDictionary inManagedObjectContext:(NSManagedObjectContext *)context
{
    Photo *photo = nil;

    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Photo"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES]];
    request.predicate = [NSPredicate predicateWithFormat:@"unique = %@", [photoDictionary[FLICKR_PHOTO_ID] description]];
    
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error];
                         
    if (matches == nil || matches.count > 1) {
        // handle error
    }
    else if (matches.count == 0) {
        photo = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:context];
        
        photo.unique = [photoDictionary[FLICKR_PHOTO_ID] description];
        photo.title = [photoDictionary[FLICKR_PHOTO_TITLE] description];
        photo.subtitle = [photoDictionary valueForKeyPath:FLICKR_PHOTO_DESCRIPTION];
        photo.latitude = photoDictionary[FLICKR_LATITUDE];
        photo.longitude = photoDictionary[FLICKR_LONGITUDE];
        photo.imageURLString = [[FlickrFetcher urlForPhoto:photoDictionary format:FlickrPhotoFormatLarge] absoluteString];
        photo.thumbnailURLString = [[FlickrFetcher urlForPhoto:photoDictionary format:FlickrPhotoFormatSquare] absoluteString];
        
        NSString *photographerName = [photoDictionary[FLICKR_PHOTO_OWNER] description];
        Photographer *photographer = [Photographer photographerWithName:photographerName inManagedObjectContext:context];
        photo.whoTook = photographer;
    }
    else
    {
        photo = [matches lastObject];
    }
                         
    return photo;
}

@end
