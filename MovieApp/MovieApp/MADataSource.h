//
//  MADataSource.h
//  MovieApp
//
//  Created by Nicolas Thenoz on 05/07/13.
//  Copyright (c) 2013 Xebia. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^MACallBackBlock)(void);

typedef enum {
    kDataTypeMovieList,
    kDataTypeMovieSingle
} kDataType;

static const NSString* kInfoTitle = @"title";
static const NSString* kInfoSubtitle = @"subtitle";
static const NSString* kInfoImageURL = @"image";

@interface MADataSource : NSObject

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, readwrite) kDataType dataType;

-(void) loadBoxOfficeData:(MACallBackBlock)callback;
-(NSDictionary *) infoDictForItemAtIndex:(NSInteger)index;

@end
