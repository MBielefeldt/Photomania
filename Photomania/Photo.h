//
//  Photo.h
//  Photomania
//
//  Created by Mads Bielefeldt on 29/06/13.
//  Copyright (c) 2013 GN ReSound A/S. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Photo : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * subtitle;
@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSString * unique;
@property (nonatomic, retain) NSManagedObject *whoTook;

@end
