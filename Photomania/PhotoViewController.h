//
//  PhotoViewController.h
//  Photomania
//
//  Created by Mads Bielefeldt on 07/07/13.
//  Copyright (c) 2013 GN ReSound A/S. All rights reserved.
//

#import "ImageViewController.h"
#import "Photo.h"

@interface PhotoViewController : ImageViewController

@property (nonatomic,strong) Photo *photo;

@end
