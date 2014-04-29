//
//  MMPhotoController.m
//  PhotoAlbum
//
//  Created by Admin on 29.04.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "MMPhotoController.h"

@interface MMPhotoController ()

@property (nonatomic, strong) MMsingleton * mySingleton;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;

@end

@implementation MMPhotoController

@synthesize mySingleton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    mySingleton = [MMsingleton sharedInstance]; //создание объекта singleton
    self.backgroundImage.image = [UIImage imageNamed:[mySingleton imageForAlbumBackground]];
}
- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"%@", [mySingleton currentAlbom]);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
