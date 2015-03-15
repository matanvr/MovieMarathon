//
//  EntryTableViewCell.h
//  Diary
//
//  Created by Kirill Pahnev on 17.8.2014.
//  Copyright (c) 2014 Kirill Pahnev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Theater;

@interface TheaterEntryTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *theaterName;

- (void)configureCellForEntry:(Theater *)entry;

@end



