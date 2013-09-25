//
// Created by Simone Civetta on 9/24/13.
// Copyright (c) 2013 Xebia. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "XBMappingProvider.h"

@class MAPosters;

@interface MAMovie : NSObject<XBMappingProvider>

@property (nonatomic, strong) NSString *internalBaseClassIdentifier;
@property (nonatomic, strong) NSString *synopsis;
@property (nonatomic, strong) NSArray *abridgedCast;
@property (nonatomic, strong) NSString *criticsConsensus;
@property (nonatomic, strong) NSString *mpaaRating;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSNumber *runtime;
@property (nonatomic, strong) NSNumber *year;
@property (nonatomic, strong) MAPosters *posters;
@property (nonatomic, strong) NSDictionary *ratings;
@property (nonatomic, strong) NSArray *genres;
@property (nonatomic, strong) NSDictionary *links;

-(void) updateInfoWithCallback:(void (^)(void))callback;

@end