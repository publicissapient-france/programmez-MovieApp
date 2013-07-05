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
    kDataTypeMovie
} kDataType;

#define kInfoTitle @"title"
#define kInfoSubtitle @"subtitle"
#define kInfoImage @"image"

@interface MADataSource : NSObject <UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, readwrite) kDataType dataType;

-(void) loadBoxOfficeData:(MACallBackBlock)callback;
-(NSDictionary*) infoDictForCellAtIndexPath:(NSIndexPath*)indexPath;

@end
