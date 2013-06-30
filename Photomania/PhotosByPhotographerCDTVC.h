//
//  PhotosByPhotographerCDTVC.h
//  Photomania
//
//  Created by Mads Bielefeldt on 30/06/13.
//  Copyright (c) 2013 GN ReSound A/S. All rights reserved.
//

#import "CoreDataTableViewController.h"
#import "Photographer.h"

@interface PhotosByPhotographerCDTVC : CoreDataTableViewController

@property (nonatomic, strong) Photographer *photographer;

@end
