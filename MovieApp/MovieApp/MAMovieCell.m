//
//  MAMovieCell.m
//  MovieApp
//
//  Created by Nicolas Thenoz on 05/07/13.
//  Copyright (c) 2013 Xebia. All rights reserved.
//

#import "MAMovieCell.h"

@implementation MAMovieCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
