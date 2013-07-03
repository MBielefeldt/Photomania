//
//  Photo+MKAnnotation.h
//  Photomania
//
//  Created by Mads Bielefeldt on 03/07/13.
//  Copyright (c) 2013 GN ReSound A/S. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "Photo.h"

@interface Photo (MKAnnotation) <MKAnnotation>

- (UIImage *)thumbnail; // blocks calling thread

@end
