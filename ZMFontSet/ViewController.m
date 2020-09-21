//
//  ViewController.m
//  ZMFontSet
//
//  Created by zhoumimi on 2020/9/21.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *sectionArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    NSArray *familyNames = [UIFont familyNames];
    for (NSString *familyName in familyNames) {
        NSLog(@"%@ ==============",familyName);
        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        [self.sectionArray addObject:arr];
        for (NSString *fontName in fontNames) {
            NSLog(@" %@",fontName);
            [arr addObject:fontName];
        }
    }
    [self createUI];
}
- (void)createUI{
    [self.view addSubview:self.tableView];
    self.tableView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 48;
        _tableView.backgroundColor = UIColor.whiteColor;
        if(@available(iOS 11.0, *)){
            [_tableView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
        }
        _tableView.tableFooterView = [[UIView alloc] init];
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (NSMutableArray *)sectionArray{
    if (!_sectionArray) {
        _sectionArray = [[NSMutableArray alloc] init];
    }
    return _sectionArray;
}

#pragma mark - ___________________  tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sectionArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = self.sectionArray[section];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idd"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"idd"];
    }
    NSArray *arr = self.sectionArray[indexPath.section];
    NSString *fontName = arr[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:10];
    cell.textLabel.text = [NSString stringWithFormat:@"name: %@", fontName];
    cell.detailTextLabel.font = [UIFont fontWithName:fontName size:16];
    cell.detailTextLabel.text = @"中文字符- This is an example";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(16, 6, [UIScreen mainScreen].bounds.size.width, 17)];
    [view addSubview:titleLab];
    titleLab.text = [UIFont familyNames][section];
    titleLab.textColor = UIColor.redColor;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

@end
