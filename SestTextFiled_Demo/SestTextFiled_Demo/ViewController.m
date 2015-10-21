//
//  ViewController.m
//  SestTextFiled_Demo
//
//  Created by tens on 15-10-21.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "ViewController.h"
#import "INSSearchBar.h"

@interface ViewController () <INSSearchBarDelegate>

@property (nonatomic, strong) INSSearchBar *searchBarWithoutDelegate;
@property (nonatomic, strong) INSSearchBar *searchBarWithDelegate;

@end

@implementation ViewController



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - view life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor colorWithRed:0.000 green:0.418 blue:0.673 alpha:1.000];
    
//    UILabel *descriptionLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 20.0, CGRectGetWidth(self.view.bounds) - 40.0, 20.0)];
//    descriptionLabel1.textColor = [UIColor whiteColor];
//    descriptionLabel1.font = [UIFont fontWithName:@"AvenirNext-Regular" size:16.0];
//    descriptionLabel1.text = @"Without delegate";
//    
//    [self.view addSubview:descriptionLabel1];
    
//    self.searchBarWithoutDelegate = [[INSSearchBar alloc] initWithFrame:CGRectMake(20.0, 40.0, CGRectGetWidth(self.view.bounds) - 40.0, 34.0)];
    
//    [self.view addSubview:self.searchBarWithoutDelegate];
    
//    UILabel *descriptionLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 120.0, CGRectGetWidth(self.view.bounds) - 40.0, 20.0)];
//    descriptionLabel2.textColor = [UIColor whiteColor];
//    descriptionLabel2.font = [UIFont fontWithName:@"AvenirNext-Regular" size:16.0];
//    descriptionLabel2.text = @"With delegate";
    
//    [self.view addSubview:descriptionLabel2];
    
    
    //CGRectMake(20.0, 140.0, 44.0, 34.0)
    
    self.searchBarWithDelegate = [[INSSearchBar alloc] initWithFrame:CGRectMake(20.0, 140.0, 88, 68)];
    self.searchBarWithDelegate.delegate = self;
    
    [self.view addSubview:self.searchBarWithDelegate];
}

#pragma mark - search bar delegate

- (CGRect)destinationFrameForSearchBar:(INSSearchBar *)searchBar
{
    return CGRectMake(20.0, 140.0, CGRectGetWidth(self.view.bounds) - 40.0, 34.0);
}


- (void)searchBar:(INSSearchBar *)searchBar willStartTransitioningToState:(INSSearchBarState)destinationState
{
    // Do whatever you deem necessary.
}

- (void)searchBar:(INSSearchBar *)searchBar didEndTransitioningFromState:(INSSearchBarState)previousState
{
    // Do whatever you deem necessary.
}

- (void)searchBarDidTapReturn:(INSSearchBar *)searchBar
{
    // Do whatever you deem necessary.
    // Access the text from the search bar like searchBar.searchField.text
}

- (void)searchBarTextDidChange:(INSSearchBar *)searchBar
{
    // Do whatever you deem necessary.
    // Access the text from the search bar like searchBar.searchField.text
}


@end
