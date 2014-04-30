//
//  MMsingleton.h
//  PhotoAlbum
//
//  Created by Admin on 28.04.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMalbom.h"

@interface MMsingleton : NSObject

@property (nonatomic, strong) NSMutableArray * arrayAlbom;
@property (nonatomic, strong) NSMutableArray * arrayPhoto;
@property (nonatomic, strong) NSMutableArray * arrayImageForAlbum;
@property (nonatomic, strong) NSMutableArray * arrayImageForAlbumBackground;
@property (nonatomic, strong) NSString * imageForAlbumBackground;
@property (nonatomic, strong) NSUserDefaults * userDefaults;
@property (nonatomic, strong) NSMutableString * currentAlbom;
@property (nonatomic, assign) int currentTemplate;

+ (MMsingleton *) sharedInstance;

@end
