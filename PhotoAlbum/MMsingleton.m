//
//  MMsingleton.m
//  PhotoAlbum
//
//  Created by Admin on 28.04.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "MMsingleton.h"

@implementation MMsingleton

@synthesize arrayAlbom, arrayImageForAlbum;

//======================================================================================================================
//Создание объекта mySingleton
//======================================================================================================================
static MMsingleton *sMySingleton = nil;

+ (MMsingleton *) sharedInstance {
    @synchronized(self) {
        if (sMySingleton == nil) {
            sMySingleton = [[MMsingleton alloc] init];
        }
    }
    return sMySingleton;
}
//======================================================================================================================
//Инициализация
//======================================================================================================================
- (id) init {
    self = [super init];
    if (self) {
        arrayAlbom = [NSMutableArray array];
        arrayImageForAlbum = [[NSMutableArray alloc] initWithObjects:
                              @"photoalbum-red.png",
                              @"photoalbum-blue.png",
                              @"photoalbum-green.png",
                              @"photoalbum-yellow.png",
                              nil];
    }
    return self;
}
@end
