//
//  PhotoViewController.m
//  Photomania
//
//  Created by Mads Bielefeldt on 07/07/13.
//  Copyright (c) 2013 GN ReSound A/S. All rights reserved.
//

#import "PhotoViewController.h"

@interface PhotoViewController ()

@end

@implementation PhotoViewController

- (void)setPhoto:(Photo *)photo
{
    _photo = photo;
    
    self.title = self.photo.phTitle;
    self.imageURL = [NSURL URLWithString:self.photo.imageURLString];
}

@end
