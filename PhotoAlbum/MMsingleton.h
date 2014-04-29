//
//  MMsingleton.h
//  PhotoAlbum
//
//  Created by Admin on 28.04.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMsingleton : NSObject

@property (nonatomic, strong) NSMutableArray * arrayAlbom;
@property (nonatomic, strong) NSMutableArray * arrayImageForAlbum;
@property (nonatomic, strong) NSMutableArray * arrayImageForAlbumBackground;

+ (MMsingleton *) sharedInstance;

@end
