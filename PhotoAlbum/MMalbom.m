//
//  MMalbom.m
//  PhotoAlbum
//
//  Created by Admin on 28.04.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "MMalbom.h"

@implementation MMalbom

@synthesize albomLabel, albomImage, albomImageFoto;

- (id)initWithDictionary:(NSDictionary*)albumDictionary {
    self = [super init];
    if (self) {
        albomLabel = [albumDictionary objectForKey:@"albomLabel"];
        albomImage = [albumDictionary objectForKey:@"albomImage"];
        albomImageFoto = [albumDictionary objectForKey:@"albomImageFoto"];
    }
    return self;
}

- (NSDictionary*)convertToDictionary {
    NSDictionary* albumDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:
                                     albomLabel, @"albomLabel",
                                     albomImage, @"albomImage",
                                     albomImageFoto, @"albomImageFoto",
                                     nil];
    return albumDictionary;
}

@end
