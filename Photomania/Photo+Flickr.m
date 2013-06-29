//
//  Photo+Flickr.m
//  Photomania
//
//  Created by Mads Bielefeldt on 29/06/13.
//  Copyright (c) 2013 GN ReSound A/S. All rights reserved.
//

#import "Photo+Flickr.h"

#import "FlickrFetcher.h"

@implementation Photo (Flickr)

- (Photo *)photoWithFlickrInfo:(NSDictionary *)photoDictionary InManagedObjectContext:(NSManagedObjectContext *)context
{
    Photo *photo = nil;
    
    photo = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:context];
    
    photo.title = [photoDictionary[FLICKR_PHOTO_TITLE] description];
    photo.subtitle = [[photoDictionary valueForKeyPath:FLICKR_PHOTO_DESCRIPTION] description];
    photo.imageURL = [[FlickrFetcher urlForPhoto:photoDictionary format:FlickrPhotoFormatLarge] absoluteString];
    
    
    return photo;
}

@end
