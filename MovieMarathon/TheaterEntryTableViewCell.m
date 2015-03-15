//
//  EntryTableViewCell.m
//  Diary
//
//  Created by Kirill Pahnev on 17.8.2014.
//  Copyright (c) 2014 Kirill Pahnev. All rights reserved.
//

#import "TheaterEntryTableViewCell.h"
#import "Theater.h"
#import <QuartzCore/QuartzCore.h>


@implementation TheaterEntryTableViewCell



- (void)configureCellForEntry:(Theater *)entry {
    if(entry)
        self.theaterName.text = entry.name;
    else
        self.theaterName.text = @"All Theaters";
    
}

@end
