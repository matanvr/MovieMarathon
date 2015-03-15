//
//  EntryTableViewCell.m
//  Diary
//
//  Created by Kirill Pahnev on 17.8.2014.
//  Copyright (c) 2014 Kirill Pahnev. All rights reserved.
//

#import "MovieEntryTableViewCell.h"
#import "MovieEntry.h"
#import <QuartzCore/QuartzCore.h>


@implementation MovieEntryTableViewCell



- (void)configureCellForEntry:(MovieEntry *)entry {
    
    self.name.text = entry.name;
    self.length.text = entry.length;
    NSString *trimmedRating = [entry.rating stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceCharacterSet]];
    NSString *trimmedGenre = [entry.genre stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceCharacterSet]];
    
    if((trimmedRating.length != 0 && trimmedGenre.length != 0)){
        self.moreInfo.text = [NSString stringWithFormat:@"%@, %@", entry.rating, entry.genre];
    }
    else{
        self.moreInfo.text = @"";
    }
    
    if (entry.imgURL) {
        [self loadImage:entry.imgURL];
        
    }
    
}

- (void) loadImage:(NSString *) url{
    
    
    dispatch_queue_t q = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(q, ^{
        /* Fetch the image from the server... */
        NSURL *imageURL = [[NSURL alloc] initWithString:url];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        UIImage *img = [UIImage imageWithData:imageData];
        dispatch_async(dispatch_get_main_queue(), ^{
            /* This is the main thread again, where we set the tableView's image to
             be what we just fetched. */
            self.mainImageView.image = img;
            self.mainImageView.clipsToBounds = true;
        });
    });
}

@end
