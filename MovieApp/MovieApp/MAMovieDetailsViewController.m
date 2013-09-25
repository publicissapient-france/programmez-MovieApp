//
//  MAMovieDetailsViewController.m
//  MovieApp
//
//  Created by Martin Moizard on 24/09/13.
//  Copyright (c) 2013 Xebia. All rights reserved.
//

#import "MAMovieDetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "MAMovie.h"
#import "MAPosters.h"

@interface MAMovieDetailsViewController ()

@end

static const float kRatingAnimationDuration = 1.0;

@implementation MAMovieDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) updateView {
    
    if (!self.isViewLoaded) {
        return;
    }
    
    // Update title
    self.title = [NSString stringWithFormat:@"%@ (%@)", self.movie.title, self.movie.year];
    
    // Update Poster image
    [self.posterImageView setImageWithURL:[NSURL URLWithString:self.movie.posters.profile]];
    
    // Update genre
    self.genreLabel.text = [self.movie.genres componentsJoinedByString:@", "];
    
    // Update runtime
    self.runtimeLabel.text = [NSString stringWithFormat:@"%@ min", self.movie.runtime];
    
    // Update synospis
    self.synopsisTextView.text = self.movie.synopsis;
    
    // Update rating and start animations
    int ratings = [self.movie.ratings[@"audience_score"] intValue];
    self.ratingLabel.text = @"0 %";
    self.ratingImageView.image = (ratings < 50) ? [UIImage imageNamed:@"rotten"] : [UIImage imageNamed:@"fresh"];
    
    [NSTimer scheduledTimerWithTimeInterval:kRatingAnimationDuration/ratings target:self selector:@selector(updateRatingText:) userInfo:nil repeats:YES];
    
    self.ratingImageView.alpha = .0;
    [UIView animateWithDuration:kRatingAnimationDuration animations:^{
        self.ratingImageView.alpha = 1;
    }];
}

-(void) updateRatingText:(NSTimer*)timer {
    int rating = [self.ratingLabel.text intValue] + 1;
    
    self.ratingLabel.text = [NSString stringWithFormat:@"%d %%",rating];
    
    // Stop the timer if our rating has the final value
    if (rating >= [self.movie.ratings[@"audience_score"] intValue]) {
        [timer invalidate];
    }
}

-(void) setMovie:(MAMovie *)movie {
    _movie = movie;
    
    [self.movie updateInfoWithCallback:^{[self performSelectorOnMainThread:@selector(updateView) withObject:nil waitUntilDone:NO];}];
}

@end
