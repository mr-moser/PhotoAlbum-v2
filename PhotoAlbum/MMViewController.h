//
//  MMViewController.h
//  PhotoAlbum
//
//  Created by Admin on 28.04.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RNGridMenu.h"
#import <QuartzCore/QuartzCore.h>
#import "MMalbomCell.h"
#import "MMsingleton.h"
#import "MMalbom.h"
#import "KxMenu.h"

@interface MMViewController : UIViewController <UICollectionViewDelegateFlowLayout, RNGridMenuDelegate>

- (IBAction) showAlertCreateAlbom;

@end
