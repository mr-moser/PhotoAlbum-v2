//
//  MMViewController.m
//  PhotoAlbum
//
//  Created by Admin on 28.04.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "MMViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "MMalbomCell.h"
#import "MMsingleton.h"
#import "MMalbom.h"

@interface MMViewController ()

@property (nonatomic, strong) MMsingleton * mySingleton;
@property (nonatomic, strong) IBOutlet UICollectionView * collectionView;
@property (weak, nonatomic) IBOutlet UIPageControl *albomPageControl;
@property (nonatomic, assign) BOOL isEditing;
@property (nonatomic, strong) id senderForDeleteAlbom;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *butAddAlbom;

@end

@implementation MMViewController

@synthesize isEditing, mySingleton;

- (void)viewDidLoad {
    [super viewDidLoad];
    mySingleton = [MMsingleton sharedInstance]; //создание объекта singleton

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init]; //создание UICollectionViewFlowLayout
    [flowLayout setItemSize:CGSizeMake(512, 335)]; //определение размеров
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal]; //определение типа прокрутки (горизонтальная)
    [flowLayout setSectionInset:UIEdgeInsetsMake(0, 0, 0, 0)]; //смещение секций внутри UICollectionViewFlowLayout
    [flowLayout setMinimumLineSpacing:0]; //расстояние между секциями
    [self.collectionView setCollectionViewLayout:flowLayout]; //запись UICollectionViewFlowLayout в self.collectionView
    [self.collectionView setPagingEnabled:YES]; //включение постраничной прокрутки
    [self updateControlPageNumber]; //Обновление кол-ва страниц (точки для прокрутки)
}
#pragma mark Добавление нового альбома
//=============== Добавление нового альбома
- (void) addNewItemInSection { //создание ячейки в self.collectionView
    [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:0 inSection:0]]];
    [self updateControlPageNumber]; //Обновление кол-ва страниц (точки для прокрутки)
}
#pragma mark Клик по элементу collectionView - отключение редактирования
//=============== Клик по элементу collectionView
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    isEditing = false; //включен ли режим редактирования
    self.butAddAlbom.enabled = true; //включение кнопки добавления альбома
    NSArray * arr = self.collectionView.subviews; //массив всех ячеек в self.collectionView
    for (int i = 0; i < [arr count]; i++) {
        if ([[arr objectAtIndex:i] isKindOfClass:[MMalbomCell class]]) //если ячейки является классом MMalbomCell
            [[[arr objectAtIndex:i] buttonClose] setAlpha:NO]; //скрытие кнопки удаления альбома
    }
}
#pragma mark Кол-во секций в collectionView
//=============== Кол-во секций в collectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView  {
    return 1;
}
#pragma mark Кол-во элементов в collectionView
//=============== Кол-во элементов в collectionView
- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[mySingleton arrayAlbom] count];
}
#pragma mark Формирование ячейки в collectionView
//=============== Формирование ячейки в collectionView
- (UICollectionViewCell *)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellId = @"Cell"; //определение идентификатора
    MMalbomCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath]; //создание ячейки
    
    MMalbom * tempAlbom = [[MMalbom alloc] init]; //создание временного альбома
    tempAlbom = [[mySingleton arrayAlbom] objectAtIndex:indexPath.row]; //запись в этот альбом альбомов из массива
    cell.albomImage.image = [UIImage imageNamed: tempAlbom.albomImage]; // присвоене ячейке картинки альбома
    cell.albomImageFoto.image = [UIImage imageNamed: tempAlbom.albomImageFoto]; // присвоене ячейке картинки альбома
    cell.albomLabel.text = tempAlbom.albomLabel; // присвоене ячейке названия альбома
    
    [cell.buttonClose addTarget:self action:@selector(buttonClosePress:) forControlEvents:UIControlEventTouchUpInside]; //привязка метода к кнопка закрытия альбома
    
    if (isEditing) //включен ли режим редактирования
        cell.buttonClose.alpha = 1;  //показывать кнопки удаления альбома
    else
        cell.buttonClose.alpha = 0; //скрытие кнопки удаления альбома
    
    UILongPressGestureRecognizer* longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressCell:)]; //создание длинного нажатия на ячейку
    [longPressGesture setMinimumPressDuration:1.0]; //интервал нажатия для вызова метода
    [cell addGestureRecognizer:longPressGesture]; //привязывание нажатия к ячейке
    
    return cell;
}
#pragma mark Удаление альбома
//=============== Удаление альбома
-(void)buttonClosePress:(id)sender{
    self.senderForDeleteAlbom = sender;
    [self showAlertDeleteAlbomConfirm];
}
#pragma mark Удаление альбома
//=============== Удаление альбома - подтверждение
-(void)deleteAlbomConfirm{
    UIView *senderButton = (UIView*) self.senderForDeleteAlbom;
    NSIndexPath *indexPath = [self.collectionView indexPathForCell: (UICollectionViewCell *)[[senderButton superview]superview]];
    [[mySingleton arrayAlbom] removeObjectAtIndex:indexPath.row];
    [self.collectionView deleteItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
    [self updateControlPageNumber];
    if ([[mySingleton arrayAlbom] count] == 0){
        self.butAddAlbom.enabled = true; //включение кнопки добавления альбома
        isEditing = false; //включен ли режим редактирования
    }
}
#pragma mark Обработка длинного нажатия на ячейку - включение редактирования
//=============== Обработка длинного нажатия на ячейку
- (void)longPressCell:(UISwipeGestureRecognizer *)gesture {
    isEditing = true; //включен ли режим редактирования
    self.butAddAlbom.enabled = false; //выключение кнопки добавления альбома
    if(UIGestureRecognizerStateBegan == gesture.state) {
        NSArray * arr = self.collectionView.subviews; //массив всех ячеек в self.collectionView
        for (int i = 0; i < [arr count]; i++) {
            if ([[arr objectAtIndex:i] isKindOfClass:[MMalbomCell class]]) { //если ячейки является классом MMalbomCell
                [[[arr objectAtIndex:i] buttonClose] setAlpha:YES]; //показывать кнопки удаления альбома
            }
        }
    }
}
#pragma mark Определение текущей страницы для page controller
//=============== Определение текущей страницы для page controller
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //CGFloat pageWidth = self.collectionView.frame.size.width;
    CGFloat pageWidth = 748;
    self.albomPageControl.currentPage = self.collectionView.contentOffset.x / pageWidth;
}
#pragma mark Обновление кол-ва страниц для page controller
//=============== Обновление кол-ва страниц для page controller
- (void)updateControlPageNumber {
    self.albomPageControl.numberOfPages = ceil((double)[[mySingleton arrayAlbom] count] / 4); // округление к большему для кол-ва страниц
}
#pragma mark Обработка запроса названия альбома
//=============== Обработка запроса названия альбома
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex { //метод обработки информации из алерта
    if (alertView.alertViewStyle == UIAlertViewStylePlainTextInput) {
        if (buttonIndex == 1) { //если нажата 2 кнопка Создать
            UITextField *textField = [alertView textFieldAtIndex:0]; //запись значения из текстового поля алерта
            if (![textField.text isEqualToString:@""]) { //проверка, не пустое ли текстовое поле
                MMalbom * albom = [[MMalbom alloc] init]; //создаём альбом
                albom.albomImage = [[mySingleton arrayImageForAlbum] objectAtIndex:arc4random_uniform(3)]; //картинка обложки
                albom.albomImageFoto = [[mySingleton arrayImageForAlbum] objectAtIndex:arc4random_uniform(3)]; //картинка фото в обложке
                albom.albomLabel = [NSString stringWithFormat:@"%@", textField.text]; //название альбома
                [[mySingleton arrayAlbom] insertObject:albom atIndex:0]; //запись в массив альбомов в singleton
                [self addNewItemInSection]; //создание ячейки в self.collectionView
            } else {
                [self showAlertEmptyNameAlbom];
            }
        }
    } else if (alertView.alertViewStyle == UIAlertViewStyleDefault) {
        if (buttonIndex == 1) { //если нажата 2 кнопка Создать
            [self deleteAlbomConfirm];
        }
    }
}
#pragma mark Запрос на подтверждение удаления
//=============== Запрос на подтверждение удаления
- (void) showAlertDeleteAlbomConfirm {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Удаление альбома" //определение всплывающего окна
                                                        message:@"Вы действительно хотите удалить этот альбом?"
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"Нет", @"Да", nil];
    alertView.alertViewStyle = UIAlertViewStyleDefault; //определение стиля окна
    [alertView show]; //вывод алерта на экран
}
#pragma mark Ошибка, если им альбома пустое
//=============== Ошибка, если им альбома пустое
- (void) showAlertEmptyNameAlbom {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Ошибка" //определение всплывающего окна
                                                        message:@"Название альбома не может быть пустым"
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"Ок", nil];
    alertView.alertViewStyle = UIAlertViewStyleDefault; //определение стиля окна
    [alertView show]; //вывод алерта на экран
}
#pragma mark Запрос названия альбома
//=============== Запрос названия альбома
- (IBAction) showAlertCreateAlbom {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Создание нового альбома" //определение всплывающего окна
                                                        message:@"Введите название альбома"
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"Отмена", @"Создать", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput; //определение стиля окна
    [alertView show]; //вывод алерта на экран
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end