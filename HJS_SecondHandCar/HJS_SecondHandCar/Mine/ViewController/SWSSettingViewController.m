//
//  SWSSettingViewController.m
//  HJS_SecondHandCar
//
//  Created by tens on 15-10-23.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "SWSSettingViewController.h"
#import "CollectionCell.h"

@interface SWSSettingViewController () <UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation SWSSettingViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - IBAction

- (IBAction)backToMinepageButtonAction:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Protol Group

#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *imageNames = @[@"d23af47107542497880abcd812d4c209",
                            @"08a771bd6b83cfb5f773fd18d59d4d0a",
                            @"017448a6e3e892e440b9b225278b524e"
                            ];
    NSArray *titles = @[@"汽车之家",
                        @"汽车报价",
                        @"违章查询"];
    
    CollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCell" forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:imageNames[indexPath.item]];
    cell.textLabel.text = titles[indexPath.item];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(60, 80);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10,10 , 0, 0);
}


@end
