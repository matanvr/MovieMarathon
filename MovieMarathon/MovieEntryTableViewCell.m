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
        NSString *completeURL = [NSString stringWithFormat:@"%@%@", @"http:", entry.imgURL];
        NSURL *imageURL = [[NSURL alloc] initWithString:completeURL];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        self.mainImageView.image = [UIImage imageWithData:imageData];
        self.mainImageView.clipsToBounds = true;
        
    }
    
}

@end
