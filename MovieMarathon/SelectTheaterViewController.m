//
//  SelectTheaterViewController.m
//  MovieMarathon
//
//  Created by Matan Vardi on 3/8/15.
//  Copyright (c) 2015 Matan Vardi. All rights reserved.
//


#import "SelectTheaterViewController.h"
#import "TheaterEntryTableViewCell.h"
@implementation SelectTheaterViewController



-(void) viewDidLoad {
    [super viewDidLoad];
    self.tableView.allowsMultipleSelection = YES;
    NSLog(@"%@", self.movies);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@", indexPath);
    TheaterEntryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    Theater *theater = nil;
    if(indexPath.row != 0){
        theater = [self.theaters objectAtIndex:indexPath.row - 1];
    }
    
    [cell configureCellForEntry:theater];
    /*MovieEntry *movie = [self.movies objectAtIndex:indexPath.row];
    [cell.addMovieButton addTarget:self action:@selector(cellButtonWasTapped:)
                  forControlEvents:UIControlEventTouchUpInside];
    [cell.addMovieButton setTag:indexPath.row];
    [cell configureCellForEntry:movie];
    [self animateButton:cell.addMovieButton];*/
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   // [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TheaterEntryTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.theaters count] + 1;
}


@end