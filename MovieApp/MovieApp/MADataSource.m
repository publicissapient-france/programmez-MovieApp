//
//  MADataSource.m
//  MovieApp
//
//  Created by Nicolas Thenoz on 05/07/13.
//  Copyright (c) 2013 Xebia. All rights reserved.
//

#import "MADataSource.h"

static const NSString* kAPI_KEY = @"bfjwrz7p5hzam6t79xbwhvpx";
static const NSString* kBaseURI = @"http://api.rottentomatoes.com/api/public/v1.0/";

static const NSString* kMoviesPath = @"movies.json";
static const NSString* kMoviesSearch = @"q";
static const NSString* kMoviesPageLimit = @"page_limit";
static const NSString* kMoviesPage = @"page";

static const NSString* kBoxOfficePath = @"lists/movies/box_office.json";

@implementation MADataSource

-(NSURL*) rottenTomatoesUrlForPath:(NSString*)relativePath params:(NSDictionary*) params {
    
    // Create a new mutable string starting with our base URI
    NSMutableString *urlString = [NSMutableString stringWithString:(NSString*)kBaseURI];
    
    // Append the relative path and our api key
    [urlString appendString:relativePath];
    [urlString appendFormat:@"?apikey=%@",kAPI_KEY];
    
    // Append all params in the dictionary as key = obj
    [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [urlString appendFormat:@"&%@=%@", key, obj];
    }];
    
    NSLog(@"Loading data from : '%@'", urlString);
    
    return [NSURL URLWithString:urlString];
}

#pragma mark - BoxOffice

-(void) loadBoxOfficeData:(MACallBackBlock)callback {
    self.dataType = kDataTypeMovieList;
    self.dataArray = [self boxOfficeArray];
    
    if (callback) {
        callback();
    }
}

-(NSArray*) boxOfficeArray {
    
    // Retrieve the current user country code
    NSLocale *locale = [NSLocale currentLocale];
    NSString *countryCode = [locale objectForKey: NSLocaleCountryCode];
    
    // Create the params dictionary
    NSDictionary *params = @{@"country": countryCode,
                             @"limit": @20};
    
    // Load data from the properly formed URL
    NSData *moviesData = [NSData dataWithContentsOfURL:[self rottenTomatoesUrlForPath:(NSString*)kBoxOfficePath params:params]];

    // Transform data into a NSDictionary with NSJSONSerialization
    NSError *error;
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:moviesData options:0 error:&error];
    
    if (error) {
        NSLog(@"Error getting movies : %@", error.localizedDescription);
    }
    
    // The movie list is under the key 'movies' (cf API doc) in the response so only return this part
    return jsonDict[@"movies"];
}

-(NSDictionary *) infoDictForItemAtIndex:(NSInteger)index {
    NSDictionary *baseDict = self.dataArray[index];
    NSDictionary *returnDict;
    
    switch (self.dataType) {
        case kDataTypeMovieList:
            returnDict = @{kInfoTitle: baseDict[@"title"],
                           kInfoSubtitle: [baseDict[@"year"] description],
                           kInfoImageURL: baseDict[@"posters"][@"thumbnail"]};
            break;
            
        default:
            break;
    }
    
    return returnDict;
}


@end
