//
//  IndexedTableview.h
//  面试之道
//
//  Created by 龙格 on 2019/2/2.
//  Copyright © 2019年 Paul Gao. All rights reserved.
//
//  带索引的talbeView

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol IndexedTableViewDataSource<NSObject>
- (NSArray <NSString *> *)indexTitlesForIndexedTableview:(UITableView *)tableView;
@end

@interface IndexedTableview : UITableView
@property (nonatomic, weak) id<IndexedTableViewDataSource> indexedDataSource;
@end

NS_ASSUME_NONNULL_END
