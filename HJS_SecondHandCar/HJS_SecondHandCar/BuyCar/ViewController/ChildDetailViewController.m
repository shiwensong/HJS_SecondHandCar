//
//  ChildDetailViewController.m
//  HJS_SecondHandCar
//
//  Created by tens on 15-10-26.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "ChildDetailViewController.h"
#import "DetailChildCell.h"

@interface ChildDetailViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ChildDetailViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@",self.placeArray);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/***
 detailCell
 */

#pragma mark - Protol Group

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.placeArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailChildCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailChildCell"];
    cell.detailPlaceLable.text = self.placeArray[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate



@end
