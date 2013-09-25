//
//  MAMovieDetailsViewController.h
//  MovieApp
//
//  Created by Martin Moizard on 24/09/13.
//  Copyright (c) 2013 Xebia. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MAMovie;

@interface MAMovieDetailsViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIView *headerView;
@property (nonatomic, weak) IBOutlet UIImageView *posterImageView;
@property (nonatomic, weak) IBOutlet UILabel *genreLabel;
@property (nonatomic, weak) IBOutlet UILabel *runtimeLabel;
@property (nonatomic, weak) IBOutlet UIImageView *ratingImageView;
@property (nonatomic, weak) IBOutlet UILabel *ratingLabel;
@property (nonatomic, weak) IBOutlet UITextView *synopsisTextView;

@property (nonatomic, strong) MAMovie *movie;

@end
