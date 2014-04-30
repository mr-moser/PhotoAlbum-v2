//
//  MMphoto.h
//  PhotoAlbum
//
//  Created by Admin on 30.04.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMphoto : NSObject

@property (weak, nonatomic) NSString *photoLabel;
@property (weak, nonatomic) NSString *photoImage;

- (id) initWithDictionary:(NSDictionary*)photoDictionary;
- (NSDictionary*) convertToDictionary;

@end
