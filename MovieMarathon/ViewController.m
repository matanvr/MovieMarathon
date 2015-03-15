//
//  ViewController.m
//  MovieMarathon
//
//  Created by Matan Vardi on 3/8/15.
//  Copyright (c) 2015 Matan Vardi. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "MovieEntry.h"
#import "SelectTheaterViewController.h"
#import "MovieEntryTableViewCell.h"
@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIBarButtonItem *nextButton;
- (IBAction)pressedNext:(id)sender;

@property (nonatomic, strong) NSMutableSet *selectedMovies;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.movies = [[NSMutableArray alloc] init];
    self.theaters = [[NSMutableArray alloc] init];
    self.selectedMovies = [[NSMutableSet alloc] init];
    [self fetchAllMovies];
    [self hideAndDisableRightNavigationItem];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void) hideAndDisableRightNavigationItem {
    [self.nextButton setTintColor:[UIColor clearColor]];
    [self.nextButton setEnabled:NO];
}

-(void) showAndEnableRightNavigationItem
{
    [self.nextButton setTintColor:[UIColor blackColor]];
    [self.nextButton setEnabled:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) fetchAllMovies {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://moviehopper.herokuapp.com/API.php?zip=94087" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dictionary = (NSDictionary *) responseObject;
        NSDictionary *moviesDict = (NSDictionary *) dictionary[@"movies"];
        for(id key in moviesDict){
            NSDictionary *movieDict = (NSDictionary *)[moviesDict objectForKey:key];
            MovieEntry *movieObject = [[MovieEntry alloc] init];
            //NSLog(@"key=%@ value=%@", key, movieDict[@"name"]);
            movieObject.name = movieDict[@"name"];
            movieObject.length = movieDict[@"length"];
            movieObject.rating = movieDict[@"rating"];
            movieObject.imgURL = movieDict[@"img"];
            movieObject.genre = movieDict[@"genre"];
            movieObject.mid = movieDict[@"id"];
            [self.movies addObject:movieObject];
        }
        [self.tableView reloadData];
        NSDictionary *theatersDict = (NSDictionary *) dictionary[@"theaters"];
        for (id key in theatersDict){
            NSDictionary *theaterDict = [theatersDict objectForKey:key];
            Theater *theater = [[Theater alloc] init];
            theater.name = theaterDict[@"name"];
            
            //Store all movie times
            NSMutableDictionary *movieTimes = [[NSMutableDictionary alloc] init];
            
            NSArray *movies = (NSArray *) theaterDict[@"movies"];
            for (id movie in movies){
                NSMutableArray *timesInDict = [[NSMutableArray alloc] init];
                NSArray *times = (NSArray *) movie[@"times"];
                for (id time in times){
                    [timesInDict addObject:time];
                }
                [movieTimes setObject:timesInDict forKey:movie[@"id"]];
            }
            theater.movieTimes = movieTimes;
            [self.theaters addObject:theater];
            
        }
        

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@", indexPath);
    MovieEntryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    MovieEntry *movie = [self.movies objectAtIndex:indexPath.row];
    [cell.addMovieButton addTarget:self action:@selector(cellButtonWasTapped:)
        forControlEvents:UIControlEventTouchUpInside];
    [cell.addMovieButton setTag:indexPath.row];
    [cell configureCellForEntry:movie];
    [self animateButton:cell.addMovieButton];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MovieEntryTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self cellButtonWasTapped:cell.addMovieButton];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.movies count];
}


- (void)animateButton:(UIButton *)sender {
    NSLog(@"I clicked %d", sender.tag);

    MovieEntry *movie = [self.movies objectAtIndex:sender.tag];
    if([self.selectedMovies containsObject:movie]){
        [sender setSelected:YES];
        
    } else{
      
        [sender setSelected:NO];
    }
}

-(void) cellButtonWasTapped:(UIButton *) sender {
    MovieEntry *movie = [self.movies objectAtIndex:sender.tag];
    if(![self.selectedMovies containsObject:movie]){
        [self.selectedMovies addObject:movie];
        [sender setSelected:YES];
        
    } else{
        [self.selectedMovies removeObject:movie];
        [sender setSelected:NO];
    }
    if(self.selectedMovies.count > 0){
        [self showAndEnableRightNavigationItem];
    } else{
        [self hideAndDisableRightNavigationItem];
    }
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"SelectTheaters"])
    {
        // Get reference to the destination view controller
         SelectTheaterViewController *vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        [vc setMovies:self.selectedMovies];
        [vc setTheaters:self.theaters];
    }
}


- (IBAction)pressedNext:(id)sender {
}
@end
