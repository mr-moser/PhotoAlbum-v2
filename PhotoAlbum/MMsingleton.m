//
//  MMsingleton.m
//  PhotoAlbum
//
//  Created by Admin on 28.04.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "MMsingleton.h"
#import "MMalbom.h"

@implementation MMsingleton

@synthesize arrayAlbom, arrayImageForAlbum, arrayImageForAlbumBackground, imageForAlbumBackground, userDefaults;

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
        
        [self loadAlbomFromPlist];
        
        //========= ПОДПИСКА НА СОБЫТИЕ ПРИ "СВОРАЧИВАНИИ" ПРИЛОЖЕНИЯ
        UIApplication *app = [UIApplication sharedApplication];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationWillResignActive:)
                                                     name:UIApplicationWillResignActiveNotification
                                                   object:app];
        
        
        userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *result = [userDefaults objectForKey:@"imageForAlbumBackground"];
        if ([result length]) {
            imageForAlbumBackground = [userDefaults objectForKey:@"imageForAlbumBackground"];
        }
    }
    return self;
}
//======================================================================================================================
//Работа с файлами plist для альбомов
//======================================================================================================================
- (void)applicationWillResignActive:(NSNotification *)notification {
    [self saveAlbomToPlist];
    [userDefaults setObject:imageForAlbumBackground forKey:@"imageForAlbumBackground"];
}
- (NSString *)dataALbomFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"albomData.plist"];
}
-(void)saveAlbomToPlist { //сохранение файлов plist
    NSMutableArray *arrayForSave; //массив для сохранения
    NSString *filePath; //будущий путь к файлу
    arrayForSave = [[NSMutableArray alloc] initWithCapacity:[arrayAlbom count]]; //создать массив NSArray состоящий из экземпляров NSDictionary
    for (int i = 0; i < [arrayAlbom count]; i++) { //добавляем в arrayForSave экземпляры NSDictionary
        MMalbom *newAlbom = (MMalbom*)[arrayAlbom objectAtIndex:i]; //получаем объект альбома
        NSDictionary* aDict = [newAlbom convertToDictionary]; //конвертируем в NSDictionary для записи
        [arrayForSave addObject:aDict]; //добавляем в массив для записи
    }
    filePath = [self dataALbomFilePath]; //получаем путь к файлу
    [arrayForSave writeToFile:filePath atomically:YES]; //записать этот массив в файл
}
-(void)loadAlbomFromPlist { //загрузка из файла plist
    NSString *filePath; //будущий путь к файлу
    filePath = [self dataALbomFilePath]; //получаем путь к файлу
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) { //проверка: если файл существует
        NSArray *arrayFromFile = [[NSArray alloc] initWithContentsOfFile:filePath]; //считать массив словарей из файла
        for (int i = 0; i < arrayFromFile.count; i++) { //перебирая массив
            NSDictionary* aDict = (NSDictionary*)[arrayFromFile objectAtIndex:i]; //считываем словарь, как элемент массива
            MMalbom *newAlbom = [[MMalbom alloc] initWithDictionary:aDict]; //перегнать все NSDictionary в Album
            [arrayAlbom addObject:newAlbom]; //добавить newAlbum в массив альбомов
        }
    }
}

@end










