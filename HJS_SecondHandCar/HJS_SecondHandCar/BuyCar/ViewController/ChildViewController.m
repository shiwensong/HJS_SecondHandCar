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
#import "NSString+ToPinyin.h"
#import "ChildDetailViewController.h"

@interface ChildViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

//声明一个数组来保存我们所有地名的中文全名
@property  (strong, nonatomic) NSMutableArray *chineseNameArray;

//声明一个数组，来保存我们的首字母
@property (strong, nonatomic) NSMutableArray *firstNameArray;

//声明一个字典，来保存我们分组后的信息
@property (strong, nonatomic) NSMutableDictionary *allPlaceGroupDictionary;

//保存我们详细页面需要的数据
@property (strong, nonatomic) NSMutableDictionary *detailPageDictionary;

//保存本页的数据的首字母索引
@property (strong, nonatomic) NSArray *allTitles;

//保存我们详细页面的数据的首字母
@property (strong, nonatomic) NSArray *detailTitles;

// 这里我们点击省份的cell的时候，我们需要跳转到具体的城市的tableView里面去，我们先保存我们的城市的数组
@property (strong, nonatomic) NSMutableArray *allCityArray;



//新建一个tableView添加到我们的页面中
@property (strong, nonatomic) UITableView *newTableView;

@end

@implementation ChildViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self disposalData];
    
    // 设置索引视图的颜色
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    self.tableView.sectionIndexColor = [UIColor grayColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UIResponder

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pageBack" object:nil];
    
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

//将我们的弹出视图的信息保存成我们想要的样子
- (void)disposalData{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"area" ofType:@"plist"];

    NSDictionary *allDataDictionary = [NSDictionary dictionaryWithContentsOfFile:filePath];
    for (int i = 0; i < allDataDictionary.count; i ++) {
        NSDictionary *dicitonary = [allDataDictionary objectForKey:[NSString stringWithFormat:@"%d",i]];
//        NSLog(@"%@",[dicitonary allKeys]);
        NSString *firstKey = [[dicitonary allKeys] firstObject];
        [self.chineseNameArray addObject:firstKey];
        dicitonary = [dicitonary objectForKey:firstKey];
        for (int j = 0; j < dicitonary.count; j ++) {
//            NSLog(@"%@",dicitonary);
            NSDictionary *secondDictionary = [dicitonary objectForKey:[NSString stringWithFormat:@"%d",j]];
            NSArray *array = [secondDictionary allKeys];
            for ( int x = 0; x < array.count; x++) {
                NSString *secondKey = array[x];
                NSArray *endArray = secondDictionary[secondKey];
                [self.allCityArray addObject:endArray];
//                NSLog(@"%@",firstKey);
                [self classifyCityGroup:[[[firstKey topinyin] substringToIndex:1] uppercaseString]withChineseName:endArray];
            }
        }
    }
    
    self.detailTitles = [self.detailPageDictionary allKeys];
    self.detailTitles = [self.detailTitles sortedArrayUsingSelector:@selector(compare:)];
    
    for (NSString *placeName in self.chineseNameArray) {
        //转化成我们的拼音name
        NSString *pinyinName = [placeName topinyin];
        
        //保存首字母
        NSString *firstName = [[pinyinName substringToIndex:1] uppercaseString];
        [self.firstNameArray addObject:firstName];
        
        //分组保存我们的数据
        [self classifySepllName:firstName withChineseName:placeName];
    
    }
    
    self.allTitles = [self.allPlaceGroupDictionary allKeys];
    self.allTitles = [self.allTitles sortedArrayUsingSelector:@selector(compare:)];
    [self.tableView reloadData];
    
}

//这里是将我们本页的tableView的数据进行分裂
- (void)classifySepllName:(NSString *)firstName withChineseName:(NSString *)chineseName{

    NSMutableArray *classifyArray = self.allPlaceGroupDictionary[firstName];
    if (!classifyArray) {
        classifyArray = [NSMutableArray array];
        [self.allPlaceGroupDictionary setObject:classifyArray forKey:firstName];
    }
    [classifyArray addObject:chineseName];
    
}

//这个方法是保存我们的点击省份，跳转过去的页面需要的数据
- (void)classifyCityGroup:(NSString *)firstName withChineseName:(NSArray *)cityArray{
    
    NSMutableArray *classifyArray = self.detailPageDictionary[firstName];
    if (!classifyArray) {
        classifyArray = [NSMutableArray array];
        [self.detailPageDictionary setObject:classifyArray forKey:firstName];
    }
    [classifyArray addObject:cityArray];
    
}

#pragma mark -  Protol Group

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.allTitles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *sectionPlaces = self.allPlaceGroupDictionary[self.allTitles[section]];
    return sectionPlaces.count;
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SWSChildCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SWSChildCell" forIndexPath:indexPath];
    NSArray *array = self.allPlaceGroupDictionary[self.allTitles[indexPath.section]];
    cell.childPlaceLable.text = array[indexPath.row];
    return cell;
}

#pragma mark - 正在做

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *shortArray = self.allPlaceGroupDictionary[self.allTitles[indexPath.section]];
    NSString *placeString = [shortArray firstObject];
    
    [self.delegate locationButtonTitle:placeString];
    
    
    
    NSArray *array = self.detailPageDictionary[self.allTitles[indexPath.section]];
    
    
    //这里有问题
    CGRect rect = self.newTableView.frame;
    rect.origin.x = TScreenWidth;
    self.newTableView.frame = rect;
    [UIView animateWithDuration:1 animations:^{
        CGRect newRect = self.newTableView.frame;
        newRect.origin.x = 85;
        self.newTableView.frame = newRect;
    }];
    
}


// 设置索引视图的标题
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.allTitles;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return self.allTitles[section];
}

#pragma mark - Custom Accessor

- (NSMutableArray *)chineseNameArray{
    if (!_chineseNameArray) {
        _chineseNameArray = [NSMutableArray array];
    }
    return _chineseNameArray;
}

- (NSMutableArray *)firstNameArray{
    if (!_firstNameArray) {
        _firstNameArray = [NSMutableArray array];
    }
    return _firstNameArray;
}

-(NSMutableDictionary *)allPlaceGroupDictionary{
    if (!_allPlaceGroupDictionary) {
        _allPlaceGroupDictionary = [NSMutableDictionary dictionary];
    }
    return _allPlaceGroupDictionary;
}

- (NSMutableDictionary *)detailPageDictionary{
    if (!_detailPageDictionary) {
        _detailPageDictionary = [NSMutableDictionary dictionary];
    }
    return _detailPageDictionary;
}

- (NSArray *)allTitles{
    if (!_allTitles) {
        
        _allTitles = [NSArray array];
    }
    return _allTitles;
}

- (NSMutableArray *)allCityArray{
    if (!_allCityArray) {
        _allCityArray = [NSMutableArray array];
    }
    return _allCityArray;
}

- (UITableView *)newTableView{
    if (!_newTableView) {
        _newTableView = [[UITableView alloc] initWithFrame:CGRectMake(85, 0, TScreenWidth - 85, TScreenHeight) style:UITableViewStylePlain];
        _newTableView.dataSource = self;
        _newTableView.delegate = self;
    }
    return _newTableView;
}

@end
