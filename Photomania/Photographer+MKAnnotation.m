//
//  Photographer+MKAnnotation.m
//  Photomania
//
//  Created by Mads Bielefeldt on 03/07/13.
//  Copyright (c) 2013 GN ReSound A/S. All rights reserved.
//

#import "Photographer+MKAnnotation.h"

@implementation Photographer (MKAnnotation)

- (NSString *)title
{
    return self.name;
}

- (NSString *)subtitle
{
    return [NSString stringWithFormat:@"%d photos", [self.photos count]];
}

- (CLLocationCoordinate2D)coordinate
{
    return [[self.photos anyObject] coordinate];
}

@end
