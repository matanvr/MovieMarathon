//
//  EntryTableViewCell.h
//  Diary
//
//  Created by Kirill Pahnev on 17.8.2014.
//  Copyright (c) 2014 Kirill Pahnev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MovieEntry;

@interface MovieEntryTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *length;
@property (weak, nonatomic) IBOutlet UILabel *moreInfo;
@property (weak, nonatomic) IBOutlet UIButton *addMovieButton;
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;


- (void)configureCellForEntry:(MovieEntry *)entry;

@end
