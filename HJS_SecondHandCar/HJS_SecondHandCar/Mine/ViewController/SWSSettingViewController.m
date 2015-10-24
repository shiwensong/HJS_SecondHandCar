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

#pragma mark - Private

//计算出缓存文件的大小 （NSCachesDirectory目录下的文件大小）
- (CGFloat)computeFileTotalSize
{
    NSString *homeFilePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSFileManager *fileManger = [NSFileManager defaultManager];
    NSArray *subFilePathArray = [fileManger subpathsAtPath:homeFilePath];
    
    long long totalSize = 0;
    for (NSString *path  in subFilePathArray) {
        NSString *filePath = [homeFilePath stringByAppendingPathComponent:path];
        NSDictionary *dict = [fileManger attributesOfItemAtPath:filePath error:nil];
        long filesize = [[dict valueForKey:NSFileSize] longValue];
        
        totalSize += filesize;
    }
    
    return (CGFloat)totalSize / 1024 / 1024;
}

//清理我们的缓存文件
- (void)clearCachesFile
{
    NSString *homeFilePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *subFilePathArray = [fileManager subpathsAtPath:homeFilePath];
    for (NSString *path in subFilePathArray) {
        NSString *filePath = [homeFilePath stringByAppendingPathComponent:path];
        
        [fileManager removeItemAtPath:filePath error:nil];
    }
}

#pragma mark - IBAction

- (IBAction)backToMinepageButtonAction:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Protol Group

#pragma mark - UITableViewDataSource


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    UILabel *lable = (UILabel *)[cell viewWithTag:10];
    
    lable.text  = [NSString stringWithFormat:@"%.1f M",[self computeFileTotalSize]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1 ) {
        [self clearCachesFile];
        [TSHUDPrompt hudPromptWithTitle:@"清理完成" withImageName:@"has_been_sent" withSuperView:self.view withAfterDelay:1];
    }
    [tableView reloadData];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
