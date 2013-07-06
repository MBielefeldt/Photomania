//
//  Photo.h
//  Photomania
//
//  Created by Mads Bielefeldt on 06/07/13.
//  Copyright (c) 2013 GN ReSound A/S. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Photographer;

@interface Photo : NSManagedObject

@property (nonatomic, retain) NSString * imageURLString;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * phSubtitle;
@property (nonatomic, retain) NSString * thumbnailURLString;
@property (nonatomic, retain) NSString * phTitle;
@property (nonatomic, retain) NSString * unique;
@property (nonatomic, retain) Photographer *whoTook;

@end
