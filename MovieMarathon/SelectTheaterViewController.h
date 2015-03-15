//
//  SelectTheaterViewController.h
//  MovieMarathon
//
//  Created by Matan Vardi on 3/8/15.
//  Copyright (c) 2015 Matan Vardi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Theater.h"
@interface SelectTheaterViewController : UITableViewController

@property(strong,nonatomic) NSMutableSet *movies;
@property(strong,nonatomic) NSMutableArray *theaters;
@end

