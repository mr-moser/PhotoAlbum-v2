//
//  MMsingleton.m
//  PhotoAlbum
//
//  Created by Admin on 28.04.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "MMsingleton.h"

@implementation MMsingleton

@synthesize arrayAlbom, arrayImageForAlbum, arrayImageForAlbumBackground;

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
                              @"photoalbum-blue.png",
                              @"photoalbum-green.png",
                              @"photoalbum-red.png",
                              @"photoalbum-yellow.png",
                              nil];
        arrayImageForAlbumBackground = [[NSMutableArray alloc] initWithObjects:
                              @"fon1.jpg", @"fon2.jpg", @"fon3.jpg", @"fon4.jpg", @"fon5.jpg",
                              @"fon6.jpg", @"fon7.jpg", @"fon8.jpg", @"fon9.jpg",
                              nil];
    }
    return self;
}
@end