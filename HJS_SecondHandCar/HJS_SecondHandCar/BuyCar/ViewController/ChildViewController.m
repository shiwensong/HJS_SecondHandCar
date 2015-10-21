//
//  ChildViewController.m
//  HJS_SecondHandCar
//
//  Created by tens on 15-10-21.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "ChildViewController.h"
#import "SWSChildCell.h"
#import "TSJsonData.h"

@interface ChildViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (strong, nonatomic) NSMutableArray *placeNames;
@property (strong, nonatomic) NSArray *firstNames;
@property (strong, nonatomic) NSMutableDictionary *placeDictionnary;
@end

@implementation ChildViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadProvinceLocationJsonData];
    
    // 设置索引视图的颜色
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    self.tableView.sectionIndexColor = [UIColor grayColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UIResponder

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];

    [UIView animateWithDuration:1 animations:^{
        
        CGRect lastFrame = self.view.frame;
        lastFrame.origin.x = TScreenWidth;
        self.view.frame = lastFrame;
    }];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
    });
}

#pragma mark - Private

- (void)loadProvinceLocationJsonData{
    
    NSDictionary *infoDictionary =  [TSJsonData JsonDataToObjectWithFileName:ProvinceLocationJson];
    NSArray *allkeys = infoDictionary.allKeys;
    NSMutableArray *firstNameArray = [NSMutableArray array];
    
    for (int i = 0; i < allkeys.count; i++) {
        NSString *key = allkeys[i];
        NSDictionary *dictionary = infoDictionary[key];
        [self.placeNames addObject:dictionary[@"PN"]];
        [firstNameArray addObject:dictionary[@"FL"]];
    }
    
//    firstNameArray = [self arrayWithMemberIsOnly:firstNameArray];
    
    NSArray *fistname = [NSArray arrayWithArray:firstNameArray];
    self.firstNames = [fistname sortedArrayUsingSelector:@selector(compare:)];
    
    //保存数据到我们的字典中
    for (int i = 0; i < self.firstNames.count; i++) {
        
        [self setFriendsName:self.firstNames[i] withPlaceName:self.placeNames[i]];
    }
    
    self.firstNames = self.placeDictionnary.allKeys;
    NSArray *fistname1 = [NSArray arrayWithArray:self.firstNames];
    self.firstNames = [fistname1 sortedArrayUsingSelector:@selector(compare:)];
}

//去除我们数组中重复的key
- (NSMutableArray *)arrayWithMemberIsOnly:(NSMutableArray *)array
{
    NSMutableArray *categoryArray = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < [array count]; i++) {
        if ([categoryArray containsObject:[array objectAtIndex:i]] == NO) {
            [categoryArray addObject:[array objectAtIndex:i]];
        }
    }
                                          
    return categoryArray;
}


// 将数据保存为字典 firstChar : [.....];
- (void)setFriendsName:(NSString *)firstString withPlaceName:(NSString *)placeName
{
    NSMutableArray *sectionFriends = self.placeDictionnary[firstString];
    if (!sectionFriends) {
        sectionFriends = [[NSMutableArray alloc] init];
        [self.placeDictionnary setObject:sectionFriends forKey:firstString];
    }
    [sectionFriends addObject:placeName];
}

//设置我们cell的数据
- (void)setCellDatas:(SWSChildCell *)cell withIndexPath:(NSIndexPath *)indexPath
{
    cell.childPlaceLable.text = self.placeNames[indexPath.row];
}

#pragma mark -  Protol Group

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.placeDictionnary.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *sectionFriends = self.placeDictionnary[self.firstNames[section]];
    return sectionFriends.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SWSChildCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SWSChildCell" forIndexPath:indexPath];
    [self setCellDatas:cell withIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%s", __func__);
}


// 设置索引视图的标题
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSLog(@"%@",self.firstNames);
    return self.self.firstNames;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 20;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return self.firstNames[section];
}

#pragma mark - Custom Accessor

- (NSArray *)firstNames{
    if (!_firstNames) {
        _firstNames = [NSArray array];
    }
    return _firstNames;
}

- (NSMutableArray *)placeNames{
    if (!_placeNames) {
        _placeNames = [NSMutableArray array];
    }
    return _placeNames;
}

- (NSMutableDictionary *)placeDictionnary{
    if (!_placeDictionnary) {
        _placeDictionnary = [NSMutableDictionary dictionary];
    }
    return _placeDictionnary;
}

@end
