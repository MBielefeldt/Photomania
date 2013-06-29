//
//  Photo+Flickr.h
//  Photomania
//
//  Created by Mads Bielefeldt on 29/06/13.
//  Copyright (c) 2013 GN ReSound A/S. All rights reserved.
//

#import "Photo.h"

@interface Photo (Flickr)

- (Photo *)photoWithFlickrInfo:(NSDictionary *)photoDictionary
        InManagedObjectContext:(NSManagedObjectContext *)context;

@end
