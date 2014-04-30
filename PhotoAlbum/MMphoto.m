//
//  MMphoto.m
//  PhotoAlbum
//
//  Created by Admin on 30.04.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "MMphoto.h"

@implementation MMphoto

@synthesize photoLabel, photoImage;

- (id)initWithDictionary:(NSDictionary*)albumDictionary {
    self = [super init];
    if (self) {
        photoLabel = [albumDictionary objectForKey:@"photoLabel"];
        photoImage = [albumDictionary objectForKey:@"photoImage"];
    }
    return self;
}

- (NSDictionary*)convertToDictionary {
    NSDictionary* albumDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:
                                     photoLabel, @"photoLabel",
                                     photoImage, @"photoImage",
                                     nil];
    return albumDictionary;
}

@end
