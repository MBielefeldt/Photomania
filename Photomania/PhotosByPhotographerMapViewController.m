//
//  PhotosByPhotographerMapViewController.m
//  Photomania
//
//  Created by Mads Bielefeldt on 02/07/13.
//  Copyright (c) 2013 GN ReSound A/S. All rights reserved.
//

#import "PhotosByPhotographerMapViewController.h"

@interface PhotosByPhotographerMapViewController ()

@end

@implementation PhotosByPhotographerMapViewController

- (void)setPhotographer:(Photographer *)photographer
{
    _photographer = photographer;
    
    self.title = photographer.name;
    if (self.view.window) {
        [self reload];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self reload];
}

- (void)reload
{
    
}

@end
