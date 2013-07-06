//
//  PhotosByPhotographerCDTVC.m
//  Photomania
//
//  Created by Mads Bielefeldt on 30/06/13.
//  Copyright (c) 2013 GN ReSound A/S. All rights reserved.
//

#import "PhotosByPhotographerCDTVC.h"
#import "Photo.h"
#import "ImageViewController.h"

@implementation PhotosByPhotographerCDTVC

- (void)setPhotographer:(Photographer *)photographer
{
    _photographer = photographer;
    
    self.title = photographer.name;
    [self setupFetchedResultsController];
}

- (void)setupFetchedResultsController
{
    if (self.photographer.managedObjectContext) {
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Photo"];
        request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"phTitle"
                                                              ascending:YES
                                                               selector:@selector(localizedCaseInsensitiveCompare:)]];
        request.predicate = [NSPredicate predicateWithFormat:@"whoTook = %@", self.photographer];
    
        self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                            managedObjectContext:self.photographer.managedObjectContext
                                                                              sectionNameKeyPath:nil
                                                                                       cacheName:nil];
    }
    else {
        self.fetchedResultsController = nil;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Photo"];
    
    Photo *photo = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = photo.phTitle;
    cell.detailTextLabel.text = photo.phSubtitle;
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = nil;
    
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        indexPath = [self.tableView indexPathForCell:sender];
    }
    
    if (indexPath) {
        if ([segue.identifier isEqualToString:@"setImageURL:"]) {
            if ([segue.destinationViewController respondsToSelector:@selector(setImageURL:)]) {
                Photo *photo = [self.fetchedResultsController objectAtIndexPath:indexPath];
                [segue.destinationViewController performSelector:@selector(setImageURL:)
                                                      withObject:[NSURL URLWithString:photo.imageURLString]];
                [segue.destinationViewController setTitle:photo.phTitle];
            }
        }
    }
}

@end
