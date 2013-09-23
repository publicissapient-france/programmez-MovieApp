//
// Created by Simone Civetta on 9/24/13.
// Copyright (c) 2013 Xebia. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "XBMappingProvider.h"

@interface MAPosters : NSObject<XBMappingProvider>

@property (nonatomic, strong) NSString *original;
@property (nonatomic, strong) NSString *detailed;
@property (nonatomic, strong) NSString *thumbnail;
@property (nonatomic, strong) NSString *profile;

@end