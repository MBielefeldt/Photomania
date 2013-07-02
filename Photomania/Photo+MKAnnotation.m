//
//  Photo+MKAnnotation.m
//  Photomania
//
//  Created by Mads Bielefeldt on 03/07/13.
//  Copyright (c) 2013 GN ReSound A/S. All rights reserved.
//

#import "Photo+MKAnnotation.h"

@implementation Photo (MKAnnotation)

- (CLLocationCoordinate2D)coordinate
{
    CLLocationCoordinate2D coordinate;
    
    coordinate.latitude = [self.latitude doubleValue];
    coordinate.longitude = [self.longitude doubleValue];
    
    return coordinate;
}

- (UIImage *)thumbnail
{
    NSURL *url = [NSURL URLWithString:self.thumbnailURLString];
    
    return [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
}

@end
