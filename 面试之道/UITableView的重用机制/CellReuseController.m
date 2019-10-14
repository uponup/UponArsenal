//
//  CellReuseController.m
//  面试之道
//
//  Created by 龙格 on 2019/2/2.
//  Copyright © 2019年 Paul Gao. All rights reserved.
//

#import "CellReuseController.h"
#import "IndexedTableview.h"
@interface CellReuseController ()<UITableViewDelegate, UITableViewDataSource, IndexedTableViewDataSource>
@property (nonatomic, strong) IBOutlet UIButton *reloadButton;
@property (nonatomic, strong) IBOutlet IndexedTableview *tableview;
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation CellReuseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.yellowColor;
    [self.reloadButton addTarget:self action:@selector(reloadButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.tableview.indexedDataSource = self;
    [self.tableview registerClass:[UITableViewCell self] forCellReuseIdentifier:@"cell"];
}
- (void)reloadButtonAction{
    [self.tableview reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = self.dataArr[indexPath.row];
    return cell;
}
- (NSArray<NSString *> *)indexTitlesForIndexedTableview:(UITableView *)tableView{
    static BOOL change = YES;
    if (change) {
        change = NO;
        return @[@"A", @"B", @"C", @"D", @"E", @"F"];
    }else{
        change = YES;
        return @[@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H",@"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P"];
    }
}

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray arrayWithCapacity:0];
        for (NSInteger i=0; i<39; i++) {
            [_dataArr addObject:[NSString stringWithFormat:@"%ld", i]];
        }
    }
    return _dataArr;
}
@end
