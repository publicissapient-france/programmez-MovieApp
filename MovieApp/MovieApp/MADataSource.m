//
//  MADataSource.m
//  MovieApp
//
//  Created by Nicolas Thenoz on 05/07/13.
//  Copyright (c) 2013 Xebia. All rights reserved.
//

#import "MADataSource.h"

#define kAPI_KEY @"bfjwrz7p5hzam6t79xbwhvpx"
#define kBaseURI @"http://api.rottentomatoes.com/api/public/v1.0"

#define kMoviesPath @"movies.json"
#define kMoviesSearch @"q"
#define kMoviesPageLimit @"page_limit"
#define kMoviesPage @"page"

#define kBoxOfficePath @"lists/movies/box_office.json"

@implementation MADataSource

-(NSData*) rottenTomatoesDataForPath:(NSString*)relativePath params:(NSDictionary*)params{
    
    NSMutableString *urlString = [NSMutableString stringWithString:[kBaseURI stringByAppendingPathComponent:relativePath]];
    
    [urlString appendFormat:@"?apikey=%@",kAPI_KEY];
    
    [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [urlString appendFormat:@"&%@=%@",key,obj];
    }];
    
    return [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
}

-(NSDictionary *) infoDictForCellAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *baseDict = self.dataArray[indexPath.row];
    NSDictionary *returnDict;
    
    switch (self.dataType) {
        case kDataTypeMovie:
            returnDict = @{kInfoTitle: baseDict[@"title"],
                           kInfoSubtitle: [baseDict[@"year"] description],
                           kInfoImage: baseDict[@"posters"][@"thumbnail"]};
            break;
            
        default:
            break;
    }
    
    return returnDict;
}

#pragma mark - BoxOffice

-(void) loadBoxOfficeData:(MACallBackBlock)callback {
    self.dataType = kDataTypeMovie;
    self.dataArray = [self boxOfficeArray];
    
    if (callback) {
        callback();
    }
}

-(NSArray*) boxOfficeArray {
    NSData *moviesData = [self rottenTomatoesDataForPath:kBoxOfficePath params:nil];

    NSError *error;
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:moviesData options:0 error:&error];
    
    if (error) {
        NSLog(@"Error getting movies : %@", error.localizedDescription);
    }
    
    return jsonDict[@"movies"];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[UITableViewCell alloc] init];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


@end
