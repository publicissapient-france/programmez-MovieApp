//
// Created by Simone Civetta on 9/24/13.
// Copyright (c) 2013 Xebia. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "MAMovie.h"
#import "MAPosters.h"
#import "MAMovieAppAPIClient.h"

@implementation MAMovie

+ (DCParserConfiguration *)mappings {
    DCParserConfiguration *config = [[DCParserConfiguration alloc] init];
    return config;
}

-(void) updateInfoWithCallback:(void (^)(void))callback {
    [[MAMovieAppAPIClient sharedClient] updateMovieData:self withCallback:callback];
}

@end