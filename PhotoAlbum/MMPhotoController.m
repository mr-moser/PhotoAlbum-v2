//
//  MMPhotoController.m
//  PhotoAlbum
//
//  Created by Admin on 29.04.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "MMPhotoController.h"

enum {
    template_1_ForPhotoView = 1,
    template_2_ForPhotoView = 2,
    template_3_ForPhotoView = 3,
    template_4_ForPhotoView = 4
};

@interface MMPhotoController ()

@property (nonatomic, strong) MMsingleton * mySingleton; 
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

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
    
    [mySingleton setCurrentTemplate: template_2_ForPhotoView];
    
    self.backgroundImage.image = [UIImage imageNamed:[mySingleton imageForAlbumBackground]];
    
    for (int i = 0; i < [[mySingleton arrayImageForAlbumBackground] count]; i++) {
        MMphoto * photo = [[MMphoto alloc] init];
        photo.photoImage = [[mySingleton arrayImageForAlbumBackground] objectAtIndex: i];
        photo.photoLabel = @"sdfsfsdfsdfsd";
        [[mySingleton arrayPhoto] addObject: photo];
    }
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init]; //создание UICollectionViewFlowLayout
    [flowLayout setItemSize:CGSizeMake(1024, 680)]; //определение размеров
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal]; //определение типа прокрутки (горизонтальная)
    [flowLayout setSectionInset:UIEdgeInsetsMake(0, 0, 0, 0)]; //смещение секций внутри UICollectionViewFlowLayout
    [flowLayout setMinimumLineSpacing:0]; //расстояние между секциями
    [self.collectionView setCollectionViewLayout:flowLayout]; //запись UICollectionViewFlowLayout в self.collectionView
    [self.collectionView setPagingEnabled:YES]; //включение постраничной прокрутки
    //[self updateControlPageNumber]; //Обновление кол-ва страниц (точки для прокрутки)
}
#pragma mark Кол-во секций в collectionView
//=============== Кол-во секций в collectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView  {
    return 1;
}
#pragma mark Кол-во элементов в collectionView
//=============== Кол-во элементов в collectionView
- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[mySingleton arrayPhoto] count];
}
#pragma mark Формирование ячейки в collectionView
//=============== Формирование ячейки в collectionView
- (UICollectionViewCell *)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([mySingleton currentTemplate] == template_1_ForPhotoView) {
        static NSString * cellId = @"Cell1"; //определение идентификатора
        MMphotoCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath]; //создание ячейки
        MMphoto * tempPhoto = [[MMphoto alloc] init]; //создание временного альбома
        tempPhoto = [[mySingleton arrayPhoto] objectAtIndex:indexPath.row]; //запись в этот альбом альбомов из массива
        cell.photoImage.image = [UIImage imageNamed: tempPhoto.photoImage]; // присвоене ячейке картинки альбома
        cell.photoLabel.text = tempPhoto.photoLabel; // присвоение ячейке названия альбома
        cell.photoLabel.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.5];
        
        return cell;
    }
    else if ([mySingleton currentTemplate] == template_2_ForPhotoView) {
        static NSString * cellId = @"Cell2"; //определение идентификатора
        MMphotoCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath]; //создание ячейки
        MMphoto * tempPhoto = [[MMphoto alloc] init]; //создание временного альбома
        tempPhoto = [[mySingleton arrayPhoto] objectAtIndex:indexPath.row]; //запись в этот альбом альбомов из массива
        cell.photoImage.image = [UIImage imageNamed: tempPhoto.photoImage]; // присвоене ячейке картинки альбома
        cell.photoLabel.text = tempPhoto.photoLabel; // присвоение ячейке названия альбома
        cell.photoLabel.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.5];
        
        tempPhoto = [[mySingleton arrayPhoto] objectAtIndex:indexPath.row + 1]; //запись в этот альбом альбомов из массива
        cell.photoImage2.image = [UIImage imageNamed: tempPhoto.photoImage]; // присвоене ячейке картинки альбома
        cell.photoLabel2.text = tempPhoto.photoLabel; // присвоение ячейке названия альбома
        cell.photoLabel2.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.5];
        
        return cell;
    }
    else if ([mySingleton currentTemplate] == template_3_ForPhotoView) {
        static NSString * cellId = @"Cell3"; //определение идентификатора
        MMphotoCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath]; //создание ячейки
        MMphoto * tempPhoto = [[MMphoto alloc] init]; //создание временного альбома
        tempPhoto = [[mySingleton arrayPhoto] objectAtIndex:indexPath.row]; //запись в этот альбом альбомов из массива
        cell.photoImage.image = [UIImage imageNamed: tempPhoto.photoImage]; // присвоене ячейке картинки альбома
        cell.photoLabel.text = tempPhoto.photoLabel; // присвоение ячейке названия альбома
        cell.photoLabel.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.5];
        
        tempPhoto = [[mySingleton arrayPhoto] objectAtIndex:indexPath.row + 1]; //запись в этот альбом альбомов из массива
        cell.photoImage2.image = [UIImage imageNamed: tempPhoto.photoImage]; // присвоене ячейке картинки альбома
        cell.photoLabel2.text = tempPhoto.photoLabel; // присвоение ячейке названия альбома
        cell.photoLabel2.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.5];
        
        tempPhoto = [[mySingleton arrayPhoto] objectAtIndex:indexPath.row + 2]; //запись в этот альбом альбомов из массива
        cell.photoImage3.image = [UIImage imageNamed: tempPhoto.photoImage]; // присвоене ячейке картинки альбома
        cell.photoLabel3.text = tempPhoto.photoLabel; // присвоение ячейке названия альбома
        cell.photoLabel3.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.5];
        
        return cell;
    }
    else if ([mySingleton currentTemplate] == template_4_ForPhotoView) {
        static NSString * cellId = @"Cell4"; //определение идентификатора
        MMphotoCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath]; //создание ячейки
        MMphoto * tempPhoto = [[MMphoto alloc] init]; //создание временного альбома
        tempPhoto = [[mySingleton arrayPhoto] objectAtIndex:indexPath.row]; //запись в этот альбом альбомов из массива
        cell.photoImage.image = [UIImage imageNamed: tempPhoto.photoImage]; // присвоене ячейке картинки альбома
        cell.photoLabel.text = tempPhoto.photoLabel; // присвоение ячейке названия альбома
        cell.photoLabel.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.5];
        
        cell.photoImage2.image = [UIImage imageNamed: tempPhoto.photoImage]; // присвоене ячейке картинки альбома
        cell.photoLabel2.text = tempPhoto.photoLabel; // присвоение ячейке названия альбома
        cell.photoLabel2.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.5];
        
        cell.photoImage3.image = [UIImage imageNamed: tempPhoto.photoImage]; // присвоене ячейке картинки альбома
        cell.photoLabel3.text = tempPhoto.photoLabel; // присвоение ячейке названия альбома
        cell.photoLabel3.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.5];
        
        cell.photoImage4.image = [UIImage imageNamed: tempPhoto.photoImage]; // присвоене ячейке картинки альбома
        cell.photoLabel4.text = tempPhoto.photoLabel; // присвоение ячейке названия альбома
        cell.photoLabel4.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.5];
        
        return cell;
    }
    
//    [cell.buttonClose addTarget:self action:@selector(buttonClosePress:) forControlEvents:UIControlEventTouchUpInside]; //привязка метода к кнопка закрытия альбома
//    
//    if (isEditing) //включен ли режим редактирования
//        cell.buttonClose.alpha = 1;  //показывать кнопки удаления альбома
//    else
//        cell.buttonClose.alpha = 0; //скрытие кнопки удаления альбома
    
//    UILongPressGestureRecognizer* longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressCell:)]; //создание длинного нажатия на ячейку
//    [longPressGesture setMinimumPressDuration:1.0]; //интервал нажатия для вызова метода
//    [cell addGestureRecognizer:longPressGesture]; //привязывание нажатия к ячейке
    return nil;
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"%@", [mySingleton currentAlbom]);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
