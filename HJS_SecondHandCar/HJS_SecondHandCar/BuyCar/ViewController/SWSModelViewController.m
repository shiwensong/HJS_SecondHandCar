//
//  SWSModelViewController.m
//  HJS_SecondHandCar
//
//  Created by tens on 15-10-22.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "SWSModelViewController.h"

@interface SWSModelViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate,UISearchDisplayDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation SWSModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:12/255.0 green:88/255.0 blue:175/255.0 alpha:1];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private

- (void)setSearchBarAnimate{

    CGRect frame = self.searchBar.frame;
    frame.size.width = 100;
    frame.origin.x = 100;
    self.searchBar.frame = frame;
    self.searchBar.hidden = NO;
    
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame2 = self.searchBar.frame;
        frame2.origin.x = 10;
        
        frame2.size.width = 300;
        self.searchBar.frame = frame2;
    }];
}

#pragma mark - Protol Group

#pragma mark - UISearchBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    
    [self setSearchBarAnimate];
    
    return YES;
}

#pragma mark  - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = [@(indexPath.row) stringValue];
    return cell;
}

@end
